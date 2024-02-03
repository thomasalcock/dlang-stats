module linalg;

import std.stdio: writeln;
import std.random: uniform;
import std.math: pow;

void alloc_matrix(T)(ref T[][]result, 
                     size_t n_rows, 
                     size_t n_cols) {
  result.length = n_rows;
  //writeln("Capacity for row space: ", result.capacity);
  foreach(ref row; result) {
    row.length = n_cols; 
    //writeln("Capacity for column space: ", row.capacity);
  }
}

T[][] transpose(T)(T[][] matrix) {
  size_t nrows = matrix.length;
  size_t ncols = matrix[0].length;
  T[][] result;

  alloc_matrix(result, ncols, nrows);

  for (size_t i = 0; i < nrows; i++) {
    for (size_t j = 0; j < ncols; j++) {
        result[j][i] = matrix[i][j];
    }
  }
  return result;
}

void print_matrix(T)(T[][] matrix) {
  foreach (ref row; matrix) {
    writeln(row);
  }
  writeln("\n");
}

T dotproduct(T)(T[] x, 
                T[] y) {
  T result = 0;
  assert(x.length == y.length, "dotproduct: x and y do not have equal length!");
  for (size_t i = 0; i < x.length; i++) {
    result += x[i] * y[i];
  }
  return result;
}

T[][] naive_inverse(T)(T[][] matrix) {
  assert(is_square_matrix(matrix), "Matrix is not square!");
  
  size_t nrows = matrix.length;
  size_t ncols = matrix[0].length;
  T[][] result;

  alloc_matrix(result, nrows, ncols);
  T det = determinant(matrix);
  assert(det != 0, "naive_inverse: Determinant is 0, matrix is singular!");
  T inv_det = 1/det;
  for (size_t i = 0; i < nrows; i++) {
    for (size_t j = 0; j < ncols; j++) {
      // somehow the indices need to be switched to get the correct result, otherwise the resulting matrix
      // needs to be transposed again
      result[j][i] = inv_det * pow(-1, i+j) * determinant(minor_matrix(matrix, i, j));
    }
  }
  return result;
}

T[][] matmul(T)(T[][] A, 
                T[][] B) {
  // A(n x k) * B(k x m) -> C(n x m)
  assert(A[0].length == B.length, "matmul: Matrix dimensions do not match!"); // these dimensions should be k
  
  size_t n = A.length;
  size_t k = A[0].length;
  size_t m = B[0].length;
  
  T[][] result;
  alloc_matrix(result, n, m);

  for (size_t i = 0; i < n; i++) {
    for (size_t j = 0; j < m; j++) {
      result[i][j] = 0;
    }
  }

  for (size_t i = 0; i < n; i++) {
    for (size_t j = 0; j < m; j++) {
      for (size_t l = 0; l < k; l++) {
        result[i][j] += A[i][l] * B[l][j];
      }
    }
  }
  return result;
}

bool is_square_matrix(T)(T[][] matrix) {
  return matrix.length == matrix[0].length;
}

T trace(T)(T[][] matrix) {
  assert(is_square_matrix(matrix), "trace: Matrix is not square!");
  
  size_t nrows = matrix.length;
  size_t ncols = matrix[0].length;
  
  T result = 0;
  
  for (size_t i = 0; i < nrows; i++) {
    for (size_t j = 0; j < ncols; j++) {
      if (i == j) {
        result += matrix[i][j];
      }
    }
  }
  return result;
}

T[][] minor_matrix(T)(T[][] matrix, 
                   size_t row_index, 
                   size_t col_index) {
  T[][] result;
  foreach (i, row; matrix) {
    if (i != row_index) {
      result ~= row[0..col_index] ~ row[(col_index + 1)..$];
    }
  }
  return result;
}
  
T determinant(T)(T[][] matrix) {
    assert(is_square_matrix(matrix), "determinannt: Matrix is not square!");
    T result = 0;
    size_t nrows = matrix.length;
    size_t ncols = matrix[0].length;

    if (nrows == 1 && ncols == 1) {
        return matrix[0][0];
    }

    for (size_t j = 0; j < ncols; j++) {
        T[][] M = minor_matrix(matrix, 0, j);
        if (M.length > 0) {
            result += pow(-1, 0 + j) * matrix[0][j] * determinant(M);
        } else {
            result += 0;
        }
    }
    return result;
}

T[][] uniform_matrix(T)(size_t nrows, 
                        size_t ncols, 
                        T min, 
                        T max) {
  assert(max > min, 
      "uniform_matrix: value for argument 'min‘ must be greater than value for argument 'max'!");
  T[][] result = new T[][](nrows, ncols);
  for(size_t i = 0; i < nrows; i++) {
    for(size_t j = 0; j < ncols; j++) {
      result[i][j] = uniform(min, max);
    }
  }
  return result;
}


size_t [] dim(T)(T[][] matrix) {
  return [
    matrix.length, // n rows
    matrix[0].length // n columns
  ];
}
