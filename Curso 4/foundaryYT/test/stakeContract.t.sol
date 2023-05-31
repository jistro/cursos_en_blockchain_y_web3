// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/stakeContract.sol";
import "test/mocks/MockERC20.SOL";
import "test/utils/Cheats.sol";

contract ContractTest is Test {
    Cheats internal constant cheats = Cheats(HEVM_ADDRESS);
    StakeContract public stakeContract;
    MockERC20 public mockToken;

    function setUp() public {
        stakeContract = new StakeContract();
        mockToken = new MockERC20();
    }

    function testExample(uint8 amount)  public {
        mockToken.approve(address(stakeContract), amount);
        bool stakePassed = stakeContract.stake(address(mockToken), amount);
        //cheats.roll(55);
        assertTrue(stakePassed);
    }
}
