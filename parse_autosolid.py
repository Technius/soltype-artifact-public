#!/usr/bin/env python3

from pathlib import Path
import sys
import re
import argparse

solidtype_re = re.compile('(.*): line ([0-9]+): (.*)$')
maxint_re = re.compile('115792089237316195423570985008687907853269984665640564039457584007913129639935')

def parse_solidtype(p):
    ops = []
    with open(p, 'r') as f:
        lines = f.readlines()

    start_i = -1
    i = len(lines) - 1
    for l in reversed(lines):
        if l.startswith('Now running on '):
            start_i = i
            break
        i -= 1

    if start_i == -1:
        return {}

    in_safe = False
    in_unsafe = False
    for l in lines[start_i:]:
        l = l.rstrip()
        if l == 'The following safe math checks are redundant:':
            in_safe = True
        elif l == 'The following safe math checks are necessary:':
            in_safe = False
            in_unsafe = True
        elif l.startswith('Solving time:'):
            break
        elif in_safe or in_unsafe:
            m = solidtype_re.search(l)
            if m is not None:
                ops.append({
                    'line': int(m.group(2)),
                    'constraint': m.group(3),
                    'function': m.group(1),
                    'safety': 'proven' if in_safe else 'unproven'
                })
    return ops


def main(args):
    ops = parse_solidtype(args.logfile)
    total_safe = 0
    total_unsafe = 0
    for op in ops:
        if op['safety'] == 'proven':
            total_safe += 1
        elif op['safety'] == 'unproven':
            total_unsafe += 1
    print('Total:  {}'.format(total_safe + total_unsafe))
    print('Safe:   {}'.format(total_safe))
    print('Unsafe: {}'.format(total_unsafe))
    print()
    for op in ops:
        cons = re.sub(maxint_re, 'MaxInt', op['constraint'])
        print('{o[function]}: line {o[line]}: {o[safety]}, {cons}'.format(o=op, cons=cons))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('logfile', type=Path)
    args = parser.parse_args()
    main(args)
