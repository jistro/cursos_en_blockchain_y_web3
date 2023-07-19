// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DEPLOY_FundMe} from "../../script/DEPLOYFundMe.s.sol";

contract FundMeTest is Test{

    FundMe fundMe;

    address DONADOR = makeAddr("donador"); // genera un address para el donador

    function setUp() external {
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DEPLOY_FundMe deployFundMe = new DEPLOY_FundMe();
        fundMe = deployFundMe.run();
        vm.deal(DONADOR, 100 ether); // genera inicialmente 100 ether para el donador
    }

    function testMinimunDolarIsFive() public {
        
        //console.log(cost);
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        console.log(fundMe.getOwner());
        console.log(address(this));
        console.log(msg.sender);
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeedIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function test_FundFail_NotEnoughTokens() public {
        vm.expectRevert();
        fundMe.fund(); //send 0 value
    }

    function test_FundUpdatesFundedDataStructure() public {
        vm.prank(DONADOR);
        fundMe.fund{value: 0.1 ether}();
        uint256 funded = fundMe.getAddressToAmountFunded(DONADOR);
        assertEq(funded, 0.1 ether);
    }

    function test_AddsFunderToArrayOfFunders() public {
        vm.prank(DONADOR);
        fundMe.fund{value: 40 ether}();
        address fonder = fundMe.getFunder(0);
        assertEq(fonder, DONADOR);
    }

    modifier funded()   {
        vm.prank(DONADOR);
        fundMe.fund{value: 40 ether}();
        _;
    }

    function test_widraw_noOwner() public funded{
        
        vm.expectRevert(); //vm.expectRevert(); aunque espera la sig linea a fallo ignora los vm y comentarios
        vm.prank(DONADOR);
        fundMe.withdraw();
    }

    function test_widraw_Owner() public funded{
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingContractBalance = address(fundMe).balance;

        //console.log(startingOwnerBalance);
        //console.log(startingContractBalance);


        //uint256 gasStart = gasleft(); //gasleft() nos da el gas que nos queda (funcion por solidity)
        //vm.txGasPrice(1); //nos genera el gas price a x cantidad por defecto es 0
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingContractBalance = address(fundMe).balance;
        assertEq(endingContractBalance, 0);
        assertEq(endingOwnerBalance, startingOwnerBalance + startingContractBalance);
        //console.log(endingOwnerBalance);
        //console.log(endingContractBalance);

        //uint256 gasEnd = gasleft();

        //console.log((gasStart - gasEnd) * tx.gasprice); //tx.gasprice nos da el gas price en el momento de la transaccion
        
    }

    function test_widraw_MultipleFounders() public funded{
        uint160 numberOfFunders = 30;
        uint160 staringFunderIndex = 2;
        for (uint160 i = staringFunderIndex; i < numberOfFunders; i++) {
            hoax(address(i),10 ether);
            fundMe.fund{value: 10 ether}();
        }

        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingContractBalance = address(fundMe).balance;
        console.log(startingOwnerBalance);
        console.log(startingContractBalance);

        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingContractBalance = address(fundMe).balance;
        assert(endingContractBalance == 0);
        assert(fundMe.getOwner().balance == startingOwnerBalance + startingContractBalance);
        console.log(endingOwnerBalance);
        console.log(endingContractBalance);
    }
    function test_cheaperwidraw_MultipleFounders() public funded{
        uint160 numberOfFunders = 30;
        uint160 staringFunderIndex = 2;
        for (uint160 i = staringFunderIndex; i < numberOfFunders; i++) {
            hoax(address(i),10 ether);
            fundMe.fund{value: 10 ether}();
        }

        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        uint256 startingContractBalance = address(fundMe).balance;
        console.log(startingOwnerBalance);
        console.log(startingContractBalance);

        vm.startPrank(fundMe.getOwner());
        fundMe.cheaperWithdraw();
        vm.stopPrank();

        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        uint256 endingContractBalance = address(fundMe).balance;
        assert(endingContractBalance == 0);
        assert(fundMe.getOwner().balance == startingOwnerBalance + startingContractBalance);
        console.log(endingOwnerBalance);
        console.log(endingContractBalance);
    }
}