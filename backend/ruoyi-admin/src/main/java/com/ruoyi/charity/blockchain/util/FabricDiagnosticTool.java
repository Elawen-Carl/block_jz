
package com.ruoyi.charity.blockchain.util;

import org.hyperledger.fabric.gateway.*;
import org.hyperledger.fabric.sdk.Channel;
import org.hyperledger.fabric.sdk.Peer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Component
public class FabricDiagnosticTool {
    private static final Logger logger = LoggerFactory.getLogger(FabricDiagnosticTool.class);
    @Autowired
    private Gateway gateway;
    @Value("${fabric.channelName}")
    private String channelName;
    @Value("${fabric.chaincodeName}")
    private String chaincodeName;
    @Value("${fabric.walletPath}")
    private String walletPath;
    @Value("${fabric.userId}")
    private String userId;
    @Value("${fabric.networkConfigPath}")
    private String networkConfigPath;

    public FabricDiagnosticTool() {
    }

    public Map<String, Object> runDiagnostic() {
        Map<String, Object> results = new HashMap();
        logger.info("开始Fabric网络诊断...");
        results.put("configCheck", this.checkConfigFiles());
        results.put("walletCheck", this.checkWallet());
        results.put("gatewayCheck", this.checkGateway());
        results.put("channelCheck", this.checkChannel());
        results.put("chaincodeCheck", this.checkChaincode());
        logger.info("诊断完成");
        return results;
    }

    public Map<String, Object> checkConfigFiles() {
        Map<String, Object> results = new HashMap();
        logger.info("检查配置文件...");

        try {
            Path configPath;
            if (this.networkConfigPath.startsWith("classpath:")) {
                String resourcePath = this.networkConfigPath.substring(10);
                configPath = Paths.get(this.getClass().getClassLoader().getResource(resourcePath).toURI());
            } else {
                configPath = Paths.get(this.networkConfigPath);
            }

            boolean configExists = Files.exists(configPath, new LinkOption[0]);
            results.put("networkConfigExists", configExists);
            if (configExists) {
                String content = new String(Files.readAllBytes(configPath), StandardCharsets.UTF_8);
                results.put("networkConfigSize", content.length());
                results.put("hasChannelsSection", content.contains("\"channels\""));
                results.put("hasMyChannel", content.contains("\"" + this.channelName + "\""));
            }
        } catch (Exception var5) {
            Exception e = var5;
            logger.error("检查网络配置文件失败", e);
            results.put("networkConfigError", e.getMessage());
        }

        return results;
    }

    public Map<String, Object> checkWallet() {
        Map<String, Object> results = new HashMap();
        logger.info("检查钱包...");

        try {
            Path walletDir = Paths.get(this.walletPath);
            boolean walletExists = Files.exists(walletDir, new LinkOption[0]);
            results.put("walletExists", walletExists);
            if (walletExists) {
                Wallet wallet = Wallets.newFileSystemWallet(walletDir);
                boolean identityExists = wallet.get(this.userId) != null;
                results.put("identityExists", identityExists);
                if (identityExists) {
                    Identity identity = wallet.get(this.userId);
                    results.put("identityType", identity.getClass().getSimpleName());
                    if (identity instanceof X509Identity) {
                        X509Identity x509Identity = (X509Identity)identity;
                        results.put("mspId", x509Identity.getMspId());
                        results.put("certificateSubject", x509Identity.getCertificate().getSubjectX500Principal().getName());
                    }
                }
            }
        } catch (Exception var8) {
            Exception e = var8;
            logger.error("检查钱包失败", e);
            results.put("walletError", e.getMessage());
        }

        return results;
    }

    public Map<String, Object> checkGateway() {
        Map<String, Object> results = new HashMap();
        logger.info("检查Gateway连接...");

        try {
            boolean gatewayConnected = this.gateway != null;
            results.put("gatewayConnected", gatewayConnected);
            if (gatewayConnected) {
                try {
                    Network network = this.gateway.getNetwork(this.channelName);
                    results.put("availableNetworks", Collections.singletonList(this.channelName));
                    results.put("networkCount", 1);
                    results.put("channelConnected", true);
                } catch (Exception var4) {
                    Exception e = var4;
                    logger.error("获取网络失败", e);
                    results.put("channelConnected", false);
                    results.put("networkError", e.getMessage());
                }
            }
        } catch (Exception var5) {
            Exception e = var5;
            logger.error("检查Gateway连接失败", e);
            results.put("gatewayError", e.getMessage());
        }

        return results;
    }

    public Map<String, Object> checkChannel() {
        Map<String, Object> results = new HashMap();
        logger.info("检查通道: {}", this.channelName);

        try {
            Network network = this.gateway.getNetwork(this.channelName);
            results.put("channelConnected", true);
            Channel channel = network.getChannel();
            results.put("channelName", channel.getName());
            Collection<Peer> peers = channel.getPeers();
            results.put("peerCount", peers.size());
            Map<String, Object> peerInfo = new HashMap();
            Iterator var6 = peers.iterator();

            while(var6.hasNext()) {
                Peer peer = (Peer)var6.next();
                Map<String, Object> info = new HashMap();
                info.put("url", peer.getUrl());
                info.put("name", peer.getName());
                info.put("properties", peer.getProperties());
                peerInfo.put(peer.getName(), info);
            }

            results.put("peers", peerInfo);
        } catch (Exception var9) {
            Exception e = var9;
            logger.error("检查通道失败", e);
            results.put("channelConnected", false);
            results.put("channelError", e.getMessage());
        }

        return results;
    }

    public Map<String, Object> checkChaincode() {
        Map<String, Object> results = new HashMap();
        logger.info("检查链码: {}", this.chaincodeName);

        try {
            Network network = this.gateway.getNetwork(this.channelName);
            Contract contract = network.getContract(this.chaincodeName);
            results.put("chaincodeAvailable", true);

            try {
                byte[] queryResult = contract.evaluateTransaction("queryAllWastes", new String[0]);
                results.put("querySuccess", true);
                results.put("queryResultLength", queryResult.length);
                if (queryResult.length > 0) {
                    String resultStr = new String(queryResult, StandardCharsets.UTF_8);
                    results.put("queryResultSample", resultStr.length() > 100 ? resultStr.substring(0, 100) + "..." : resultStr);
                }
            } catch (Exception var7) {
                Exception e = var7;
                logger.error("链码查询失败", e);
                results.put("querySuccess", false);
                results.put("queryError", e.getMessage());

                try {
                    contract.createTransaction("queryAllWastes");
                    results.put("transactionCreated", true);
                } catch (Exception var6) {
                    Exception ex = var6;
                    results.put("transactionCreated", false);
                    results.put("transactionError", ex.getMessage());
                }
            }
        } catch (Exception var8) {
            Exception e = var8;
            logger.error("检查链码失败", e);
            results.put("chaincodeAvailable", false);
            results.put("chaincodeError", e.getMessage());
        }

        return results;
    }
}
