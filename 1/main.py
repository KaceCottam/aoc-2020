#!/usr/bin/env python3
import sys
from pprint import pprint

def solve_file(file_name):
    print(f"Solving file: {file_name}")
    with open(file_name, "r") as infile:
        numbers = [ int(i) for i in infile.readlines() ]
        product = [ i*j for i in numbers for j in numbers if i + j == 2020 ][0]
        print(f"Product: {product}")

def main():
    list(map(solve_file, sys.argv[1:]))

main()
