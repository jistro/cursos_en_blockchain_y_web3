fn main() {
    let celcius_temp = 23.0;
    let fahrenheit_temp = convert_to_fahrenheit(celcius_temp);

    assert_eq!(fahrenheit_temp, 73.4);
    println!("{}°C = {}°F", celcius_temp, fahrenheit_temp);
}


fn convert_to_fahrenheit(celcius_temp: f64) -> f64 {
    celcius_temp * 1.8 + 32.0
}