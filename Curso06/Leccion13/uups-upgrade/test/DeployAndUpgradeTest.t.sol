// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { DeployBox } from "../script/DeployBox.s.sol";
import { UpgradeBox } from "../script/UpgradeBox.s.sol";
import { BoxV2 } from "../src/BoxV2.sol";
import { BoxV1} from "../src/BoxV1.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox deployer;
    UpgradeBox upgrader;
    address public OWNER = makeAddr("owner");

    address public proxy;

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run();
    }

    function testProxyStartsAsBoxV1() public {
        vm.expectRevert();
        BoxV2(proxy).setNumber(42);
    }

    function testUpgrades() public {
        BoxV2 box2 = new BoxV2();
        upgrader.upgradeBox(proxy, address(box2));

        uint256 expectedVersion = 2;
        assertEq(expectedVersion, BoxV2(proxy).version());

        BoxV2(proxy).setNumber(43);
        assertEq(43, BoxV2(proxy).getNumber());
    }
    

}