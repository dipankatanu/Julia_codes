# code: construction of mathematical equation
using Pkg
Pkg.add("ModelingToolkit")
Pkg.add("DifferentialEquations")

using ModelingToolkit, DifferentialEquations, Plots

# Define the parameters
@parameters t k₁ k₂ k₃

# Define the variables (concentrations of A, B, and C)
@variables A(t) B(t) C(t)

# Define the derivatives for the variables
D = Differential(t)

# Define the system of ODEs based on mass action kinetics
eqs = [
    D(A) ~ -k₃ * C * A,  # C inhibits A
    D(B) ~ k₁ * A,       # A activates B
    D(C) ~ k₂ * B        # B activates C
]

# Define the ODE system
@named mass_action_model = ODESystem(eqs, t, [A, B, C], [k₁, k₂, k₃])

# Simplify the system before passing it to ODEProblem
simplified_sys = structural_simplify(mass_action_model)

# Set initial concentrations and parameter values
u₀ = [A => 1.0, B => 0.0, C => 0.0]  # Initial concentrations of A, B, C
p = [k₁ => 0.1, k₂ => 0.05, k₃ => 0.07]  # Reaction rate constants

# Define the time span
tspan = (0.0, 50.0)

# Set up the ODE problem using the simplified system
prob = ODEProblem(simplified_sys, u₀, tspan, p)

# Solve the ODE system
sol = solve(prob)

# Plot the solution
plot(sol, vars=[A, B, C], xlabel="Time", ylabel="Concentration", legend=:topright)
