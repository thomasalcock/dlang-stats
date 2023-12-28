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

double[] zscore(double[] data) {
  double[] scores = new double[](data.length);
  double mean_data= mean(data);
  double stddev_data = standard_deviation(data);
  scores[] = (data[] - mean_data) / stddev_data;
  return scores;
}

double weighted_mean(double[] data, double[] weights) {
  assert(data.length == weights.length, "weighted_mean: data and weights have different lengths!");
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

bool is_close_enough(double x, double y) {
  return abs(x - y) < 1.16992e-06;
}

bool is_close_enough_slice(double[] actual, double[] expected) {
  assert(actual.length == expected.length, "is_close_enough_slice: actual and expected have different lengths!");
  for (int i = 0; i < actual.length; i++) {
    bool check = !is_close_enough(actual[i], expected[i]);
    writeln(check);
    if (check) {
      return false;
    }
  }
  return true;
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

double dotproduct(double[] x, double[] y) {
  double result = 0;
  assert(x.length == y.length, "dotproduct: x and y do not have equal length!");
  for (int i = 0; i < x.length; i++) {
    result += x[i] * y[i];
  }
  return result;
}

double[][] inverse(double[][] matrix) {
  assert(is_square_matrix(matrix), "Matrix is not square!");
  
  ulong nrows = matrix.length;
  ulong ncols = matrix[0].length;
  double[][] result;

  alloc_matrix(result, nrows, ncols);
  double det = determinant(matrix);
  assert(det != 0, "inverse: Determinant is 0, matrix is singular!");
  double inv_det = 1/det;
  for (int i = 0; i < nrows; i++) {
    for (int j = 0; j < ncols; j++) {
      // somehow the indices need to be switched to get the correct result, otherwise the resulting matrix
      // needs to be transposed again
      result[j][i] = inv_det * pow(-1, i+j) * determinant(minor_matrix(matrix, i, j));
    }
  }
  return result;
}

double[][] matmul(double[][] A, double[][] B) {
  // A(n x k) * B(k x m) -> C(n x m)
  assert(A[0].length == B.length, "matmul: Matrix dimensions do not match!"); // these dimensions should be k
  
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
  assert(is_square_matrix(matrix), "trace: Matrix is not square!");
  
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
    assert(is_square_matrix(matrix), "determinannt: Matrix is not square!");
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
