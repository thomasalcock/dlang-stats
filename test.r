A <- matrix(1:12, ncol = 3, nrow = 4, byrow=T)
B <- t(A)
C <- A %*% B
print(A)
print(B)
print(C)
sprintf("trace(C) = %s", sum(diag(C)))
sprintf("det(C) = %s", det(matrix(2:5, nrow = 2, ncol = 2)))
