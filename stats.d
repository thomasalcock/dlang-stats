module stats;

import std.stdio : writeln;
import std.math: sqrt, pow, abs;

double mean(double[] data) {
  double result = 0.0;
  foreach (ref e; data)
  { 
    result += e;
  }
  return result / data.length;
}

double[] zscore(double[] data, double mean, double stddev) {
  double[] scores = new double[](data.length);
  scores[] = (data[] - mean) / stddev;
  return scores;
}

double weighted_mean(double[] data, double[] weights) {
  assert(data.length == weights.length);
  double result = 0.0;
  for (int i = 0; i < data.length; i++) {
      result += data[i] * weights[i];
  }
  return result / data.length;
}

double standard_deviation(double[] data, ulong degrees_of_freedom = 0) {
  double result = 0.0;
  double mean = mean(data);
  foreach (ref e; data) {
    result += pow((e - mean), 2);
  }
  return sqrt(result / (data.length - degrees_of_freedom));
}

double coef_of_variation(double[] data) {
  return standard_deviation(data) / mean(data);
}

void is_close_enough(double x, double y) {
  double diff = abs(x - y);
  if (diff > 1.16992e-06) {
    writeln("Values: ", x, " ", y, " differ by ", diff);
  }
}

ulong[] dim(double[][] matrix) {
  return [
    matrix.length, // n rows
    matrix[0].length // n columns
  ];
}

void alloc_matrix(ref double[][]result, ulong n_rows, ulong n_cols) {
  result.length = n_rows;
  //writeln("Capacity for row space: ", result.capacity);
  foreach(ref row; result) {
    row.length = n_cols; 
    //writeln("Capacity for column space: ", row.capacity);
  }
}

double[][] transpose(double[][] matrix) {
  ulong nrows = matrix.length;
  ulong ncols = matrix[0].length;
  double[][] result;

  alloc_matrix(result, ncols, nrows);

  for (int i = 0; i < nrows; i++) {
    for (int j = 0; j < ncols; j++) {
        result[j][i] = matrix[i][j];
    }
  }
  return result;
}

void print_matrix(double[][] matrix) {
  foreach (ref row; matrix) {
    writeln(row);
  }
  writeln("\n");
}

double[][] matmul(double[][] A, double[][] B) {
  // A(n x k) * B(k x m) -> C(n x m)
  assert(A[0].length == B.length); // these dimensions should be k
  
  ulong n = A.length;
  ulong k = A[0].length;
  ulong m = B[0].length;
  
  double[][] result;
  alloc_matrix(result, n, m);

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {
      result[i][j] = 0;
    }
  }

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {
      for (int l = 0; l < k; l++) {
        result[i][j] += A[i][l] * B[l][j];
      }
    }
  }
  return result;
}

bool is_square_matrix(double[][] matrix) {
  return matrix.length == matrix[0].length;
}

double trace(double[][] matrix) {
  assert(is_square_matrix(matrix));
  
  ulong nrows = matrix.length;
  ulong ncols = matrix[0].length;
  
  double result = 0;
  
  for (int i = 0; i < nrows; i++) {
    for (int j = 0; j < ncols; j++) {
      if (i == j) {
        result += matrix[i][j];
      }
    }
  }
  return result;
}

bool is_in_array(ulong element, ulong[] collection) {
  for (int i = 0; i < collection.length; i++) {
    if (element == collection[i]) {
      return true;
    }
  }
  return false;
}

double[] remove(double[] x, ulong index) {
  double[] result = x[0..index] ~ x[(index+1)..$];
  return result;
}

double[][] minor_matrix(double[][] matrix, ulong row_index, ulong col_index) {
  double[][] result;
  foreach (i, row; matrix) {
    if (i != row_index) {
      result ~= row[0..col_index] ~ row[(col_index + 1)..$];
    }
  }
  return result;
}
  
double determinant(double[][] matrix) {
    assert(is_square_matrix(matrix));
    double result = 0;
    ulong nrows = matrix.length;
    ulong ncols = matrix[0].length;

    if (nrows == 1 && ncols == 1) {
        return matrix[0][0];
    }

    for (int j = 0; j < ncols; j++) {
        double[][] M = minor_matrix(matrix, 0, j);
        if (M.length > 0) {
            result += pow(-1, 0 + j) * matrix[0][j] * determinant(M);
        } else {
            result += 0;
        }
    }
    return result;
}
