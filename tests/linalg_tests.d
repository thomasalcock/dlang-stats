
import std.stdio: writeln;

unittest {
    import stats;
    import linalg;
    import arrays;
    
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
    double expected_det_A = -2;
    //assert(is_close_enough(det_A, expected_det_A));
    writeln("determinant(testmatrix_2x2) = ", det_A);
    
    double[][] inv_testmatrix_2x2_actual = naive_inverse(testmatrix_2x2);
    //assert(inv_testmatrix_2x2_actual == inv_testmatrix_2x2);
    writeln("naive_inverse(testmatrix_2x2)");
    print_matrix(inv_testmatrix_2x2_actual);

    double det_testmatrix_3x3 = determinant(testmatrix_3x3);
    assert(is_close_enough(det_testmatrix_3x3 , -25), "is_close_enough(det_testmatrix_3x3 , -25) != true");
    writeln("determinant(testmatrix_3x3) = ", det_testmatrix_3x3);

    double[][] inv_testmatrix_3x3_actual = naive_inverse(testmatrix_3x3);
    assert(inv_testmatrix_3x3_actual == inv_testmatrix_3x3, "inv_testmatrix_3x3_actual != inv_testmatrix_3x3");
    writeln("naive_inverse(testmatrix_3x3)");
    print_matrix(inv_testmatrix_3x3_actual);

    double min = 0;
    double max = 1;
    double[][] random_matrix = uniform_matrix(3, 4, min, max);
    assert(random_matrix.length == 3 && random_matrix[0].length == 4);
    writeln("uniform_matrix(3, 4) = ");
    print_matrix(random_matrix);

}


unittest {
    import stats;
    import linalg;
    import arrays;
    
    writeln("matrix / linalg functions");      
    float[][] A = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [10, 11, 12]
    ];
    float[][] At = [
        [1, 4, 7, 10],
        [2, 5, 8, 11],
        [3, 6, 9, 12]
    ];
    float[][] AAt = [
        [14, 32, 50, 68],
        [32, 77, 122, 167],
        [50, 122, 194, 266],
        [68, 167, 266, 365]
    ];
    float[][] A_minor = [
        [1, 2], 
        [4, 5], 
        [10, 11]
    ];
    float[][] testmatrix_2x2 = [
        [2.0, 3.0],
        [4.0, 5.0]
    ];
    float[][] testmatrix_3x3 = [
        [2, 1, 3],
        [0, -1, 4],
        [-1, 2, 1]
    ];
    float[][] inv_testmatrix_2x2 = [
        [-2.5, 1.5], [2.0, -1.0]
    ];
    float[][] inv_testmatrix_3x3 = [
        [0.36, -0.2, -0.28],
        [0.16, -0.2, 0.32],
        [0.04, 0.2, 0.08]
    ];
    
    writeln("A: ");
    print_matrix(A);

    float[] vec1 = [1, 2, 3, 4];
    float dp = dotproduct(vec1, vec1);
    assert(is_close_enough(dp, 30));
    writeln("dotproduct(vec1, vec1) = ", dp);

    float[][] At_actual = transpose(A);
    assert(At_actual == At);
    writeln("transpose(A): ");
    print_matrix(At_actual);

    float[][] A_minor_actual = minor_matrix(A, 2, 2);
    assert(A_minor_actual == A_minor);
    writeln("minor_matrix(A, 2, 2): ");
    print_matrix(A_minor_actual);

    float[][] AAt_actual = matmul(A, At_actual);
    assert(AAt_actual == AAt);
    writeln("matmul(A, t(A)): ");
    print_matrix(AAt_actual);
    
    float trace_A = trace(AAt);
    assert(is_close_enough(trace_A, 650));
    writeln("trace(AAt) = ", trace_A);
    
    writeln("testmatrix: ");
    print_matrix(testmatrix_2x2);

    float det_A = determinant(testmatrix_2x2);
    assert(is_close_enough(det_A, -2));
    writeln("determinant(testmatrix_2x2) = ", det_A);

    float[][] inv_testmatrix_2x2_actual = naive_inverse(testmatrix_2x2);
    assert(inv_testmatrix_2x2_actual == inv_testmatrix_2x2);
    writeln("naive_inverse(testmatrix_2x2)");
    print_matrix(inv_testmatrix_2x2_actual);

    float det_testmatrix_3x3 = determinant(testmatrix_3x3);
    assert(is_close_enough(det_testmatrix_3x3 , -25), "is_close_enough(det_testmatrix_3x3 , -25) != true");
    writeln("determinant(testmatrix_3x3) = ", det_testmatrix_3x3);

    float[][] inv_testmatrix_3x3_actual = naive_inverse(testmatrix_3x3);
    assert(inv_testmatrix_3x3_actual == inv_testmatrix_3x3, "inv_testmatrix_3x3_actual != inv_testmatrix_3x3");
    writeln("naive_inverse(testmatrix_3x3)");
    print_matrix(inv_testmatrix_3x3_actual);

    float min = 0;
    float max = 1;
    float[][] random_matrix = uniform_matrix(3, 4, min, max);
    assert(random_matrix.length == 3 && random_matrix[0].length == 4);
    writeln("uniform_matrix(3, 4) = ");
    print_matrix(random_matrix);

}
