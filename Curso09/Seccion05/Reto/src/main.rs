fn main() {
    let numbers = [1, 9, -2, 0, 23, 20, -7, 13, 37, 20, 56, -18, 20, 3];

    let mut max: i32 = 0;
    let mut min: i32 = 0;
    let mut mean: f32 = 0.0;

    for (i, number) in numbers.iter().enumerate() {
        if i == 0 {
            max = *number;
            min = *number;
            mean = *number as f32;
        } else {
            if *number > max {
                max = *number;
            }
            if *number < min {
                min = *number;
            }
            mean += *number as f32;
        }
    }

    mean /= numbers.len() as f32;

    


    assert_eq!(max, 56);
    assert_eq!(min, -18);
    assert_eq!(mean, 12.5);
    println!("max: {}, min: {}, mean: {}", max, min, mean);
}
