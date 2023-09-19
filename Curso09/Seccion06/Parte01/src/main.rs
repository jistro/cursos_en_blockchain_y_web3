fn main() {
    let name = "Juan🐎";
    println!("Hola, {}!", name);
    {
        let mut name = "El niño del oxxo";
        println!("Hola, {}!", name);
        name = "mmmm";
        println!("{}!", name);
        {
            let name = 69420;
            println!("Hola, {}!", name);
        }
    }
    println!("Hola, {}!", name);
    println!("Scoping es demasiado R A R O");

    let mut mensaje = String::from("Hola");
    println!("{}", mensaje);
    {
        mensaje.push_str(" J U A N 🐎");
        println!("{}", mensaje);
        let mut anita = String::from("anita lava la tina");
        anita.push_str(" y el niño del oxxo");
        mensaje = anita.clone();
        anita.clear();
        println!("{}", anita);
        
    }
    println!("{}", mensaje);
    // println!("{}", anita); // anita no existe en este scope

    let mensaje_prestar = String::from("Juan🐎");
    let mensaje_prestar = funcion_prestada(mensaje_prestar);
    println!("{}", mensaje_prestar);
}

fn funcion_prestada (mensaje: String) -> String{
    println!("{}", mensaje);
    let mensaje_nuevo = String::from("Juan prestado🐎");
    mensaje_nuevo
}
