// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;
pragma experimental ABIEncoderV2;

import "./SafeMath.sol";

//interface de token
interface IERC20 
{
    //devuevlve la cantidad de tokens disponibles
    function Total_Supply() external view returns(uint256);

    //devuelve cantidad de tokens para una direccion inddicada por parametro
    function Balance_Of_Address(address account) external view returns(uint256);

    //Devuelve el num de tokens que el sender pueda gastar en nombre del propietario
    function Allowance(address owner, address spender) external view returns(uint256);

    //Devuelve un valor booleano de resutado de operacion indicada
    function Transfer(address recipient, uint256 amount) external view returns(bool);

    //aprovacion de la transferencia
    function Approve(address spender, uint256 amount) external returns(bool);

    //resultado de la operacion de un paso de una cantidad de tokens usando el metodo allowance()
    function Transfer_From(address sender, address recipient, uint256 amount) external returns(bool);

    /*Eventos*/

    //cuando se emita que una cantidad de tokens pase de un origen a un destino
    event EVENT_Transfer(address indexed from, address indexed to, uint256 amount);

    //se emite uando se establece la asignacion del metodo allowance()
    event EVENT_Approval(address indexed owner, address spender, uint256 value);
}

contract ERC20_Basic is IERC20
{

    //nombre del token/moneda Virtual
    string  public constant name     = "DonitasCoin";
    string  public constant symbol   = "DONA";
    uint8   public constant decimals = 4; //4 decimales

    //cuando se emita que una cantidad de tokens pase de un origen a un destino
    event EVENT_Transfer(address indexed from, address indexed to, uint256 amount);

    //se emite uando se establece la asignacion del metodo allowance()
    event EVENT_Approval(address indexed owner, address spender, uint256 value);

    using SafeMath for uint256;

    mapping (address => uint) balances;
    mapping (address => mapping (address => uint)) allawed;
    uint256 totalSupply_; //la cantidad total de monedas que habran

    constructor(uint256 initialSupply) public
    {
        totalSupply_ = initialSupply;
        balances[msg.sender] = totalSupply_;
    }

    //devuevlve la cantidad de tokens disponibles
    function Total_Supply() public override view returns(uint256)
    {
        return(totalSupply_);
    }

    function increaseTotalSupply(uint256 amount) public
    {
        totalSupply_ += amount;
        balances[msg.sender] += amount;
    }

    //devuelve cantidad de tokens para una direccion inddicada por parametro
    function Balance_Of_Address(address tokenOwner) public override view returns(uint256)
    {
        return(balances[tokenOwner]);
    }

    //Devuelve el num de tokens que el sender pueda gastar en nombre del propietario
    function Allowance(address owner, address spender) public override view returns(uint256)
    {
        return(allawed[owner][spender]);
    }

    //Devuelve un valor booleano de resutado de operacion indicada
    function Transfer(address recipient, uint256 amount) external view returns(bool)
    {

    }

    //aprovacion de la transferencia
    function Approve(address spender, uint256 amount) external returns(bool)
    {

    }

    //resultado de la operacion de un paso de una cantidad de tokens usando el metodo allowance()
    function Transfer_From(address sender, address recipient, uint256 amount) external returns(bool)
    {

    }
}
