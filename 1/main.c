#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N 1000

void solve_file(char* filename) {
  int n_lines = 0;
  char line[N] = {0};
  int numbers[N] = {0};

  printf("Solving for file: %s\n", filename);
  FILE* infile = fopen(filename, "r");
  while(!feof(infile)) {
    fgets(line, N, infile);
    line[N] = '\0';
    numbers[n_lines] = atoi(line);
    n_lines++;
  }
  fclose(infile);

  for (int i = 0; i < n_lines; i++)
    for (int j = 0; j < n_lines; j++)
      if (numbers[i] + numbers[j] == 2020)
      {
        printf("%d\n", numbers[i] * numbers[j]);
        return;
      }

}

int main(int argc, char* argv[]) {
  for (int i = 1; i < argc; i++) {
    solve_file(argv[i]);
  }
  return 0;
}
