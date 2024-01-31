module main;
import std.stdio : writeln;
import stats: weighted_mean, uniform_matrix, naive_inverse,
	matmul, transpose, is_square_matrix, print_matrix;

void main()
{	
	
  float[] x = [2, 3, 4, 5];
  float wmean = weighted_mean(x, x);
  
  const ulong nrows = 5;
	const ulong ncols = 5;
	
	writeln("set up matrix A: ");
	double[][] A = uniform_matrix(nrows, ncols, 3.0, 10.0);
  print_matrix(A);	

  writeln("set up matrix B: ");
  double[][] B = uniform_matrix(nrows, ncols, 4.0, 16.0);
  print_matrix(B);	
	
  writeln("C = A x t(A): ");
	double[][] C = matmul(A, transpose(B));
  print_matrix(C);	

	writeln("D = naive_inverse(C): ");
 	double[][] D = naive_inverse(C);
  print_matrix(D);
  
  
}
