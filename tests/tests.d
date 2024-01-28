import std.stdio : writeln;

unittest {
    import stats: remove, uniform_slice;
    writeln("array functions");
    double[] x = [1, 2, 3, 4, 5];

    //assert(is_in_array(x, 3));
    assert(remove(x, 2) == [1, 2, 4, 5]);
    assert(remove(x, 0) == [2, 3, 4, 5]);
    assert(remove(x, 4) == [1, 2, 3, 4]);

    double[] random_slice = uniform_slice(10);
    assert(random_slice.length == 10);
    writeln("uniform_slice(10) = ", random_slice, "\n");

}

unittest {
    import stats: mean, standard_deviation, weighted_mean, coef_of_variation, 
        zscore, is_close_enough, is_close_enough_slice, covariance;
    
    writeln("stats functions");
    double[] x = [1, 2, 3, 4, 5];
    double[] w = [.1, .2, .3, .4, .5];
    
    double mean_x = mean(x);
    double stddev_x = standard_deviation(x, 1);
    double wmean_x = weighted_mean(x, w);
    double coef_var_x = coef_of_variation(x);
    double[] zscores_actual = zscore(x);

    assert(is_close_enough(mean_x, 3.0));
    writeln("mean(x) = ", mean_x);

    assert(is_close_enough(stddev_x, 1.58114));
    writeln("standard_deviation(x, 1) = ", wmean_x);

    assert(is_close_enough(coef_var_x, 0.471405));
    writeln("coef_of_variation(x) = ", coef_var_x);

    assert(is_close_enough(wmean_x, 1.1));
    writeln("weighted_mean(x, w) = ", wmean_x);

    double[] zscores_expected = [-1.41421, -0.707107, 0, 0.707107, 1.41421];
    writeln(is_close_enough_slice(zscores_actual, zscores_expected));
    writeln("zscore(x, mean_x, stddev_x) = ", zscores_actual);

    double[] vec1 = [1, 2, 3];
    double[] vec2 = [3, 6, 4];
    double cov = covariance(vec1, vec2);
    writeln("covariance(vec1, vec2) = ", cov);
    assert(is_close_enough(cov, 0.5));

  
    float[] vec3 = [1, 2, 3];
    float[] vec4 = [3, 6, 4];
    float cov2 = covariance(vec3, vec4);
    writeln("covariance(vec3, vec4) = ", cov2);
    assert(is_close_enough(cov2, 0.5));

}

unittest {
    import stats: dotproduct, is_close_enough, print_matrix, minor_matrix,
        determinant, naive_inverse, transpose, matmul, uniform_matrix, trace;
    
    writeln("matrix / linalg functions");      
    double[][] A = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [10, 11, 12]
    ];
    double[][] At = [
        [1, 4, 7, 10],
        [2, 5, 8, 11],
        [3, 6, 9, 12]
    ];
    double[][] AAt = [
        [14, 32, 50, 68],
        [32, 77, 122, 167],
        [50, 122, 194, 266],
        [68, 167, 266, 365]
    ];
    double[][] A_minor = [
        [1, 2], 
        [4, 5], 
        [10, 11]
    ];
    double[][] testmatrix_2x2 = [
        [2.0, 3.0],
        [4.0, 5.0]
    ];
    double[][] testmatrix_3x3 = [
        [2, 1, 3],
        [0, -1, 4],
        [-1, 2, 1]
    ];
    double[][] inv_testmatrix_2x2 = [
        [-2.5, 1.5], [2.0, -1.0]
    ];
    double[][] inv_testmatrix_3x3 = [
        [0.36, -0.2, -0.28],
        [0.16, -0.2, 0.32],
        [0.04, 0.2, 0.08]
    ];
    
    writeln("A: ");
    print_matrix(A);

    double[] vec1 = [1, 2, 3, 4];
    double dp = dotproduct(vec1, vec1);
    assert(is_close_enough(dp, 30));
    writeln("dotproduct(vec1, vec1) = ", dp);

    double[][] At_actual = transpose(A);
    assert(At_actual == At);
    writeln("transpose(A): ");
    print_matrix(At_actual);

    double[][] A_minor_actual = minor_matrix(A, 2, 2);
    assert(A_minor_actual == A_minor);
    writeln("minor_matrix(A, 2, 2): ");
    print_matrix(A_minor_actual);

    double[][] AAt_actual = matmul(A, At_actual);
    assert(AAt_actual == AAt);
    writeln("matmul(A, t(A)): ");
    print_matrix(AAt_actual);
    
    double trace_A = trace(AAt);
    assert(is_close_enough(trace_A, 650));
    writeln("trace(AAt) = ", trace_A);
    
    writeln("testmatrix: ");
    print_matrix(testmatrix_2x2);

    double det_A = determinant(testmatrix_2x2);
    assert(is_close_enough(det_A, -2));
    writeln("determinant(testmatrix_2x2) = ", det_A);

    double[][] inv_testmatrix_2x2_actual = naive_inverse(testmatrix_2x2);
    assert(inv_testmatrix_2x2_actual == inv_testmatrix_2x2);
    writeln("naive_inverse(testmatrix_2x2)");
    print_matrix(inv_testmatrix_2x2_actual);

    double det_testmatrix_3x3 = determinant(testmatrix_3x3);
    assert(is_close_enough(det_testmatrix_3x3 , -25), "is_close_enough(det_testmatrix_3x3 , -25) != true");
    writeln("determinant(testmatrix_3x3) = ", det_testmatrix_3x3);

    double[][] inv_testmatrix_3x3_actual = naive_inverse(testmatrix_3x3);
    assert(inv_testmatrix_3x3_actual == inv_testmatrix_3x3, "inv_testmatrix_3x3_actual != inv_testmatrix_3x3");
    writeln("naive_inverse(testmatrix_3x3)");
    print_matrix(inv_testmatrix_3x3_actual);

    double[][] random_matrix = uniform_matrix(3, 4);
    assert(random_matrix.length == 3 && random_matrix[0].length == 4);
    writeln("uniform_matrix(3, 4) = ");
    print_matrix(random_matrix);

}
