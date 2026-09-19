# Fractional Factorial Design in R

This repository contains an R-based solution developed as part of a coursework assignment for the postgraduate Pharmaceutical Bioinformatics course at Uppsala University.

## Aim

The aim was to construct a 2^(15-11) fractional factorial design for 15 factors investigated at two levels.

The resulting design contains 16 experimental runs. It was generated in R from four independent two-level basis columns (A-D), while the remaining columns were obtained from interaction products of these basis columns.

## Design construction

A 2^4 factorial basis was used to generate all non-empty combinations of the four basis columns:

- 4 single-factor columns: A, B, C, D
- 6 two-factor products: AB, AC, AD, BC, BD, CD
- 4 three-factor products: ABC, ABD, ACD, BCD
- 1 four-factor product: ABCD

Thus, the total number of generated factor columns is:

4 + 6 + 4 + 1 = 15

After construction, the order of the 16 experimental conditions was randomized.

## Validation

The generated design was checked computationally for balance and pairwise orthogonality.

For balance, each factor column was verified to contain equal numbers of -1 and +1 levels.

For orthogonality, the cross-product matrix X'X was calculated. The off-diagonal elements were checked to confirm that the factor columns were mutually orthogonal.

## Files

- `fractional_factorial_design.R`: R script used to construct, randomize, validate, and export the design.
- `fractional_factorial_design.csv`: generated 16-run design matrix.

## Running the script

The script uses base R and can be executed from the command line with:

    Rscript fractional_factorial_design.R

The complete design matrix and validation results are printed in the terminal. The final matrix is also exported as a CSV file.

## Reference

Lundstedt, T., Seifert, E., Abramo, L., Thelin, B., Nyström, Å., Pettersen, J., & Bergman, R. (1998). Experimental design and optimization. *Chemometrics and Intelligent Laboratory Systems*, *42*(1-2), 3-40. https://doi.org/10.1016/S0169-7439(98)00065-3
