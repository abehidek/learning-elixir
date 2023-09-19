use std::{thread, time};

#[rustler::nif]
fn add(a: i64, b: i64) -> i64 {
    a + b
}

#[rustler::nif]
fn raise_error() {
    panic!("RandomError");
}

fn factorial_helper(val: u128, acc: u128) -> u128 {
    if val < 1 {
        return u128::from(acc);
    }
    return factorial_helper(val - 1, acc * val);
}

#[rustler::nif]
fn factorial(val: u64, acc: u64) -> String {
    let res: u128 = factorial_helper(u128::from(val), u128::from(acc));
    println!("Rust result: {res}");
    return res.to_string();
}

#[rustler::nif]
fn power(val: i64) -> i64 {
    return i64::pow(val, 2);
}

#[rustler::nif]
fn thread_sleep() {
    println!("Sleeping");
    thread::sleep(time::Duration::from_millis(5000));
    println!("End Sleep");
}

rustler::init!(
    "Elixir.FacPowErr.Utils",
    [add, raise_error, factorial, power, thread_sleep]
);
