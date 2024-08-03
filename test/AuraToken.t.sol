// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console2, stdError } from "forge-std/Test.sol";
import {auraToken} from "../src/AuraToken.sol";

contract AuraTest is Test{
    // Variables
    auraToken public token;
    address supplyOwner = makeAddr("Faucet");
    address user1 = makeAddr("User1");
    address user2 = makeAddr("User2");
    error ERC20InvalidReceiver(address receiver);

    /**
     * @dev setup contract
     */
    function setUp() public {
        vm.prank(supplyOwner);
        token = new auraToken("Aura token", "AURA", 10000000*10**18);
    }

    /**
     * @dev setup token name
     */
    function test_name() public {
        assertEq(token.name(), "Aura token");
    }

    /**
     * @dev setup token symbol
     */
    function test_symbol() public {
        assertEq(token.symbol(), "AURA");
    }

    /**
     * @dev setup token decimals
     */
    function test_decimals() public {
        assertEq(token.decimals(), 18);
    }

    /**
     * @dev setup token supply
     */
    function test_Supply() public {
        assertEq(token.totalSupply(), 10000000*10**18);
    }
}