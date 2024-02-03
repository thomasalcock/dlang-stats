module arrays;

import std.stdio: writeln;
import std.random: uniform;
import stats: is_close_enough;

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


bool is_in_array(size_t element, 
                 size_t[] collection) {
  for (size_t i = 0; i < collection.length; i++) {
    if (element == collection[i]) {
      return true;
    }
  }
  return false;
}

T[] remove(T)(T[] x, 
              size_t index) {
  T[] result = x[0..index] ~ x[(index+1)..$];
  return result;
}


T[] uniform_slice(T)(size_t length, 
                     T min, 
                     T max) {
  assert(max > min, 
      "uniform_slice: value for argument 'min‘ must be greater than value for argument 'max'!");
  T[] result = new T[](length);
  for(size_t i = 0; i < length; i++) {
     result[i] = uniform(min, max);
  }
  return result;
}
