const Calificacion = artifacts.require("Calificacion");

contract ("Calificacion", accounts =>{
    it ('1. Funcion: calificar(string memory _matriculaAlumno, uint8 _calificacion)', async () => {
        let instance = await Calificacion.deployed();
        const tx = await instance.evaluar("201636606", 10, {from: accounts[0]})
        console.log(accounts[0])
        console.log(tx)
        const cal_alumno = await instance.ver_notas("201636606", {from: accounts[1]})
        assert.equal(cal_alumno,10)
        console.log(cal_alumno)
    });
});