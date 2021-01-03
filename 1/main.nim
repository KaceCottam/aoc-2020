const
  N* = 1000

proc solve_file*(filename: cstring) =
  var n_lines: cint = 0
  var line: array[N, char] = [0]
  var numbers: array[N, cint] = [0]
  printf("Solving for file: %s\n", filename)
  var infile: ptr FILE = fopen(filename, "r")
  while not feof(infile):
    fgets(line, N, infile)
    line[N] = '\x00'
    numbers[n_lines] = atoi(line)
    inc(n_lines)
  fclose(infile)
  var i: cint = 0
  while i < n_lines:
    var j: cint = 0
    while j < n_lines:
      if numbers[i] + numbers[j] == 2020:
        printf("%d\n", numbers[i] * numbers[j])
        return
      inc(j)
    inc(i)

proc main*(argc: cint; argv: ptr cstring): cint =
  var i: cint = 1
  while i < argc:
    solve_file(argv[i])
    inc(i)
  return 0
