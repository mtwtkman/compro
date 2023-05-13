use std::io::{self, Result};

pub fn prompt() -> Result<Vec<String>> {
    let mut buf = String::new();
    let stdio = io::stdin();
    stdio.read_line(&mut buf)?;
    let values: Vec<String> = buf
        .split(' ')
        .into_iter()
        .map(|x| -> String { x.trim().to_owned() })
        .collect();
    Ok(values)
}
