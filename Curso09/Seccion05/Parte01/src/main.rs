fn main() {
    let mut x = 5;

    if x == 5 {
        println!("x es igual a 5");
    } else if x == 6 {
        println!("x es igual a 6");
    } else {
        println!("x no es igual a 5 o 6");
    }

    let y = true;

    if y {
        println!("y es verdadero");
    } else {
        println!("y es falso");
    };

    let z = if y { 420 } else { 69 };

    println!("z es igual a {}", z);

    let mut a = 0;

    loop {
        println!("o shit, here we go again x{}",a);
        a += 1;
        if a == 10 {
            break;
        }
    }

    let mut i = 0;

    let loop_res = loop {
        if i == 10 {
            break i * 10;
        }
        i += 1;
    };
    
    println!("i*10 = {}",i);

    i = 0;

    while i < 10 {
        println!("i = {}",i);
        i +=1;
    }

    let mensaje = ['a', 'b', 'c'];

    for (index, &item) in mensaje.iter().enumerate() {
        println!("item {} es {}", index, item);
        if item == 'b' {break;}
    }

    for number in 0..5 {
        for num in 0..2{
            println!("item {},{}", number, num);
        }
    }
}
