#include <stdio.h>

int square(int x)
{
  return x * x;
}

int main()
{
  int x = square(5);
  printf("%d", x);
  return 0;
}
