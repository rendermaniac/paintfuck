#!/usr/bin/env python
# http://acm.zhihua-lai.com
# Brainfuck Interpreter

from __future__ import print_function

def pp(x, ppm):
    print(x, end="")
    ppm.write(x)

def bf(src, left, right, data, idx, ppm):
    """
        brainfuck interpreter
        src: source string
        left: start index
        right: ending index
        data: input data string
        idx: start-index of input data string
    """
    if len(src) == 0: return
    if left < 0: left = 0
    if left >= len(src): left = len(src) - 1
    if right < 0: right = 0
    if right >= len(src): right = len(src) - 1
    # tuning machine has infinite array size
    # increase or decrease here accordingly
    arr = [0] * 30000
    ptr = 0
    i = left
    while i <= right:
        s = src[i]
        if s == '#':
            print(arr[:100])
        if s == '>':
            ptr += 1
            # wrap if out of range
            if ptr >= len(arr):
                ptr = 0
        elif s == '<':
            ptr -= 1
            # wrap if out of range
            if ptr < 0:
                ptr = len(arr) - 1
        elif s == '+':
            arr[ptr] += 1
        elif s == '-':
            arr[ptr] -= 1
        elif s == '.':
            pp(chr(arr[ptr]), ppm)
        elif s == ',':
            if idx >= 0 and idx < len(data):
                arr[ptr] = ord(data[idx])
                idx += 1
            else:
                arr[ptr] = 0 # out of input
        elif s =='[':
            if arr[ptr] == 0:
                loop = 1
                while loop > 0:
                    i += 1
                    c = src[i]
                    if c == '[':
                        loop += 1
                    elif c == ']':
                        loop -= 1
        elif s == ']':
            loop = 1
            while loop > 0:
                i -= 1
                c = src[i]
                if c == '[':
                    loop -= 1
                elif c == ']':
                    loop += 1
            i -= 1
        i += 1

if __name__ == "__main__":

    import sys
    import os

    srcfile = sys.argv[1]
    src = open(srcfile).read()
    src = "".join([c for c in src if c in "+-.,<>[]"]) # minify

    ppmfile = os.path.splitext(srcfile)[0] + ".ppm"
    ppm = open(ppmfile, "w")

    data = ""
    if len(sys.argv) > 2:
        data= sys.argv[2]

    bf(src, 0, len(src) - 1, data, 0, ppm)