fn main() {
    let mensaje = String::from("Salu2 desde el main");
    println!("el mensaje es \"{}\"", mensaje);

    let ultima_palabra = &mensaje[15..];
    println!("la ultima palabra es \"{}\"", ultima_palabra);

    let numeros = [1, 2, 3, 4, 5];
    let slice: &[i32] = &numeros[..3];
    println!("el slice es {:?}", slice);
}
