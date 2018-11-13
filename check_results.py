import os
import sys

from ast import literal_eval as make_tuple

def parse_tuple(line, key, values):
    t = make_tuple(line.split('=')[1].strip())
    for i in range(len(t)):
        values[key + '_' + str(i)] = t[i]

def parse_value(line, key, values):
    v = float(line.split('=')[1].strip())
    values[key] = v

def parse_table(f, table_key, num, values):
    for i in range(num):
        line_values = f.readline().split()
        val_1 = float(line_values[3])
        val_2 = float(line_values[5])
        err = float(line_values[7])
        values[table_key + '_col1'] = val_1
        values[table_key + '_col2'] = val_2
        values[table_key + '_err'] = err

def parse_file(f):
    values = {}

    # z2 / Check for octave header
    z2_line = f.readline()
    if z2_line[0:3] == "GNU":
        num_skip = 16
        for i in range(0, num_skip):
            z2_line = f.readline()
    parse_tuple(z2_line, 'z2', values)

    # z3
    z3_line = f.readline()
    parse_tuple(z3_line, 'z3', values)

    # alpha
    alpha_line = f.readline()
    parse_value(alpha_line, 'alpha', values)

    # beta
    beta_line = f.readline()
    parse_value(beta_line, 'beta', values)

    # eta
    eta_line = f.readline()
    parse_value(eta_line, 'eta', values)

    # T
    T_line = f.readline()
    parse_value(T_line, 'T', values)

    # ans
    ans_line = f.readline()
    parse_value(ans_line, 'ans', values)
    f.readline()    # Skip duplicate line

    # m
    m_line = f.readline()
    parse_value(m_line, 'm', values)

    # R
    R_line = f.readline()
    parse_value(R_line, 'R', values)

    # d
    d_line = f.readline()
    parse_value(d_line, 'd', values)

    f.readline()    # Skip conditional
    f.readline()    # Skip Solution

    # x*
    x_line = f.readline()
    parse_tuple(x_line, 'x*', values)

    skip_line = f.readline()    # Skip Table 1 / check for octave header
    if skip_line[0:3] == "GNU":
        num_skip = 16
        for i in range(0, num_skip):
            f.readline()
    parse_table(f, 'Table_1', 9, values)

    f.readline()    # Skip Table 2
    parse_table(f, 'Table_2', 7, values)

    f.readline()    # Skip Table 3
    parse_table(f, 'Table_3', 5, values)

    return values

def check_differences(expected_values, computed_values):
    passing = True
    for key in expected_values:
        # There is a difference of more than 10%, then report
        if float(abs(computed_values[key] - expected_values[key])) / expected_values[key] > 0.1:
            print 'DIFFERENCE IN ' + key
            passing = False
    return passing

def main(args):
    expected_results_file = args[1] # File with expected results
    computed_results_file = args[2] # File with computed results

    # Parse data out of the files
    with open(expected_results_file) as f:
        expected_values = parse_file(f)
    with open(computed_results_file) as f:
        computed_values = parse_file(f)

    # Check differences
    passing = check_differences(expected_values, computed_values)
    if not passing:
        sys.exit(1)

if __name__ == '__main__':
    main(sys.argv)
