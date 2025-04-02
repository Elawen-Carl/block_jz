package com.ruoyi.framework.aspectj;

import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.utils.DateUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.Date;

/**
 * 实体自动填充AOP - 自动填充BaseEntity中的创建时间和更新时间
 * 同时处理具有特殊日期字段的实体类
 *
 * @author ruoyi
 */
@Aspect
@Component
public class EntityAutoFillAspect {
    private static final Logger log = LoggerFactory.getLogger(EntityAutoFillAspect.class);

    /**
     * 拦截所有Service实现类的insert方法，自动填充createTime
     */
    @Before("execution(* com.ruoyi..service.*.*ServiceImpl.insert*(..))")
    public void beforeInsert(JoinPoint joinPoint) {
        handleCreateTime(joinPoint.getArgs());
    }

    /**
     * 拦截所有Service实现类的update方法，自动填充updateTime
     */
    @Before("execution(* com.ruoyi..service.*.*ServiceImpl.update*(..))")
    public void beforeUpdate(JoinPoint joinPoint) {
        handleUpdateTime(joinPoint.getArgs());
    }

    /**
     * 处理创建时间
     *
     * @param args 方法参数
     */
    private void handleCreateTime(Object[] args) {
        if (args == null || args.length == 0) {
            return;
        }

        Date now = DateUtils.getNowDate();
        
        for (Object arg : args) {
            if (arg instanceof BaseEntity) {
                BaseEntity entity = (BaseEntity) arg;
                if (entity.getCreateTime() == null) {
                    entity.setCreateTime(now);
//                    log.debug("自动填充BaseEntity.createTime: {}", now);
                }
                
                // 处理特殊实体类可能存在的其他日期字段
                handleSpecialEntityCreateTime(arg, now);
            }
        }
    }

    /**
     * 处理更新时间
     *
     * @param args 方法参数
     */
    private void handleUpdateTime(Object[] args) {
        if (args == null || args.length == 0) {
            return;
        }

        Date now = DateUtils.getNowDate();
        
        for (Object arg : args) {
            if (arg instanceof BaseEntity) {
                BaseEntity entity = (BaseEntity) arg;
                entity.setUpdateTime(now);
//                log.debug("自动填充BaseEntity.updateTime: {}", now);
                
                // 处理特殊实体类可能存在的其他日期字段
                handleSpecialEntityUpdateTime(arg, now);
            }
        }
    }
    
    /**
     * 处理特殊实体类的创建时间字段
     * 
     * @param entity 实体对象
     * @param now 当前时间
     */
    private void handleSpecialEntityCreateTime(Object entity, Date now) {
        String className = entity.getClass().getSimpleName();
        
        try {
            // 处理WasteRecord的createdAt字段
            if ("WasteRecord".equals(className)) {
                Method getCreatedAt = entity.getClass().getMethod("getCreatedAt");
                if (getCreatedAt != null && getCreatedAt.invoke(entity) == null) {
                    Method setCreatedAt = entity.getClass().getMethod("setCreatedAt", Date.class);
                    if (setCreatedAt != null) {
                        setCreatedAt.invoke(entity, now);
//                        log.debug("自动填充WasteRecord.createdAt: {}", now);
                    }
                }
            }
            
            // 可以根据需要在这里添加其他特殊实体类的处理
            
        } catch (Exception e) {
            log.warn("处理特殊实体类创建时间字段失败: {}", e.getMessage());
        }
    }
    
    /**
     * 处理特殊实体类的更新时间字段
     * 
     * @param entity 实体对象
     * @param now 当前时间
     */
    private void handleSpecialEntityUpdateTime(Object entity, Date now) {
        // 暂时不需要处理其他更新时间字段
        // 如果将来有需要，可以在这里添加相应的逻辑
    }
} 