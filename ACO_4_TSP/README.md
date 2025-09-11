# ACO_4_TSP – MATLAB Implementation

This directory contains material related to Ant Colony Optimization (ACO) 
applied to the Traveling Salesman Problem (TSP).

> Coursework for the Computational Intelligence and Deep Learning (CIDL) 
course at the University of Pisa (UniPisa).

## Repository Structure

The project is organized in logical layers, from helpers → graph → 
colony → algorithm loop → visualization:

### 1. Core helpers
- **rouletteWheel.m** – stochastic selection according to probabilities.  
- **findNode.m** – maps a deleted edge index to its node pair.  
- **midpoint.m** – computes midpoints of graph edges.  
- **average.m** – utility for mean values (used by midpoint).

### 2. Graph construction
- **createGraph.m** – builds the grid instance with nodes and weighted 
edges.  
- **addEdge.m** – inserts an undirected weighted edge.  
- **closeEdge.m** – finds which edge is closest to a click point (for 
deletion).

### 3. Colony & evaluation
- **createColony.m** – builds tours for all ants using probabilistic 
rules.  
- **fitnessFunction.m** – evaluates tour length (TSP cost).  
- **updatePheromone.m** – pheromone update by evaporation and deposit.

### 4. Main algorithm
- **ACO_loop.m** – core ACO iteration loop (construct, evaluate, update).  
- **main.m** – entry-point script: parameters, graph setup, calls ACO 
loop.

### 5. Visualization
- **drawGraph.m** – plots the graph structure.  
- **drawBestTour.m** – overlays the current best tour.  
- **drawPheromone.m** – visualizes pheromone intensity on edges.


## Interactive Demo

The project is not just a static implementation of Ant Colony 
Optimization (ACO) for the Traveling Salesman Problem (TSP) — it also 
demonstrates **how ACO adapts to changes in the environment**.

The workflow is:

1. **Run ACO on the original graph**  
   The algorithm constructs tours, updates pheromone trails, and converges 
toward a good solution.

2. **Delete an edge interactively**  
   After the first run, you can click on the plotted graph to select an 
edge to remove. That edge is set to `∞` in the distance matrix (making it 
unusable).

3. **Run ACO again with the updated graph**  
   The algorithm reuses the pheromone trails from the first phase and 
quickly adapts to the new topology, demonstrating resilience to dynamic 
changes.

Visual outputs:
- Graph of the TSP instance (with optional deleted edges highlighted)
- Current best tour (the "queen")
- Pheromone intensity heatmap across edges
- Convergence of best solution across iterations

