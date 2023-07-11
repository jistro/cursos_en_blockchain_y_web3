// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


/**
* @title Contrato de "Rifa con causa"
* @author jistro.eth
* @notice Contrato para la rifa 
* @dev Implementa chainlink VRF
*/ 


contract Raffle {
    error Raffle__logic(string reason);

    uint256 private immutable i_ticketPrice;


    /// @dev Lista de participantes
    ///      el uso de payable es para poder enviarle
    ///      avax a la direccion
    address payable[] private s_participants;

    constructor(uint256 _ticketPrice) {
        i_ticketPrice = _ticketPrice;
    }


    function enterRaffle() external payable {
        if (msg.value < i_ticketPrice) 
            revert Raffle__logic("Not enough AVAX");
        
        s_participants.push(payable(msg.sender));
    }

    function pickWinner() public {
        
    }

    function getTicketPrice() external view returns (uint256) {
        return i_ticketPrice;
    }
}