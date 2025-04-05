package com.ruoyi.charity.blockchain.controller;

import com.ruoyi.charity.blockchain.util.FabricDiagnosticTool;
import com.ruoyi.common.core.domain.AjaxResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * 区块链诊断控制器 - 提供区块链网络诊断功能
 *
 * @author ruoyi
 * @date 2023-04-21
 */
@Api(tags = "区块链诊断服务", description = "提供Fabric区块链网络诊断和状态检查功能")
@RestController
@RequestMapping("/blockchain/diagnostic")
public class FabricDiagnosticController {
    private static final Logger logger = LoggerFactory.getLogger(FabricDiagnosticController.class);
    
    @Autowired
    private FabricDiagnosticTool diagnosticTool;

    /**
     * 运行区块链网络诊断
     *
     * @return 诊断结果
     */
    @ApiOperation(value = "运行区块链诊断", notes = "运行完整的Fabric区块链网络诊断检查")
    @GetMapping("/run")
    public AjaxResult runDiagnostic() {
        logger.info("运行Fabric网络诊断");

        try {
            Map<String, Object> results = diagnosticTool.runDiagnostic();
            return AjaxResult.success("诊断完成", results);
        } catch (Exception e) {
            logger.error("运行诊断失败", e);
            return AjaxResult.error("运行诊断失败: " + e.getMessage());
        }
    }

    /**
     * 检查区块链网络状态
     *
     * @return 网络状态
     */
    @ApiOperation(value = "检查网络状态", notes = "检查Fabric区块链网络连接状态，包括网关和通道连接")
    @GetMapping("/status")
    public AjaxResult checkNetworkStatus() {
        logger.info("检查Fabric网络状态");

        try {
            Map<String, Object> gatewayCheck = diagnosticTool.checkGateway();
            Map<String, Object> channelCheck = diagnosticTool.checkChannel();
            
            boolean gatewayConnected = (Boolean) gatewayCheck.getOrDefault("gatewayConnected", false);
            boolean channelConnected = (Boolean) channelCheck.getOrDefault("channelConnected", false);
            
            AjaxResult result = AjaxResult.success("检查完成");
            result.put("status", gatewayConnected && channelConnected ? "正常" : "异常");
            result.put("gatewayConnected", gatewayConnected);
            result.put("channelConnected", channelConnected);
            
            Map<String, Object> details = new HashMap<>();
            details.put("gateway", gatewayCheck);
            details.put("channel", channelCheck);
            result.put("details", details);
            
            return result;
        } catch (Exception e) {
            logger.error("检查网络状态失败", e);
            return AjaxResult.error("检查网络状态失败: " + e.getMessage());
        }
    }
}