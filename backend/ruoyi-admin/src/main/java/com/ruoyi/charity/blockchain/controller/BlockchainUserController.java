package com.ruoyi.charity.blockchain.controller;

import com.google.gson.Gson;
import com.ruoyi.charity.blockchain.service.FabricService;
import com.ruoyi.common.core.controller.BaseController;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 区块链用户控制器 - 提供区块链上的用户信息查询
 *
 * @author ruoyi
 * @date 2023-04-21
 */
@Api(tags = "区块链用户管理", description = "提供区块链上用户信息的查询功能")
@RestController
@RequestMapping({"/blockchain/user"})
public class BlockchainUserController extends BaseController {
    @Autowired
    private FabricService fabricService;
    private final Gson gson = new Gson();

    public BlockchainUserController() {
    }


}