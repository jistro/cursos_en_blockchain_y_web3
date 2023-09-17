fn main() {
    let mut x: u8 = 10;
    let mut y: f64 = 3.141592;
    println!("x is {} and y is {}", x, y);
    x = 20;
    y = 2.718281828;
    println!("x is {} and y is {}", x, y);
    x = x + 1;
    y = y * 5.0;
    println!("x is {} and y is {}", x, y);
    x = 52 % 5;
    y = y / 3.0;
    println!("x is {} and y is {}", x, y);
    y = (y / (x as f64 + 1.0)) + 10.5;
    println!("x is {}\nAnd y is {:08.3}", x, y);
    println!("x is {0}\nAnd y is {1:08.3} and again x is {1}", x, y);
    print!("Crazy? I Was Crazy Once. They Locked Me In A Room. A Rubber Room. A Rubber Room With Rats. And Rats Make Me Crazy... ");
    println!("Crazy? I Was Crazy Once. They Locked Me In A Room. A Rubber Room. A Rubber Room With Rats. And Rats Make Me Crazy.");

}
