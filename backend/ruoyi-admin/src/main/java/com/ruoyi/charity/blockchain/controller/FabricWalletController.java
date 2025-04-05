package com.ruoyi.charity.blockchain.controller;

import com.ruoyi.charity.blockchain.util.FabricWalletUtil;
import com.ruoyi.common.core.domain.AjaxResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * 区块链钱包控制器 - 提供区块链身份钱包管理功能
 *
 * @author ruoyi
 * @date 2023-04-21
 */
@Api(tags = "区块链钱包管理", description = "提供Fabric区块链钱包和身份管理功能")
@RestController
@RequestMapping("/blockchain/wallet")
public class FabricWalletController {
    private static final Logger logger = LoggerFactory.getLogger(FabricWalletController.class);
    
    @Autowired
    private FabricWalletUtil walletUtil;
    
    @Value("${fabric.walletPath}")
    private String walletPath;

    /**
     * 查询钱包身份列表
     *
     * @return 身份列表
     */
    @ApiOperation(value = "查询身份列表", notes = "获取区块链钱包中所有可用的身份列表")
    @GetMapping("/list")
    public AjaxResult listIdentities() {
        logger.info("查询钱包身份列表");

        try {
            Path walletDir = Paths.get(walletPath);
            List<String> identities = new ArrayList<>();
            
            if (Files.exists(walletDir)) {
                try (Stream<Path> paths = Files.list(walletDir)) {
                    identities = paths.filter(Files::isDirectory)
                                      .map(path -> path.getFileName().toString())
                                      .collect(Collectors.toList());
                }
            }

            return AjaxResult.success("查询成功", identities);
        } catch (IOException e) {
            logger.error("查询钱包身份失败", e);
            return AjaxResult.error("查询钱包身份失败: " + e.getMessage());
        }
    }

    /**
     * 重置区块链钱包
     *
     * @return 重置结果
     */
    @ApiOperation(value = "重置钱包", notes = "重置区块链钱包，删除所有身份信息")
    @GetMapping("/reset")
    public AjaxResult resetWallet() {
        logger.info("重置钱包");

        try {
            walletUtil.clearWallet();
            return AjaxResult.success("钱包重置成功");
        } catch (Exception e) {
            logger.error("钱包重置失败", e);
            return AjaxResult.error("钱包重置失败: " + e.getMessage());
        }
    }

    /**
     * 删除指定身份
     *
     * @param identity 身份名称
     * @return 删除结果
     */
    @ApiOperation(value = "删除身份", notes = "从区块链钱包中删除指定的身份")
    @ApiImplicitParam(name = "identity", value = "身份名称", required = true, dataType = "String", paramType = "path", example = "admin")
    @GetMapping("/delete/{identity}")
    public AjaxResult deleteIdentity(@PathVariable String identity) {
        logger.info("删除身份: {}", identity);

        try {
            walletUtil.deleteIdentity(identity);
            return AjaxResult.success("身份删除成功");
        } catch (Exception e) {
            logger.error("身份删除失败", e);
            return AjaxResult.error("身份删除失败: " + e.getMessage());
        }
    }

    /**
     * 获取钱包信息
     *
     * @return 钱包详情
     */
    @ApiOperation(value = "获取钱包信息", notes = "获取区块链钱包的详细信息，包括路径、状态和内容")
    @GetMapping("/info")
    public AjaxResult getWalletInfo() {
        logger.info("查询钱包信息");

        try {
            Path walletDir = Paths.get(walletPath);
            boolean exists = Files.exists(walletDir);
            
            AjaxResult result = AjaxResult.success("查询成功");
            result.put("walletPath", walletPath);
            result.put("exists", exists);
            result.put("isDirectory", exists && Files.isDirectory(walletDir));
            
            if (exists) {
                try (Stream<Path> paths = Files.list(walletDir)) {
                    List<String> items = paths.map(path -> path.getFileName().toString())
                                             .collect(Collectors.toList());
                    result.put("items", items);
                }
            }

            return result;
        } catch (IOException e) {
            logger.error("查询钱包信息失败", e);
            return AjaxResult.error("查询钱包信息失败: " + e.getMessage());
        }
    }
}