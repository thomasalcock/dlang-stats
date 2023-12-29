module main;
import stats: uniform_matrix, print_matrix, matmul, transpose, is_square_matrix, inverse;
import std.stdio : writeln;

void main()
{	
	double[][] A = uniform_matrix(4, 3, 3, 10);
    double[][] B = uniform_matrix(4, 3, 4, 16);

	writeln("Matrix A: ");
    print_matrix(A);
	writeln("Matrix B: ");
	print_matrix(B);
	
	double[][] C = matmul(A, transpose(B));
	writeln("Matrix C = A x t(B) : ");
	print_matrix(C);

	double[][] D = inverse(C);
	writeln("Matrix D = inverse(C) : ");
	print_matrix(D);
}
