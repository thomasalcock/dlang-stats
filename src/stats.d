module stats;

import std.stdio : writeln;
import std.math: sqrt, pow, abs;

// TODO: implement a dimension check that iterates over all
// rows of a matrix to ensure uniform column dimension

T covariance(T)(T[] x, T[] y) {
  T result = 0;
  T mean_x = mean(x);
  T mean_y = mean(y);
  size_t n = x.length;
  for(size_t i = 0; i < n; i++) {
    result += (x[i] - mean_x) * (y[i] - mean_y);
  }
  return result / (n -1);
}

T mean(T)(T[] data) {
  T result = 0;
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
                   T[] weights) {
  assert(data.length == weights.length, 
      "weighted_mean: data and weights have different lengths!");
  T result = 0;
  for (size_t i = 0; i < data.length; i++) {
      result += data[i] * weights[i];
  }
  return result / data.length;
}

T variance(T)(T[] data, 
           size_t degrees_of_freedom = 0) {
  T result = 0;
  T mean = mean(data);
  foreach (ref e; data) {
    result += pow((e - mean), 2);
  }
  return result / (data.length - degrees_of_freedom);
}

T standard_deviation(T)(T[] data, 
                        size_t degrees_of_freedom = 0) {
	return sqrt(variance(data, degrees_of_freedom = degrees_of_freedom));
}

T coef_of_variation(T)(T[] data) {
  return standard_deviation(data) / mean(data);
}

bool is_close_enough(T)(T x, 
                        T y) {
  return abs(x - y) < 1.16992e-06;
}

