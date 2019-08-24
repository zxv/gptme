#!/usr/bin/env python
from argparse import ArgumentParser
import sys

DESCRIPTION = "A tool to interact with the opengpt-2 machine learning model"

def parse_args():
    parser = ArgumentParser(prog=("gptme"), description=DESCRIPTION)
    args = parser.parse_args()

    if len(sys.argv) <= 1:
        parser.print_help()

    return args

if __name__ == '__main__':
  args = parse_args()
