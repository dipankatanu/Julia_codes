## Code: PCA in Julia
using Pkg
Pkg.add(["MultivariateStats","Plots"])

# Load required packages
using MultivariateStats, Plots, Random, Statistics, LinearAlgebra

Random.seed!(42)
genes = 20000
samples = 500
data = rand(1:1000, 10000, 50)  # Random gene expression values

# Standardization of the data (mean-centered and scaled by standard deviation across genes)
data_standardized = (data .- mean(data, dims=1)) ./ std(data, dims=1)

# PCA on transposed data (samples as rows, genes as columns)
pca_model = fit(PCA, data_standardized')

# Projections of the samples onto the first two principal components
pca_result = MultivariateStats.transform(pca_model, data_standardized')

# Plotting the PCA results
scatter(pca_result[:, 1], pca_result[:, 2], 
    title = "PCA of RNA-seq Data (Samples)", 
    xlabel = "PC1", 
    ylabel = "PC2", 
    markercolor = :blues, 
    markersize = 8, 
    legend = false, 
    grid = true)

