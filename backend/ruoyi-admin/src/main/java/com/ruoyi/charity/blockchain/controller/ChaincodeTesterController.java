package com.ruoyi.charity.blockchain.controller;

import com.ruoyi.charity.blockchain.service.FabricService;
import com.ruoyi.common.core.domain.AjaxResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.hyperledger.fabric.gateway.Contract;
import org.hyperledger.fabric.gateway.Gateway;
import org.hyperledger.fabric.gateway.Network;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

/**
 * 链码测试控制器 - 提供区块链链码测试接口
 *
 * @author ruoyi
 * @date 2023-04-21
 */
@Api(tags = "链码测试管理", description = "提供区块链链码连接测试、初始化和各种操作验证功能")
@RestController
@RequestMapping({"/blockchain/chaincode"})
public class ChaincodeTesterController {
    private static final Logger log = LoggerFactory.getLogger(ChaincodeTesterController.class);
    @Resource
    private FabricService fabricService;
    @Resource
    private Gateway gateway;
    @Value("${fabric.channelName}")
    private String channelName;
    @Value("${fabric.chaincodeName}")
    private String chaincodeName;

    public ChaincodeTesterController() {
    }

    /**
     * 测试区块链链码连接
     *
     * @return 连接测试结果
     */
    @ApiOperation(value = "测试链码连接", notes = "测试与区块链网络的连接以及链码可用性")
    @GetMapping({"/connection"})
    public AjaxResult testConnection() {
        AjaxResult result = AjaxResult.success("链码连接测试");
        result.put("channelName", this.channelName);
        result.put("chaincodeName", this.chaincodeName);

        try {
            Network network = this.gateway.getNetwork(this.channelName);
            result.put("channelConnected", true);
            network.getContract(this.chaincodeName);
            result.put("chaincodeAvailable", true);
            result.put("success", true);
        } catch (Exception var4) {
            Exception e = var4;
            log.error("链码连接测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }

        return result;
    }

    /**
     * 测试初始化账本
     *
     * @return 初始化测试结果
     */
    @ApiOperation(value = "测试初始化账本", notes = "调用链码的初始化账本功能，用于测试链码是否正常工作")
    @GetMapping({"/init"})
    public AjaxResult testInitLedger() {
        AjaxResult result = AjaxResult.success("链码初始化测试");

        try {
            Network network = this.gateway.getNetwork(this.channelName);
            Contract contract = network.getContract(this.chaincodeName);
            byte[] initResult = contract.evaluateTransaction("initLedger", new String[0]);
            String response = initResult != null ? new String(initResult, StandardCharsets.UTF_8) : "无返回值";
            result.put("success", true);
            result.put("response", response);
        } catch (Exception var6) {
            Exception e = var6;
            log.error("链码初始化测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }

        return result;
    }

    /**
     * 调试区块链网络状态
     */
    @ApiOperation(value = "调试网络状态", notes = "获取区块链网络状态和链码信息")
    @GetMapping("/debug")
    public AjaxResult debugNetworkStatus() {
        AjaxResult result = AjaxResult.success("网络调试信息");
        
        try {
            // 获取网络信息
            Network network = gateway.getNetwork(channelName);
            result.put("channelName", channelName);
            result.put("chaincodeName", chaincodeName);
            
            // 获取链码信息
            try {
                Contract contract = network.getContract(chaincodeName);
                try {
                    byte[] metadataResult = contract.evaluateTransaction("org.hyperledger.fabric:GetMetadata");
                    result.put("chaincodeMetadata", new String(metadataResult, StandardCharsets.UTF_8));
                } catch (Exception e) {
                    log.warn("无法获取链码元数据: {}", e.getMessage());
                    result.put("chaincodeMetadataError", e.getMessage());
                }
                
                // 尝试调用查询函数检查链码是否正常
                try {
                    // 这里使用一个不会修改状态的函数，比如查询一个不存在的ID
                    byte[] queryResult = contract.evaluateTransaction("getUser", "nonexistent_user_" + System.currentTimeMillis());
                    result.put("chaincodeTestQueryWorking", true);
                } catch (Exception e) {
                    String errorMsg = e.getMessage();
                    result.put("chaincodeTestQueryWorking", false);
                    // 如果错误消息中包含特定错误（不存在），说明链码正常
                    if (errorMsg.contains("不存在") || errorMsg.contains("not exist")) {
                        result.put("chaincodeTestQueryStatus", "正常 - 返回了预期的错误");
                    } else {
                        result.put("chaincodeTestQueryStatus", "异常 - " + errorMsg);
                    }
                }
            } catch (Exception e) {
                result.put("chaincodeError", e.getMessage());
            }
            
            // 获取Gateway信息
            Map<String, Object> gatewayInfo = new HashMap<>();
            try {
                gatewayInfo.put("class", gateway.getClass().getName());
            } catch (Exception e) {
                log.warn("无法获取Gateway信息: {}", e.getMessage());
            }
            result.put("gatewayInfo", gatewayInfo);
            
            result.put("success", true);
        } catch (Exception e) {
            log.error("获取网络调试信息失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    /**
     * 测试一个简单的查询请求
     */
    @ApiOperation(value = "测试查询请求", notes = "测试链码的查询功能，用于检查网络通信")
    @GetMapping("/test-query")
    public AjaxResult testQuery() {
        AjaxResult result = AjaxResult.success("查询请求测试");
        
        try {
            Network network = gateway.getNetwork(channelName);
            Contract contract = network.getContract(chaincodeName);
            
            // 生成一个随机ID，这样肯定会返回"不存在"的错误，可以验证链码是否正常响应
            String randomId = "test_" + System.currentTimeMillis();
            
            try {
                // 尝试获取不存在的用户信息
                contract.evaluateTransaction("getUser", randomId);
                result.put("status", "异常 - 应当返回错误但没有");
            } catch (Exception e) {
                // 检查错误是否包含"不存在"字样，这说明链码在正常工作
                if (e.getMessage().contains("不存在") || e.getMessage().contains("not exist")) {
                    result.put("status", "正常 - 链码正确响应");
                } else {
                    result.put("status", "异常 - " + e.getMessage());
                }
            }
            
            result.put("testId", randomId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("查询请求测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    // ==================== 用户管理测试接口 ====================

    /**
     * 测试用户注册
     */
    @ApiOperation(value = "测试用户注册", notes = "测试链码的用户注册功能")
    @PostMapping("/user/register")
    public AjaxResult testRegisterUser(
            @ApiParam(value = "用户ID", required = true) @RequestParam String userId,
            @ApiParam(value = "用户信息", required = true) @RequestParam String userInfo) {
        AjaxResult result = AjaxResult.success("用户注册测试");
        
        try {
            String response = fabricService.registerUser(userId, userInfo);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("用户注册测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    /**
     * 测试获取用户信息
     */
    @ApiOperation(value = "测试获取用户信息", notes = "测试链码的获取用户信息功能")
    @GetMapping("/user/{userId}")
    public AjaxResult testGetUser(
            @ApiParam(value = "用户ID", required = true) @PathVariable String userId) {
        AjaxResult result = AjaxResult.success("获取用户信息测试");
        
        try {
            String response = fabricService.getUser(userId);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("获取用户信息测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    /**
     * 测试更新用户信息
     */
    @ApiOperation(value = "测试更新用户信息", notes = "测试链码的更新用户信息功能")
    @PutMapping("/user/{userId}")
    public AjaxResult testUpdateUserInfo(
            @ApiParam(value = "用户ID", required = true) @PathVariable String userId,
            @ApiParam(value = "更新的用户信息", required = true) @RequestParam String updatedInfo) {
        AjaxResult result = AjaxResult.success("更新用户信息测试");
        
        try {
            String response = fabricService.updateUserInfo(userId, updatedInfo);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("更新用户信息测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    // ==================== 慈善项目管理测试接口 ====================

    /**
     * 测试创建慈善项目
     */
    @ApiOperation(value = "测试创建慈善项目", notes = "测试链码的创建慈善项目功能")
    @PostMapping("/project/create")
    public AjaxResult testCreateCharityProject(
            @ApiParam(value = "项目ID", required = true) @RequestParam String projectId,
            @ApiParam(value = "项目信息", required = true) @RequestParam String projectInfo) {
        AjaxResult result = AjaxResult.success("创建慈善项目测试");
        
        try {
            String response = fabricService.createCharityProject(projectId, projectInfo);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("创建慈善项目测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    /**
     * 测试审核慈善项目
     */
    @ApiOperation(value = "测试审核慈善项目", notes = "测试链码的审核慈善项目功能")
    @PutMapping("/project/{projectId}/approve")
    public AjaxResult testApproveProject(
            @ApiParam(value = "项目ID", required = true) @PathVariable String projectId,
            @ApiParam(value = "组织ID", required = true) @RequestParam String organizationId,
            @ApiParam(value = "审核状态", required = true) @RequestParam String approvalStatus,
            @ApiParam(value = "备注") @RequestParam(required = false) String remarks) {
        AjaxResult result = AjaxResult.success("审核慈善项目测试");
        
        try {
            String response = fabricService.approveProject(projectId, organizationId, approvalStatus, remarks);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("审核慈善项目测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    /**
     * 测试获取项目信息
     */
    @ApiOperation(value = "测试获取项目信息", notes = "测试链码的获取慈善项目信息功能")
    @GetMapping("/project/{projectId}")
    public AjaxResult testGetProject(
            @ApiParam(value = "项目ID", required = true) @PathVariable String projectId) {
        AjaxResult result = AjaxResult.success("获取项目信息测试");
        
        try {
            String response = fabricService.getProject(projectId);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("获取项目信息测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    /**
     * 测试项目评价
     */
    @ApiOperation(value = "测试项目评价", notes = "测试链码的项目评价功能")
    @PostMapping("/project/{projectId}/review")
    public AjaxResult testReviewProject(
            @ApiParam(value = "项目ID", required = true) @PathVariable String projectId,
            @ApiParam(value = "用户ID", required = true) @RequestParam String userId,
            @ApiParam(value = "评分", required = true) @RequestParam String rating,
            @ApiParam(value = "评论") @RequestParam(required = false) String comment) {
        AjaxResult result = AjaxResult.success("项目评价测试");
        
        try {
            String response = fabricService.reviewProject(projectId, userId, rating, comment);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("项目评价测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    // ==================== 捐赠管理测试接口 ====================

    /**
     * 测试记录捐赠
     */
    @ApiOperation(value = "测试记录捐赠", notes = "测试链码的记录捐赠功能")
    @PostMapping("/donation/record")
    public AjaxResult testRecordDonation(
            @ApiParam(value = "捐赠ID", required = true) @RequestParam String donationId,
            @ApiParam(value = "捐赠者ID", required = true) @RequestParam String donorId,
            @ApiParam(value = "项目ID", required = true) @RequestParam String projectId,
            @ApiParam(value = "捐赠金额", required = true) @RequestParam String amount,
            @ApiParam(value = "捐赠方式", required = true) @RequestParam String method,
            @ApiParam(value = "时间戳") @RequestParam(required = false) String timestamp) {
        AjaxResult result = AjaxResult.success("记录捐赠测试");
        
        try {
            String response = fabricService.recordDonation(donationId, donorId, projectId, amount, method, timestamp);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("记录捐赠测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    /**
     * 测试获取捐赠记录
     */
    @ApiOperation(value = "测试获取捐赠记录", notes = "测试链码的获取捐赠记录功能")
    @GetMapping("/donation/{donationId}")
    public AjaxResult testGetDonation(
            @ApiParam(value = "捐赠ID", required = true) @PathVariable String donationId) {
        AjaxResult result = AjaxResult.success("获取捐赠记录测试");
        
        try {
            String response = fabricService.getDonation(donationId);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("获取捐赠记录测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    /**
     * 测试生成捐赠证书
     */
    @ApiOperation(value = "测试生成捐赠证书", notes = "测试链码的生成捐赠证书功能")
    @PostMapping("/donation/{donationId}/certificate")
    public AjaxResult testGenerateDonationCertificate(
            @ApiParam(value = "捐赠ID", required = true) @PathVariable String donationId) {
        AjaxResult result = AjaxResult.success("生成捐赠证书测试");
        
        try {
            String response = fabricService.generateDonationCertificate(donationId);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("生成捐赠证书测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    /**
     * 测试查询用户捐赠历史
     */
    @ApiOperation(value = "测试查询用户捐赠历史", notes = "测试链码的查询用户捐赠历史功能")
    @GetMapping("/donation/user/{userId}")
    public AjaxResult testQueryUserDonations(
            @ApiParam(value = "用户ID", required = true) @PathVariable String userId) {
        AjaxResult result = AjaxResult.success("查询用户捐赠历史测试");
        
        try {
            String response = fabricService.queryUserDonations(userId);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("查询用户捐赠历史测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    // ==================== 资金透明度测试接口 ====================

    /**
     * 测试记录资金分配
     */
    @ApiOperation(value = "测试记录资金分配", notes = "测试链码的记录资金分配功能")
    @PostMapping("/fund/allocation")
    public AjaxResult testRecordFundAllocation(
            @ApiParam(value = "分配ID", required = true) @RequestParam String allocationId,
            @ApiParam(value = "项目ID", required = true) @RequestParam String projectId,
            @ApiParam(value = "金额", required = true) @RequestParam String amount,
            @ApiParam(value = "用途", required = true) @RequestParam String purpose,
            @ApiParam(value = "接收方", required = true) @RequestParam String recipient,
            @ApiParam(value = "时间戳") @RequestParam(required = false) String timestamp) {
        AjaxResult result = AjaxResult.success("记录资金分配测试");
        
        try {
            String response = fabricService.recordFundAllocation(allocationId, projectId, amount, purpose, recipient, timestamp);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("记录资金分配测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    /**
     * 测试获取资金分配记录
     */
    @ApiOperation(value = "测试获取资金分配记录", notes = "测试链码的获取资金分配记录功能")
    @GetMapping("/fund/allocation/{allocationId}")
    public AjaxResult testGetFundAllocation(
            @ApiParam(value = "分配ID", required = true) @PathVariable String allocationId) {
        AjaxResult result = AjaxResult.success("获取资金分配记录测试");
        
        try {
            String response = fabricService.getFundAllocation(allocationId);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("获取资金分配记录测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }

    /**
     * 测试查询项目资金流向
     */
    @ApiOperation(value = "测试查询项目资金流向", notes = "测试链码的查询项目资金流向功能")
    @GetMapping("/fund/allocation/project/{projectId}")
    public AjaxResult testQueryProjectFundAllocations(
            @ApiParam(value = "项目ID", required = true) @PathVariable String projectId) {
        AjaxResult result = AjaxResult.success("查询项目资金流向测试");
        
        try {
            String response = fabricService.queryProjectFundAllocations(projectId);
            result.put("success", true);
            result.put("response", response);
        } catch (Exception e) {
            log.error("查询项目资金流向测试失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 执行完整测试流程
     */
    @ApiOperation(value = "执行完整测试流程", notes = "自动执行完整的捐赠管理测试流程")
    @GetMapping("/full-test")
    public AjaxResult runFullTest() {
        AjaxResult result = AjaxResult.success("完整测试流程");
        Map<String, Object> testResults = new HashMap<>();
        
        try {
            // 步骤1: 注册用户
            String userId = "user_" + System.currentTimeMillis();
            String userInfo = "{\"name\":\"张三\",\"contactInfo\":\"13800138000\",\"privacySettings\":\"public\"}";
            String userResponse = fabricService.registerUser(userId, userInfo);
            testResults.put("1_用户注册", userResponse);
            
            // 步骤2: 创建慈善项目
            String projectId = "project_" + System.currentTimeMillis();
            String projectInfo = "{\"organizationId\":\"org_1\",\"name\":\"希望小学捐建项目\",\"description\":\"为贫困山区建设希望小学\",\"targetAmount\":\"100000\",\"endDate\":\"" + java.time.LocalDate.now().plusMonths(6) + "\"}";
            String projectResponse = fabricService.createCharityProject(projectId, projectInfo);
            testResults.put("2_创建项目", projectResponse);
            
            // 步骤3: 审核项目
            String approveResponse = fabricService.approveProject(projectId, "org_1", "approved", "项目符合慈善要求，予以批准");
            testResults.put("3_审核项目", approveResponse);
            
            // 步骤4: 记录捐赠
            String donationId = "donation_" + System.currentTimeMillis();
            String donationResponse = fabricService.recordDonation(donationId, userId, projectId, "1000", "credit_card", "");
            testResults.put("4_记录捐赠", donationResponse);
            
            // 步骤5: 生成捐赠证书
            String certificateResponse = fabricService.generateDonationCertificate(donationId);
            testResults.put("5_生成证书", certificateResponse);
            
            // 步骤6: 记录资金分配
            String allocationId = "allocation_" + System.currentTimeMillis();
            String allocationResponse = fabricService.recordFundAllocation(allocationId, projectId, "500", "购买建筑材料", "建材供应商A", "");
            testResults.put("6_资金分配", allocationResponse);
            
            // 步骤7: 查询用户捐赠历史
            String userDonationsResponse = fabricService.queryUserDonations(userId);
            testResults.put("7_用户捐赠历史", userDonationsResponse);
            
            // 步骤8: 查询项目资金流向
            String projectFundsResponse = fabricService.queryProjectFundAllocations(projectId);
            testResults.put("8_项目资金流向", projectFundsResponse);
            
            // 步骤9: 项目评价
            String reviewResponse = fabricService.reviewProject(projectId, userId, "5", "项目很有意义，非常满意");
            testResults.put("9_项目评价", reviewResponse);
            
            // 步骤10: 获取项目最新信息
            String finalProjectResponse = fabricService.getProject(projectId);
            testResults.put("10_项目最终状态", finalProjectResponse);
            
            result.put("success", true);
            result.put("testResults", testResults);
            
        } catch (Exception e) {
            log.error("完整测试流程执行失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
            result.put("testResults", testResults); // 返回已执行的测试结果
        }
        
        return result;
    }
}
