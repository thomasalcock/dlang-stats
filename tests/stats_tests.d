import std.stdio : writeln;

unittest {
    import stats;
    import linalg;
    import arrays;

    writeln("stats functions");
    float[] x = [1, 2, 3, 4, 5];
    float[] w = [.1, .2, .3, .4, .5];
    
    float mean_x = mean(x);
    float stddev_x = standard_deviation(x, 1);
    float wmean_x = weighted_mean(x, w);
    float coef_var_x = coef_of_variation(x);
    float[] zscores_actual = zscore(x);

    assert(is_close_enough(mean_x, 3.0));
    writeln("mean(x) = ", mean_x);

    assert(is_close_enough(stddev_x, 1.58114));
    writeln("standard_deviation(x, 1) = ", wmean_x);

    assert(is_close_enough(coef_var_x, 0.471405));
    writeln("coef_of_variation(x) = ", coef_var_x);

    assert(is_close_enough(wmean_x, 1.1));
    writeln("weighted_mean(x, w) = ", wmean_x);

    float[] zscores_expected = [-1.41421, -0.707107, 0, 0.707107, 1.41421];
    writeln(is_close_enough_slice(zscores_actual, zscores_expected));
    writeln("zscore(x, mean_x, stddev_x) = ", zscores_actual);

    float[] vec1 = [1, 2, 3];
    float[] vec2 = [3, 6, 4];
    float cov = covariance(vec1, vec2);
    writeln("covariance(vec1, vec2) = ", cov);
    assert(is_close_enough(cov, 0.5));
  
    float[] vec3 = [1, 2, 3];
    float[] vec4 = [3, 6, 4];
    float cov2 = covariance(vec3, vec4);
    writeln("covariance(vec3, vec4) = ", cov2);
    assert(is_close_enough(cov2, 0.5));

}

unittest {
    import stats;
    import linalg;
    import arrays;
    
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

