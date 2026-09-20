# 2^(15-11) fractional factorial design
# 15 factors, two levels, 16 experiments

# Generate the four basic factor columns of a 2^4 full factorial design
base <- expand.grid(
  A = c(-1, 1),
  B = c(-1, 1),
  C = c(-1, 1),
  D = c(-1, 1)
)

# Generate all non-empty combinations of the four basis columns
terms <- unlist(
  lapply(
    1:4,
    function(k) combn(names(base), k, simplify = FALSE)
  ),
  recursive = FALSE
)

# Construct the 15 factor columns
X <- sapply(
  terms,
  function(term) {
    apply(base[, term, drop = FALSE], 1, prod)
  }
)

# Name columns according to the basis columns used to generate them
colnames(X) <- vapply(
  terms,
  paste0,
  collapse = "",
  FUN.VALUE = character(1)
)

# Randomize experimental order reproducibly
set.seed(19092026)
random_order <- sample(seq_len(nrow(X)))
X <- X[random_order, , drop = FALSE]

# Add experiment numbers after randomization
design <- data.frame(
  Experiment = seq_len(nrow(X)),
  X,
  check.names = FALSE
)

# Check balance of the two-level factor columns
balance <- colSums(X)
balanced <- all(balance == 0)

# Check pairwise orthogonality
XtX <- crossprod(X)
off_diagonal <- XtX
diag(off_diagonal) <- 0
orthogonal <- all(off_diagonal == 0)

# Print the generated design matrix
print(design, row.names = FALSE)

# Print validation results
cat("\nNumber of experiments:", nrow(X), "\n")
cat("Number of factors:", ncol(X), "\n")
cat("Balanced columns:", balanced, "\n")
cat("Pairwise orthogonal columns:", orthogonal, "\n")
cat("Maximum off-diagonal value in X'X:", max(abs(off_diagonal)), "\n")

# Stop execution if validation fails
if (!balanced || !orthogonal) {
  stop("Design validation failed.")
}

# Save the generated matrix
write.csv(
  design,
  "fractional_factorial_design.csv",
  row.names = FALSE
)

cat("\nDesign matrix saved as fractional_factorial_design.csv\n")
