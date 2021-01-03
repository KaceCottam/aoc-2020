#include <iostream>
#include <fstream>
#include <string_view>
#include <string>
#include <vector>

void solve_file(const char* filename) {
  std::cout << "Solving for file: " << filename << '\n';

  auto file = std::ifstream(filename);

  std::vector<int> numbers;
  while (file.good()) {
    int n;
    file >> n;
    numbers.push_back(n);
  }

  for (auto i : numbers)
    for (auto j : numbers)
      if (i + j == 2020)
      {
        std::cout << i*j << std::endl;
        return;
      }
}

int main(int argc, char* argv[]) {
  for (int i = 1; i < argc; i++) {
    solve_file(argv[i]);
  }
  return 0;
}
