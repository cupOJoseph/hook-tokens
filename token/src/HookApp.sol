// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console} from "forge-std/console.sol";
import {Token} from "./Token.sol";
contract hookApp{

    constructor(address tokenAddress) {
        Token token = Token(tokenAddress);

        //register this contract as a hook.
        token.registerHook(address(this), address(this));
        //Now whenever tokens are sent to this contract, the activate function will be called.
    }

    function activate(address from, address to, uint256 amount, uint256 balance) external {
        console.log("Hook activated!! :)");
    }
}