module run;
import std.stdio : writeln;
//import std.algorithm : remove;
import stats;

void main() {
  double[] x = [1, 2, 3, 4, 5];
  double[] w = [.1, .2, .3, .4, .5];
  
  double[][] A = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [10, 11, 12]
  ];
  
  writeln("x = ", x);
  double[] y = remove(x, 2);
  writeln("y = ", y);

  writeln("\nMatrix A: ");
  print_matrix(A);

  double[][] B = minor_matrix(A, 2, 2);
  writeln("\nB = minor_matrix(A, 2, 2): ");
  print_matrix(B);

  writeln("\nMatrix A: ");
  print_matrix(A);

  writeln("remove(x, 2) = ", remove(x, 2));
  writeln("remove(x, 0) = ", remove(x, 0));
  writeln("remove(x, 4) = ", remove(x, 4));

  double[][] At = transpose(A);
  double[][] Z = matmul(A, At);
  double z_trace = trace(Z);
  double mean_x = mean(x);
  double stddev_x = standard_deviation(x, 1);
  double wmean_x = weighted_mean(x, w);
  double coef_var_x = coef_of_variation(x);

  double[] zscores_x = zscore(x, mean_x, stddev_x);
  
  writeln("zscore: ", zscores_x, "\n");
  
  writeln("Matrix t(A): ");
  print_matrix(At);

  writeln("Matrix Z = A x t(A)");
  print_matrix(Z);

  writeln("trace of Z = ", z_trace);
  
  double[][] testmatrix = [
    [2.0, 3.0],
    [4.0, 5.0]
  ];
  
  double det = determinant(testmatrix);
  writeln("determinant(testmatrix) = ", det);


  is_close_enough(mean_x, 3.0);
  is_close_enough(stddev_x, 1.58114);
  is_close_enough(coef_var_x, 0.471405);
  is_close_enough(wmean_x, 1.1);
  
  writeln("All tests passed!");
}