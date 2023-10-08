#!/bin/bash
tput reset
tput civis


curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

rustc --version
