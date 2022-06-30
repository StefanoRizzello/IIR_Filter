#include <stdio.h>
#include <stdlib.h>

// Gr18 C model for IIR filter

#define N 2   /// order of the filter
#define NB 10  /// number of bits

const int b0 = 52;           /// coefficient b0
const int b[N] = {105, 52};  /// b array
const int a[N] = {95, -50};  /// a array

/// Perform fixed point filtering assuming direct form II
///\param x is the new input sample
///\return the new output sample

int myfilter(int x) {
  static int sw[N];          /// w shift register
  static int first_run = 0;  /// for cleaning the shift register
  int i;                     /// index
  int w;                     /// intermediate value (w)
  int y;                     /// output sample
  int fb, ff;                /// feed-back and feed-forward results

  printf("[sample %d]:\n", x);
  /// clean the buffer
  if (first_run == 0) {
    first_run = 1;
    for (i = 0; i < N; i++) sw[i] = 0;
  }
  int tmp_fb = 0;
  /// compute feed-back and feed-forward
  fb = 0;
  
  ff = 0;
  for (i = 0; i < N; i++) {
    printf("\t q[%d]*a[%d] =%d (%d)\n", i + 1, i + 1, (-sw[i] * a[i]),
           (sw[i] * a[i]) >> (NB - 1));

    printf("\t q[%d]*b[%d] =%d (%d)\n", i + 1, i + 1, (sw[i] * b[i]),
           (sw[i] * b[i]) >> (NB - 1));

    fb += (sw[i] * a[i]) >>(NB-1);
    tmp_fb = (sw[i] * a[i]);
    ff += (sw[i] * b[i]) >> (NB - 1);
  }
  /// compute intermediate value (w) and output sample

  w = (x>>(NB-9)) + fb;
  printf("\t tmpa=%d \n", w);
  printf("\t tmpa*b0=%d (%d) \n", w * b0,(w * b0) >> (NB - 1));
  y = (w * b0) >> (NB - 1);
  y += ff;
  printf("\t tmpb=%d \n", y);

  /// update the shift register
  for (i = N - 1; i > 0; i--) sw[i] = sw[i - 1];
  sw[0] = w;

  return y;
}

int main(int argc, char **argv) {
  FILE *fp_in;
  FILE *fp_out;

  int x;
  int y;

  /// check the command line
  if (argc != 3) {
    printf("Use: %s <input_file> <output_file>\n", argv[0]);
    exit(1);
  }

  /// open files
  fp_in = fopen(argv[1], "r");
  if (fp_in == NULL) {
    printf("Error: cannot open %s\n", argv[1]);
    exit(2);
  }
  fp_out = fopen(argv[2], "w");

  /// get samples and apply filter
  fscanf(fp_in, "%d", &x);  // acquire new sample from file
  do {
    y = myfilter(x);  // process sample [i]
    fprintf(fp_out, "%d\n", y);
    fscanf(fp_in, "%d", &x);
  } while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out);

  return 0;
}
