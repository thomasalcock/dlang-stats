import std.stdio: writeln;

unittest {
    import stats;
    import linalg;
    import arrays;
    
    writeln("array functions");
    double[] x = [1, 2, 3, 4, 5];

    //assert(is_in_array(x, 3));
    assert(remove(x, 2) == [1, 2, 4, 5]);
    assert(remove(x, 0) == [2, 3, 4, 5]);
    assert(remove(x, 4) == [1, 2, 3, 4]);

    double min = 0;
    double max = 1;
    double[] random_slice = uniform_slice(10, min, max);
    assert(random_slice.length == 10);
    writeln("uniform_slice(10) = ", random_slice, "\n");

}

unittest {
    import stats;
    import linalg;
    import arrays;

    writeln("array functions");
    float[] x = [1, 2, 3, 4, 5];

    //assert(is_in_array(x, 3));
    assert(remove(x, 2) == [1, 2, 4, 5]);
    assert(remove(x, 0) == [2, 3, 4, 5]);
    assert(remove(x, 4) == [1, 2, 3, 4]);

    float min = 0;
    float max = 1;
    float[] random_slice = uniform_slice(10, min, max);
    assert(random_slice.length == 10);
    writeln("uniform_slice(10) = ", random_slice, "\n");

}
