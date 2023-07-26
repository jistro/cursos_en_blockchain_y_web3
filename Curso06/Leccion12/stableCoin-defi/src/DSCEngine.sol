// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 *  @title Engine for Decentralized Stable Coin (DS)
 *  @author Kevin R. Padilla Islas (jistro.eth)
 *  El sistema esta hecho para que el token DS mantenga siempre una paridad de 1:1 con el dolar estadounidense
 *  El sistema tiene las siguentes propiedades:
 *  - El sistema esta colateralizado con wETH (Ethereum Wrapped) y wBTC (Bitcoin Wrapped)
 *  - Es sobrecolateralizado, es decir que en ningun momento el valor de la colateral puede ser menor
 *    al valor (en dolares) de los DS emitidos
 *  - Es de colateral Exógeno, es decir, el valor de la colateral es independiente del valor del DS
 *  - Es algorítmico
 *  
 *  Es similar a DAI de MakerDAO pero en en lugar de tener gobernabilidad descentralizada, esta 
 *  totalmente respaldado por wETH y wBTC
 *  
 *  @notice El contrato es el motor del sistema, es decir, es el que se encarga de hacer las operaciones
 *  de deposito de colateral, emisión de DS, quema de DS y retiro de colateral
 *  @dev El contrato esta vagamanete basado en el contrato DssEngine de MakerDAO
 */

contract DSCEngine {
    
    function depositCollateralAndMintDS() external {}

    function redeemCollateralForDS() external {}

    function burnDS() external {}

    function liquidate() external {}

    function getHealthFactor() external view {}
}