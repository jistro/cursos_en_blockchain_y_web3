// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;

contract comida 
{
    struct plato
    {
        string  nombrePlato;
        string  ingredientesPlato;
        uint    tiempoCocinarPlato;
    }
    //array dinamico de platos
    plato [] menu;
    //relacionamos el nombre del plato con sus ingredientes 
    mapping (string => string) ingredientes;

    function nuevo_plato(string memory _nombre, string memory _ingredientes, uint _tiempo) internal 
    {
        menu.push( plato(_nombre,_ingredientes,_tiempo) ); 
        ingredientes[ _nombre ]= _ingredientes;
    }
    
    function ingredientes_del_plato(string memory _nombre) internal view returns(string memory)
    {
        return ingredientes[_nombre];
    }


}
contract sandwich is comida
{
    function alta_sandwich(string memory _ingredientes, uint _tiempo) external
    {
        nuevo_plato("Sandwich", _ingredientes, _tiempo);
    } 
    function ver_ingredietes() external view returns (string memory)
    {
        return ingredientes_del_plato("Sandwich");
    }

}