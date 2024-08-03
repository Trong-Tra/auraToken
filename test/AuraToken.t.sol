// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13

import {Test, console2, stdError } from "forge-std/Test.sol";
import {auraToken} from "../src/AuraToken.sol";

contract AuraTest is Test{
    // Variables
    AuraToken public auraToken;
    address supplyOwner = makeAddr("Faucet")
    address user1 = makeAddr("User1")
    address user2 = makeAddr("User2")
    error ERC20InvalidReceiver(address receiver);

    /**
     * @dev setup test
     */

    function setUp() public {
        vm.prank(supplyOwner)
        token = new auraToken("Aura token", "AURA", 100000)
    }

}