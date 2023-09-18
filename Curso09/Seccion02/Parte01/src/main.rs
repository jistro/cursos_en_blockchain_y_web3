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
    println!("Manejo de bits con operadores");
    let mut valueBinary = 0b1111_0101u8;
    println!("valueBinary is {}", valueBinary);
    println!("valueBinary is {:08b}", valueBinary);
    valueBinary = !valueBinary; // NOT
    println!("valueBinary is {}", valueBinary);
    println!("valueBinary is {:08b} NOT", valueBinary);
    valueBinary = valueBinary & 0b1111_0111; // AND
    println!("valueBinary is {:08b} AND", valueBinary);
    println!("Bit 6 is {}", (valueBinary & 0b0100_0000)); 
    valueBinary = valueBinary | 0b1111_1101; // OR
    println!("valueBinary is {:08b} OR", valueBinary);
    valueBinary = valueBinary ^ 0b0101_0101; // XOR
    println!("valueBinary is {:08b} XOR", valueBinary);
    valueBinary = 0b1111_1111;
    println!("valueBinary is {:08b}", valueBinary);
    valueBinary = valueBinary << 4; // Desplazamiento de 4 bits a la izquierda
    println!("valueBinary is {:08b} << 4", valueBinary);
    valueBinary = valueBinary >> 2; // Desplazamiento de 2 bits a la derecha
    println!("valueBinary is {:08b} >> 2", valueBinary);
    println!("Booleanos");
    let booleanoA: bool = true;
    let booleanoB: bool = false;
    println!("A is {} and B is {}", booleanoA, booleanoB);
    println!("A NOT (!) B is {}", !booleanoA);
    println!("A AND (&&) B is {}", booleanoA && booleanoB);
    println!("A AND (&) B is {}", booleanoA & booleanoB);
    println!("A OR (||) B is {}", booleanoA || booleanoB);
    println!("A OR (|) B is {}", booleanoA | booleanoB);
    println!("A XOR (^) B is {}", booleanoA ^ booleanoB);
    println!("A == B is {}", booleanoA == booleanoB);
    println!("A != B is {}", booleanoA != booleanoB);
    println!("Comparaciones");
    let numberA: u8 = 10;
    let numberB: u8 = 20;
    println!("A is {} and B is {}", numberA, numberB);
    println!("A > B is {}", numberA > numberB);
    println!("A < B is {}", numberA < numberB);
    println!("A >= B is {}", numberA >= numberB);
    println!("A <= B is {}", numberA <= numberB);
    println!("A == B is {}", numberA == numberB);
    println!("A != B is {}", numberA != numberB);
    println!("Carateres");
    let characterLetter: char = 'A';
    let characterNumber: char = '1';
    let characterEmoji: char = '🤓';
    let characterUnicode: char = '\u{261D}';
    println!("Letter is {}", characterLetter);
    println!("Number is {}", characterNumber);
    println!("Emoji is {}", characterEmoji);
    println!("Unicode is {}", characterUnicode);
    println!("All characters are {}{}{}{}", characterLetter, characterNumber, characterEmoji, characterUnicode);
}
