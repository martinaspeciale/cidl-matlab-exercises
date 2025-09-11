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

