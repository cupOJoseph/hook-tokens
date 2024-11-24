// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    mapping(address => address) public hooks; //callback registry

    constructor() ERC20("Example", "TOKEN") {}

    //when ever tokens are sent to the target, the hook will be called
    function registerHook(address target, address hook) public {
        require(msg.sender == target, "Only target can register their hook");
        
        hooks[target] = hook;
    }

    //override the transfer function to call hooks when possible.
    function transfer(
        address to,
        uint256 amount
    ) public override  returns(bool){
        super._transfer(msg.sender, to, amount);
        
        // Check if recipient has a registered hook
        if (hooks[to] != address(0)) {
            // Call activate() on the hook
            (bool success,) = hooks[to].call(
                abi.encodeWithSignature(
                    "activate(address,address,uint256,uint256)",
                    msg.sender,
                    to,
                    amount,
                    balanceOf(msg.sender)
                )
            );
            require(success, "Hook activation failed");
        }

        return true;
    }
}