// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Test, console } from "forge-std/Test.sol";
import { OZToken } from "../src/OZToken.sol";
import { DeployToken } from "../script/DeployToken.s.sol";

contract OZTokenTest is Test {
    OZToken public token;
    DeployToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    address carol = makeAddr("carol");

    uint256 public constant STARTING_SUPPLY = 10000 ether;
    uint256 public constant STARTING_BALANCE = 10 ether;
    function setUp() public {
        deployer = new DeployToken();
        token = deployer.run();

        vm.startPrank(msg.sender);
            token.transfer(bob, STARTING_BALANCE);
        vm.stopPrank();
    }

    function testBOB_BALANCE() public {
        assertEq(token.balanceOf(bob), STARTING_BALANCE);
    }

    function testAllawance() public {
        //un alawance es un permiso que le damos a una cuenta/ contrato
        // para que pueda gastar nuestros tokens en nuestro nombre

        uint256 initialAllowance = 10;

        // bob aprueba a alice para gastar 10 tokens en su nombre

        vm.startPrank(bob);
            token.approve(alice, initialAllowance);
        vm.stopPrank();

        uint256 transferAmount = 5;

        vm.startPrank(alice);
            token.transferFrom(bob, alice, transferAmount);
            /*
            transferFrom es una funcion que se usa para solicitar a una cuenta/contrato tokens
            transfer es una funcion que se usa para transferir tokens de una cuenta a otra de manera 
            */
        vm.stopPrank();
        assert(token.balanceOf(alice) == transferAmount);
        assert(token.balanceOf(bob) == STARTING_BALANCE - transferAmount);
    }
}