package com.ruoyi.charity.blockchain.util;

import org.hyperledger.fabric.gateway.Wallet;
import org.hyperledger.fabric.gateway.Wallets;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

@Component
public class FabricWalletUtil {
    private static final Logger logger = LoggerFactory.getLogger(FabricWalletUtil.class);
    
    @Value("${fabric.walletPath}")
    private String walletPath;
    
    @Value("${fabric.userId}")
    private String userId;

    /**
     * 获取Fabric钱包
     * 
     * @return Fabric钱包实例
     * @throws IOException IO异常
     */
    public Wallet getWallet() throws IOException {
        Path walletDir = Paths.get(walletPath);
        if (!Files.exists(walletDir)) {
            Files.createDirectories(walletDir);
        }
        return Wallets.newFileSystemWallet(walletDir);
    }

    /**
     * 清空钱包中的所有身份信息
     */
    public void clearWallet() {
        try {
            logger.info("开始清理钱包: {}", walletPath);
            Path walletDir = Paths.get(walletPath);
            
            if (Files.exists(walletDir)) {
                // 先删除所有文件
                try (Stream<Path> paths = Files.walk(walletDir)) {
                    paths.filter(Files::isRegularFile)
                         .map(Path::toFile)
                         .forEach(file -> {
                             boolean deleted = file.delete();
                             logger.info("删除文件: {} - {}", file.getAbsolutePath(), deleted ? "成功" : "失败");
                         });
                }
                
                // 再删除所有目录（不包括根目录）
                try (Stream<Path> paths = Files.walk(walletDir)) {
                    paths.filter(p -> !p.equals(walletDir))
                         .filter(Files::isDirectory)
                         .sorted((p1, p2) -> -p1.toString().compareTo(p2.toString())) // 倒序排列以确保先删除子目录
                         .map(Path::toFile)
                         .forEach(dir -> {
                             boolean deleted = dir.delete();
                             logger.info("删除目录: {} - {}", dir.getAbsolutePath(), deleted ? "成功" : "失败");
                         });
                }
                
                logger.info("钱包清理完成");
            } else {
                logger.info("钱包目录不存在，无需清理");
            }
        } catch (IOException e) {
            logger.error("清理钱包失败", e);
        }
    }

    /**
     * 删除指定身份
     * 
     * @param identity 身份ID
     */
    public void deleteIdentity(String identity) {
        try {
            logger.info("开始删除身份: {}", identity);
            Path walletDir = Paths.get(walletPath);
            Path identityPath = walletDir.resolve(identity);
            
            if (Files.exists(identityPath)) {
                deleteDirectory(identityPath.toFile());
                logger.info("身份删除成功: {}", identity);
            } else {
                logger.info("身份不存在: {}", identity);
            }
        } catch (Exception e) {
            logger.error("删除身份失败: {}", identity, e);
        }
    }

    /**
     * 递归删除目录
     * 
     * @param directoryToBeDeleted 要删除的目录
     * @return 是否删除成功
     */
    private boolean deleteDirectory(File directoryToBeDeleted) {
        File[] allContents = directoryToBeDeleted.listFiles();
        if (allContents != null) {
            for (File file : allContents) {
                deleteDirectory(file);
            }
        }
        return directoryToBeDeleted.delete();
    }

    /**
     * 列出钱包中的所有身份
     */
    public void listIdentities() {
        try {
            logger.info("列出钱包中的所有身份:");
            Path walletDir = Paths.get(walletPath);
            
            if (Files.exists(walletDir)) {
                try (Stream<Path> paths = Files.list(walletDir)) {
                    paths.filter(Files::isDirectory)
                         .forEach(path -> logger.info("身份: {}", path.getFileName()));
                }
            } else {
                logger.info("钱包目录不存在");
            }
        } catch (IOException e) {
            logger.error("列出身份失败", e);
        }
    }
}
