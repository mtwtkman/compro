use std::io;
pub mod solve;

use solve::prompt::prompt;

fn main() -> io::Result<()> {
    let input = prompt()?;
    println!("{:?}", &input);
    Ok(())
}
