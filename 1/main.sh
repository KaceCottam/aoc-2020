#!/usr/bin/bash

function solve() {
  echo Solving for file: $1
  for i in $(cat "$1"); do
    for j in $(cat "$1"); do
      product=$((i + j))
      if [[ $product -eq 2020 ]]; then
        echo $((i * j))
        return
      fi
    done
  done
  exit 1
}

for i in "$@"; do solve $i; done
