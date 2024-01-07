module main;
import std.stdio : writeln;
import stats: uniform_matrix, naive_inverse,
	matmul, transpose, is_square_matrix;

void main()
{	
	ulong nrows = 5;
	ulong ncols = 5;
	
	writeln("set up matrix A: ");
	double[][] A = uniform_matrix(nrows, ncols, 3, 10);
	writeln("set up matrix B: ");
    double[][] B = uniform_matrix(nrows, ncols, 4, 16);

	writeln("C = A x t(A): ");
	double[][] C = matmul(A, transpose(B));

	writeln("D = naive_inverse(C): ");
	double[][] D = naive_inverse(C);
}
