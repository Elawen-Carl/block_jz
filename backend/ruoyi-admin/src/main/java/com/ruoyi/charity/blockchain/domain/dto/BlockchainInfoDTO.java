package com.ruoyi.charity.blockchain.domain.dto;

import java.io.Serializable;

/**
 * 区块链信息DTO
 * 
 * @author ruoyi
 */
public class BlockchainInfoDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    /** 交易哈希 */
    private String txHash;
    
    /** 区块高度 */
    private Object blockNumber;
    
    /** 区块哈希 */
    private String blockHash;
    
    /** 发送者地址 */
    private String from;
    
    /** 接收者地址 */
    private String to;
    
    /** 交易状态 */
    private String status;
    
    /** Gas消耗 */
    private String gasUsed;
    
    /** 时间戳 */
    private Long timestamp;
    
    /** 确认数 */
    private Integer confirmations;

    public String getTxHash() {
        return txHash;
    }

    public void setTxHash(String txHash) {
        this.txHash = txHash;
    }

    public Object getBlockNumber() {
        return blockNumber;
    }

    public void setBlockNumber(Object blockNumber) {
        this.blockNumber = blockNumber;
    }

    public String getBlockHash() {
        return blockHash;
    }

    public void setBlockHash(String blockHash) {
        this.blockHash = blockHash;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getGasUsed() {
        return gasUsed;
    }

    public void setGasUsed(String gasUsed) {
        this.gasUsed = gasUsed;
    }

    public Long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }

    public Integer getConfirmations() {
        return confirmations;
    }

    public void setConfirmations(Integer confirmations) {
        this.confirmations = confirmations;
    }
} 