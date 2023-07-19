// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DeployRaffle} from "../../script/DeployRaffle.s.sol";
import {Raffle} from "../../src/Raffle.sol";
import {Test, console} from "forge-std/Test.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";

contract RaffleTest is Test{
    /* events for the contracts to test */
    event EnetedRaffle(
        address indexed player
    );

    Raffle raffle;
    HelperConfig helperConfig;

    uint256 ticketPrice;
    uint256 interval;
    address vrfCordinator; 
    bytes32 KeyHash;
    uint64 subscriptionId;
    uint32 callbackGasLimit;
    address link;

    address public PLAYER1 = makeAddr("player1");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() external {
        DeployRaffle deployer = new DeployRaffle();
        (raffle,helperConfig) = deployer.run();
        
        (
            ticketPrice, 
            interval,
            vrfCordinator, 
            KeyHash,
            subscriptionId,
            callbackGasLimit,
            link
        ) = helperConfig.activeNetworkConfig();
        vm.deal(PLAYER1, STARTING_BALANCE);
    }

    function testRaffleInitializesInOpenState()  public view {
        assert(raffle.getRaffleState() == Raffle.RaffleState.OPEN);
    }

    //////////////////////////////////////////////////////////////////////////
    // Enter the raffle                                                     //
    //////////////////////////////////////////////////////////////////////////
    
    function testRffleRevertWhenYouDonPlayEnough() public {
        // 1. Arrange
        vm.startPrank(PLAYER1);
        // 2. Act
        vm.expectRevert(Raffle.Raffle__notEnoughAVAX.selector);
        raffle.enterRaffle();
        // 3. Assert
        vm.stopPrank();
    }

    function testRffleRecordsPlayerWhenTheyEnter() public {
        vm.startPrank(PLAYER1);
        raffle.enterRaffle{value: ticketPrice}();
        address aux_playerRecorded = raffle.getPlayer(0);
        assert(aux_playerRecorded == PLAYER1);
        vm.stopPrank();
    }

    function testEmitEventOnEntrance() public {
        vm.startPrank(PLAYER1);
            // expectEmit ayuda a mostrar los eventos que se esperan
            // en este caso se espera que se emita una variable
            // y como no hay datos no indexados se ponen false al final
            // si hubiera datos no indexados se pondrían true
            vm.expectEmit(true, false, false, false, address(raffle));

            emit EnetedRaffle(PLAYER1);

            raffle.enterRaffle{value: ticketPrice}();
            
        vm.stopPrank();
    }

    function  testCantEnterWhenRaffleIsCalculated() public {
        vm.startPrank(PLAYER1);
            raffle.enterRaffle{value: ticketPrice}();
            vm.warp(block.timestamp + interval + 1);
            vm.roll(block.number + 1);
            raffle.performUpkeep("");
            vm.expectRevert(Raffle.Raffle__raffleClosed.selector);
        vm.stopPrank();
        vm.startPrank(PLAYER1);
            raffle.enterRaffle{value: ticketPrice}();
        vm.stopPrank();
    }
}