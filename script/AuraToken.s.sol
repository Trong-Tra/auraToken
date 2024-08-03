// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {auraToken} from "../src/AuraToken.sol";

contract auraTokenScript is Script{
    
    function setUp() public{}

    /**
     * @dev deployment script
     * @notice for security mesure, set up for deployment is interactive/manually
     */
    function run() public{
        vm.startBroadcast();
        auraToken token = new auraToken("AuraToken", "AURA", 10000000*10**18);
        console2.log("Aura Token deployed at: ", address(token));
        console2.log("Supply: ", token.totalSupply());
        vm.stopBroadcast();
    }
}