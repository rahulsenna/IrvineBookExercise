#include <stdio.h>
#include <math.h>


int GCD(int x, int y)
{
  int a = abs(x); // absolute value
  int b = abs(y);
  do {
    int n = a % b;
    a = b;
    b = n;
  } while (b > 0);
  return a;
}

int main() 
{
    int res = GCD(64, 128);
    printf("res: %d\n", res);
    return 0;
}
