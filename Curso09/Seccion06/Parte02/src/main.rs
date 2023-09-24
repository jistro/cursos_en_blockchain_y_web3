fn main() {
    let mut nombre = String::from("Matrinez");
    let mut emoji = "🐱";
    println!("{} tiene {} caracteres {} \n{} caracteres {}", nombre, nombre.len(), emoji, nombre.len(), emoji);
    let len = process_saludo(&mut nombre); // &nombre hacemos prestamo de la variable nombre
    println!("{} tiene {} caracteres {} \n{} caracteres {}", nombre, len, emoji, len, emoji);
}

fn process_saludo(saludo: &mut String) -> usize {
    saludo.push_str(" mire");
    let len = saludo.len();
    len
}
