module main;
import std.stdio : writeln;
import stats: uniform_matrix, naive_inverse,
	matmul, transpose, is_square_matrix, print_matrix;

void main()
{	
	ulong nrows = 5;
	ulong ncols = 5;
	
	writeln("set up matrix A: ");
	double[][] A = uniform_matrix(nrows, ncols, 3, 10);
  print_matrix(A);	

  writeln("set up matrix B: ");
  double[][] B = uniform_matrix(nrows, ncols, 4, 16);
  print_matrix(B);	
	
  writeln("C = A x t(A): ");
	double[][] C = matmul(A, transpose(B));
  print_matrix(C);	

	writeln("D = naive_inverse(C): ");
 	double[][] D = naive_inverse(C);
  print_matrix(D);
}
