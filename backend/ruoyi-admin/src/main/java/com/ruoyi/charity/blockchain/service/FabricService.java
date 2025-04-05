package com.ruoyi.charity.blockchain.service;

public interface FabricService {
    // 用户管理相关接口
    String registerUser(String userId, String userInfo) throws Exception;
    String updateUserInfo(String userId, String updatedInfo) throws Exception;
    String getUser(String userId) throws Exception;
    
    // 捐赠管理相关接口
    String recordDonation(String donationId, String donorId, String projectId, 
                          String amount, String method, String timestamp) throws Exception;
    String getDonation(String donationId) throws Exception;
    String generateDonationCertificate(String donationId) throws Exception;
    String queryUserDonations(String userId) throws Exception;
    
    // 慈善项目管理相关接口
    String createCharityProject(String projectId, String projectInfo) throws Exception;
    String approveProject(String projectId, String organizationId, 
                          String approvalStatus, String remarks) throws Exception;
    String getProject(String projectId) throws Exception;
    String reviewProject(String projectId, String userId, 
                         String rating, String comment) throws Exception;
                        
    // 资金透明度相关接口
    String recordFundAllocation(String allocationId, String projectId, String amount, 
                               String purpose, String recipient, String timestamp) throws Exception;
    String getFundAllocation(String allocationId) throws Exception;
    String queryProjectFundAllocations(String projectId) throws Exception;

}
