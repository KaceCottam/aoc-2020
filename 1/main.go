package main

import (
  "os"
  "fmt"
  "log"
  "io/ioutil"
  "strings"
  "strconv"
)

func solveFile(filename string) {
  data, err := ioutil.ReadFile(filename)
  if err != nil {
    log.Fatal(err)
  }
  fmt.Printf("Solving for file: %s\n", filename)

  lines := strings.Split(string(data), "\n")
  var numbers []int
  for _, i := range lines {
    n, err := strconv.Atoi(i)
    if err == nil {
      numbers = append(numbers, n)
    }
  }

  for _, i := range numbers {
    for _, j := range numbers {
      if i + j == 2020 {
        fmt.Printf("%d\n", i*j)
        return
      }
    }
  }
}

func main() {
  for _, filename := range os.Args[1:] {
    solveFile(filename)
  }
}
