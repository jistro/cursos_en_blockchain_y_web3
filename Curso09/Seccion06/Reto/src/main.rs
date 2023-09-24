fn main() {
    /*
        escribe una funcion que reciba un string y remueva los espacios en blanco
        al inicio y al final del string
    */
    let mensaje = String::from("Salu2 aqui  ");
    println!("el mensaje es \"{}\"", mensaje);
    let mensaje = trim_spaces(&mensaje);
    println!("el mensaje es \"{}\"", mensaje);
}

fn trim_spaces(s: &str) -> &str {
    let mut start = 0;
     for (index, character) in s.chars().enumerate() {
        if character != ' ' {
            start = index;
            break;
        }
    }

    let mut end = 0;
    for (index, character) in s.chars().rev().enumerate() {
        if character != ' ' {
            end = s.len() - index;
            break;
        }
    }

    &s[start..end]
}
