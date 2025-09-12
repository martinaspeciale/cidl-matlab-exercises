# PSO Demo (3D Quadratic)

This script minimizes a 3D quadratic with a known optimum **[4, 5, −6]** 
using Particle Swarm Optimization (PSO).  
It initializes a swarm within **[-10, 10]^3**, updates velocities with 
inertia + cognitive + social terms, clamps positions to bounds, and prints 
the global best cost per iteration.

**Parameters**: `n_particles=10`, `max_iterations=30`, `w=0.5`, `c1=0.8`, 
`c2=0.9`.

