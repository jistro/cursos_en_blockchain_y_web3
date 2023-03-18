// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;
pragma experimental ABIEncoderV2;

import "./SafeMath.sol";


/*
CARTERA GENERADOR 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

Cartera 1 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
Cartera 2 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
Cartera 3 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
*/
//interface de token
interface IERC20 {
    //devuevlve la cantidad de tokens disponibles
    function Total_Supply() external view returns(uint256);

    //devuelve cantidad de tokens para una direccion inddicada por parametro
    function Balance_Of_Address(address account) external view returns(uint256);

    //Devuelve el num de tokens que el sender pueda gastar en nombre del propietario
    function Allowance(address owner, address spender) external view returns(uint256);

    //Devuelve un valor booleano de resutado de operacion indicada
    function Transfer(address recipient, uint256 amount) external returns (bool);

    //aprovacion de la transferencia
    function Approve(address spender, uint256 amount) external returns(bool);

    //resultado de la operacion de un paso de una cantidad de tokens usando el metodo allowance()
    function TransferFrom(address sender, address recipient, uint256 amount) external returns(bool);

    /*Eventos*/

    //cuando se emita que una cantidad de tokens pase de un origen a un destino
    event EVENT_Transfer(address indexed from, address indexed to, uint256 amount);

    //se emite uando se establece la asignacion del metodo allowance()
    event EVENT_Approval(address indexed owner, address spender, uint256 value);
}

contract ERC20_Basic is IERC20{

    //nombre del token/moneda Virtual
    string  public constant name     = "DonitasCoin";
    string  public constant symbol   = "DONA";
    uint8   public constant decimals = 4; //4 decimales

    //cuando se emita que una cantidad de tokens pase de un origen a un destino
    event EVENT_Transfer(address indexed from, address indexed to, uint256 amount);

    //se emite uando se establece la asignacion del metodo allowance()
    event EVENT_Approval(address indexed owner, address delegate, uint256 value);

    using SafeMath for uint256;

    mapping (address => uint) balances;
    mapping (address => mapping (address => uint)) allawed;
    uint256 totalSupply_; //la cantidad total de monedas que habran

    constructor(uint256 initialSupply) public {
        totalSupply_ = initialSupply;
        balances[msg.sender] = totalSupply_;
    }

    //devuevlve la cantidad de tokens disponibles
    function Total_Supply() public override view returns(uint256) {
        return(totalSupply_);
    }

    function increaseTotalSupply(uint256 amount) public {
        totalSupply_ += amount;
        balances[msg.sender] += amount;
    }

    //devuelve cantidad de tokens para una direccion inddicada por parametro
    function Balance_Of_Address(address tokenOwner) public override view returns(uint256) {
        return(balances[tokenOwner]);
    }

    //Devuelve el num de tokens que el sender pueda gastar en nombre del propietario
    function Allowance(address owner, address delegate)  public override view returns(uint256) {
        return(allawed[owner][delegate]);
    }

    //Devuelve un valor booleano de resutado de una transferencia de tokens
    function Transfer(address recipient, uint256 numTokens) public override returns(bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[recipient] = balances[recipient].add(numTokens);
        emit EVENT_Transfer(msg.sender, recipient, numTokens);
        return(true);
    }

    //aprovacion de la transferencia
    function Approve(address delegate, uint256 numTokens) public override returns(bool) {
        allawed[msg.sender][delegate] = numTokens;
        emit EVENT_Approval(msg.sender, delegate, numTokens);
        return(true);
    }

    //resultado de la operacion de un paso de una cantidad de tokens usando el metodo allowance()
    function TransferFrom(address owner, address buyer, uint256 numTokens) public override  returns(bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allawed[owner][msg.sender]);
        
        balances[owner] = balances[owner].sub(numTokens);
        allawed[owner][msg.sender] = allawed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit EVENT_Transfer(owner, buyer, numTokens);
        return(true);
    }
}
