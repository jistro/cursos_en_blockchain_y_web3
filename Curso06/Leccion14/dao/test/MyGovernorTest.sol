// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import { Test, console } from "forge-std/Test.sol";
import { MyGovernor } from "../src/MyGovernor.sol";
import { Box } from "../src/Box.sol";
import { TimeLock } from "../src/TimeLock.sol";
import { GovToken } from "../src/GovToken.sol";


contract MyGovernorTest is Test {
    MyGovernor governor;
    Box box;
    TimeLock timeLock;
    GovToken govToken;

    address public USER1 = makeAddr("user1");

    uint256 public constant INITIAL_SUPPLY = 100 ether;

    uint256 public constant MIN_DELAY = 3600; // 1 hour - after a vote pases
    uint256 public constant VOTING_DELAY = 1; // 1 block 
    uint256 public constant VOTING_PERIOD = 50400; // 1 week

    address[] proposers;
    address[] executors;
    uint256[] values;
    bytes[] calldatas;
    address[] targets;

    function setUp() public {
        govToken = new GovToken();
        govToken.mint(USER1, INITIAL_SUPPLY);
        vm.startPrank(USER1);
            govToken.delegate(USER1);
            timeLock = new TimeLock(MIN_DELAY, proposers, executors);
            governor = new MyGovernor(govToken, timeLock);

            bytes32 proposerRole = timeLock.PROPOSER_ROLE();
            bytes32 executorRole = timeLock.EXECUTOR_ROLE();
            bytes32 adminRole = timeLock.TIMELOCK_ADMIN_ROLE();

            timeLock.grantRole(proposerRole, address(governor));
            timeLock.grantRole(executorRole, address(0));
            timeLock.revokeRole(adminRole, USER1);
        vm.stopPrank();

        box = new Box();
        box.transferOwnership(address(timeLock)); //the timelock gets the ultimate say where the box goes
    }

    function testCantUpdateBoxWithoutGovernance() public {
        vm.expectRevert();
        box.store(1);
    }

    function testGovernanceUpdatesBox() public {
        uint256 valueToStore = 999;
        string memory description = "store 999 in box";
        bytes memory encodedFunctionCall = abi.encodeWithSignature("store(uint256)", valueToStore);
        values.push(0);
        calldatas.push(encodedFunctionCall);
        targets.push(address(box));
        // porpose to the dao
        uint256 proposalId = governor.propose(targets, values, calldatas, description);
        // view the state of the proposal
        console.log("proposal state:", uint256(governor.state(proposalId)));

        vm.warp(block.timestamp + VOTING_DELAY + 1);
        vm.roll(block.number + VOTING_DELAY + 1);

        console.log("proposal state:", uint256(governor.state(proposalId)));

        // vote on the proposal
        string memory reason = "because the hipnotoad said so";
        uint8 voteWay = 1; // 1 for yes, 0 for no
        vm.prank(USER1);
        governor.castVoteWithReason(proposalId, voteWay, reason);

        vm.warp(block.timestamp + VOTING_PERIOD + 1);
        vm.roll(block.number + VOTING_PERIOD + 1);

        // queue the TX
        bytes32 descriptionHash = keccak256(abi.encodePacked(description));
        governor.queue(targets, values, calldatas, descriptionHash);

        vm.warp(block.timestamp + MIN_DELAY + 1);
        vm.roll(block.number + MIN_DELAY + 1);

        // execute the TX
        governor.execute(targets, values, calldatas, descriptionHash);

        // check the box
        console.log("proposal:", box.getNumber());
        assertEq(box.getNumber(), valueToStore);
        
    }
} 