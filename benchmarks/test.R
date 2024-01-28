trace <- function(M) sum(diag(M))

A <- matrix(1:12, ncol = 3, nrow = 4, byrow=T)
testmatrix <- matrix(c(2, 3, 4, 5), nrow = 2, ncol = 2, byrow=T)
testmatrix_3x3 <- matrix(c(2, 1, 3, 0, -1, 4, -1, 2, 1), nrow = 3, ncol = 3, byrow=T)

B <- t(A)
C <- A %*% B

det_testmatrix <- det(testmatrix)
det_testmatrix_3x3 <- det(testmatrix_3x3)

inv_testmatrix <- solve(testmatrix)
inv_testmatrix_3x3 <- solve(testmatrix_3x3)

trace_C <- trace(C)

print("A: ")
print(A)
print("t(A): ")
print(B)
print("A %*% B: ")
print(C)

print("minor(A, 3, 3): ")
print(A[-3, -3])

sprintf("trace(C) = %s", trace_C)

print("testmatrix: ")
print(testmatrix)

print("testmatrix_3x3: ")
print(testmatrix_3x3)

sprintf("det(C) = %s", det_testmatrix)
sprintf("det(testmatrix_3x3) = %s", det_testmatrix_3x3)

print("inv(testmatrix)")
print(inv_testmatrix)

print("inv(testmatrix_3x3)")
print(inv_testmatrix_3x3)

print("cov(c(1,2,3), c(3,6, 4))")
cov(c(1,2,3), c(3,6,4))
