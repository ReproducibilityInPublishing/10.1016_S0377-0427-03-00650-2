format short g

addpath('./src')

mocov('-cover', './src', '-expression', 'tests',
      '-cover_json_file', 'coverage.json',
      '-cover_method', 'file')
