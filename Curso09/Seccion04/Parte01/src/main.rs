fn main() {
    say_hello();
    say_helloN("Rust");
    say_add(5, 7);
    let number1 = 9;
    let number2 = 10;
    let number3 = 12;
    say_add(number1, number2);
    let result = add(number1, number3);
    println!("{} + {} = {}", number1, number3, result);
    let (number, result) = square(5);
    println!("{} * {} = {}", number, number, result);
}

fn say_hello() {
    println!("Hello, world!");
}

fn say_helloN(name: &str) {
    println!("Hello, {}!", name);
}

fn say_add(number1: u32, number: u32) {
    println!("{} + {} = {}", number1, number, number1 + number);
}

fn square(number: u32) -> (u32, u32) {
    println!("{} * {}", number, number);
    return (number, number * number);
    println!("This code is not executed");
}

fn add(number1: u32, number: u32) -> u32 {
    number1 + number
}
