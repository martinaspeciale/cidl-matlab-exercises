# Evolutionary Optimization (1D)

This folder contains MATLAB scripts for **evolutionary and heuristic 
optimization** on a 1-dimensional benchmark function with multiple minima.

It includes **Binary Encoding (BE)** and **Real Encoding (RE)** operators, 
plus implementations of Genetic Algorithms (GA), Evolution Strategies 
(ES), and Simulated Annealing (SA).

---

## Contents

### Encoding utilities
- **logical2real.m** — map a binary chromosome to a real value in `[a,b]`, 
using half-bin centering.
- **BE_evaluatefitness.m** — decode a binary population and compute 
fitness values.
- **BE_initpop.m** — initialize a random binary population.
- **BE_MUT_unif_all.m** — uniform bit-flip mutation across all genes with 
probability `mutprob`.
- **BE_XOVER_singlepoint.m** — single-point crossover producing two 
offspring.
- **binarytournement.m** — binary tournament selection between two 
individuals (⚠️ assumes `popsize=10` as written).

### Benchmark
- **difficult2minimafcn1D.m** — test function with multiple minima, used 
to demonstrate algorithm behavior.

### Algorithms
- **ES_BE_1D.m** — (1+1) Evolution Strategy on binary encoding (mutate 
parent; accept offspring if better).
- **GA_BE_1D.m** — canonical Genetic Algorithm with elitism:
  1. Tournament selection
  2. Single-point crossover
  3. Uniform mutation
  4. Elitism to preserve the best solution
- **GA_RE_crossover_sbx_simplified.m** — Simulated Binary Crossover (SBX) 
using one random `u` for the whole chromosome.
- **GA_RE_crossover_sbx_advanced.m** — Full per-gene SBX with bound 
handling and randomized child swap.
- **SA_RE_1D.m** — Real-encoded Simulated Annealing with exponential 
cooling and a simplified acceptance criterion (`rand < T`).

---

## Key concepts
- **BE (Binary Encoding):** solutions represented as bitstrings, decoded 
into reals via `logical2real`.  
- **RE (Real Encoding):** solutions stored directly as real numbers. 
Operators like SBX act directly on reals.
- **Elitism (in GA):** ensures the best solution is not lost when creating 
the next generation.
- **(1+1) ES:** one parent generates one offspring per iteration, replaced 
if fitter.
- **Simulated Annealing:** explores search space by sometimes accepting 
worse solutions, with probability decreasing over time.

----

## Study notes

- **logical2real**: why add half a bin → centers decoded values in their 
intervals.  
- **binarytournement**: hardcoded 10 is a limitation.  
- **GA vs ES**: GA uses crossover + population; ES uses mutation only with 
single parent/offspring.  
- **SBX parameter η**: controls spread of offspring (small η = 
exploratory, large η = exploitative).  
- **SA acceptance**: simplified in code; canonical form would use 
`exp(-(ΔE)/T)`.  

