
# Import required libraries
# add LightGraphs
# add GraphPlot
# add Plots

using LightGraphs
using GraphPlot
using Plots

# Define the adjacency matrix
adjacency_matrix = [
    0 1 0 1 0;
    1 0 1 1 1;
    0 1 0 1 0;
    1 1 1 0 1;
    0 1 0 1 0
]

# Create a graph from the adjacency matrix
g = SimpleGraph(adjacency_matrix)

# Find the degree of each node
degrees = degree(g)

# Find the maximum degree (hubs)
max_degree = maximum(degrees)
hubs = findall(x -> x == max_degree, degrees)

# Display the results
println("The hub nodes are: ", hubs)
println("The maximum degree is: ", max_degree)