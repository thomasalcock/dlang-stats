module stats;

import std.stdio : writeln;
import std.math: sqrt, pow, abs;
import std.random: uniform;

// TODO: implement a dimension check that iterates over all
// rows of a matrix to ensure uniform column dimension

T covariance(T)(T[] x, T[] y) {
  T result = 0.0;
  T mean_x = mean(x);
  T mean_y = mean(y);
  size_t n = x.length;
  for(size_t i = 0; i < n; i++) {
    result += (x[i] - mean_x) * (y[i] - mean_y);
  }
  return result / (n -1);
}

T mean(T)(T[] data) {
  T result = 0.0;
  foreach (ref e; data)
  { 
    result += e;
  }
  return result / data.length;
}

T[] zscore(T)(T[] data) {
  T[] scores = new T[](data.length);
  T mean_data= mean(data);
  T stddev_data = standard_deviation(data);
  scores[] = (data[] - mean_data) / stddev_data;
  return scores;
}

T weighted_mean(T)(T[] data, 
                     double[] weights) {
  assert(data.length == weights.length, 
      "weighted_mean: data and weights have different lengths!");
  double result = 0.0;
  for (int i = 0; i < data.length; i++) {
      result += data[i] * weights[i];
  }
  return result / data.length;
}

T variance(T)(T[] data, 
           ulong degrees_of_freedom = 0) {
  T result = 0.0;
  T mean = mean(data);
  foreach (ref e; data) {
    result += pow((e - mean), 2);
  }
  return result / (data.length - degrees_of_freedom);
}

T standard_deviation(T)(T[] data, 
                        ulong degrees_of_freedom = 0) {
	return sqrt(variance(data, degrees_of_freedom = degrees_of_freedom));
}

T coef_of_variation(T)(T[] data) {
  return standard_deviation(data) / mean(data);
}

bool is_close_enough(T)(T x, 
                        T y) {
  return abs(x - y) < 1.16992e-06;
}

bool is_close_enough_slice(T)(T[] actual, 
                              T[] expected) {
  assert(actual.length == expected.length, 
      "is_close_enough_slice: actual and expected have different lengths!");
  for (size_t i = 0; i < actual.length; i++) {
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

void alloc_matrix(ref double[][]result, 
                  ulong n_rows, 
                  ulong n_cols) {
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

double dotproduct(double[] x, 
                  double[] y) {
  double result = 0;
  assert(x.length == y.length, "dotproduct: x and y do not have equal length!");
  for (int i = 0; i < x.length; i++) {
    result += x[i] * y[i];
  }
  return result;
}

double[][] naive_inverse(double[][] matrix) {
  assert(is_square_matrix(matrix), "Matrix is not square!");
  
  ulong nrows = matrix.length;
  ulong ncols = matrix[0].length;
  double[][] result;

  alloc_matrix(result, nrows, ncols);
  double det = determinant(matrix);
  assert(det != 0, "naive_inverse: Determinant is 0, matrix is singular!");
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

double[][] matmul(double[][] A, 
                  double[][] B) {
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

bool is_in_array(ulong element, 
                 ulong[] collection) {
  for (int i = 0; i < collection.length; i++) {
    if (element == collection[i]) {
      return true;
    }
  }
  return false;
}

double[] remove(double[] x, 
                ulong index) {
  double[] result = x[0..index] ~ x[(index+1)..$];
  return result;
}

double[][] minor_matrix(double[][] matrix, 
                        ulong row_index, 
                        ulong col_index) {
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

double[][] uniform_matrix(ulong nrows, 
                          ulong ncols, 
                          double min = 0.0, 
                          double max = 1.0) {
  assert(max > min, 
      "uniform_slice: value for argument 'min‘ must be greater than value for argument 'max'!");
  double[][] result = new double[][](nrows, ncols);
  for(int i = 0; i < nrows; i++) {
    for(int j = 0; j < ncols; j++) {
      result[i][j] = uniform(min, max);
    }
  }
  return result;
}

double[] uniform_slice(ulong length, 
                       double min = 0.0, 
                       double max = 1.0) {
  assert(max > min, 
      "uniform_slice: value for argument 'min‘ must be greater than value for argument 'max'!");
  double[] result = new double[](length);
  for(int i = 0; i < length; i++) {
     result[i] = uniform(min, max);
  }
  return result;
}
