fn main() {
    println!("Listas unidimensionales");
    let mut letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];
    letters[0] = 'x';
    let firstLetter = letters[0];
    println!("The first letter is {}", firstLetter);

    let mut numbers : [i32; 5];
    numbers = [33; 5]; // esto es igual a [0, 0, 0, 0, 0]
    println!("The first number is {}", numbers[0]);
    let index = numbers.len();
    numbers[index - 1] = 99;
    println!("The last number is {}", numbers[index - 1]);

    println!("Listas multidimensionales");
    let mut matrix = [
                        [1, 2, 3], 
                        [4, 5, 6], 
                        [7, 8, 9]
                    ];
    matrix[0][0] = 99;
    println!("The first number in the first row is {}", matrix[0][0]);
    println!("The last number in the last row is {}", matrix[2][2]);

    let mut multi_matrix : [[[ i32 ; 3]; 3]; 3];

    println!("Tuplas");

    let mut tupla:  (i32, f64, char, &str) = (1, 3.14, 'a', "Hola");

    let primer_elemento = tupla.0;
    let segundo_elemento = tupla.1;
    println!("El primer elemento es {}", primer_elemento);

    tupla.0 += 1;
    println!("El primer elemento es {}", tupla.0);


    let (a, b, c, d) = tupla;
    println!("El elemento c es {}", c);
}
