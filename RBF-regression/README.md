# Radial Basis Function (RBF) Regression

This folder contains MATLAB scripts implementing **Radial Basis Function 
(RBF) regression** for 1D and 2D synthetic datasets.  
It covers dataset generation, forward computation, centre initialization, 
offline training, and prediction.

---

## Contents

### Synthetic datasets
- **mog1D_gen.m** — generate 1D mixture-of-Gaussians data.  
  *Study note:* nonlinear target with multiple bumps, ideal to show RBF 
approximation.
- **mog2D_gen.m** — generate 2D mixture-of-Gaussians surface data.  
  *Study note:* produces meshgrid `X`/`y` pairs plus `XX1,XX2,YY` for 3D 
plotting.

### RBF utilities
- **RBF_extend.m** — prepend a bias row of ones to activations.  
  *Study note:* bias is added as first row so the output layer can learn 
intercept terms.
- **RBF_forward.m** — forward pass: compute Euclidean distance to centres, 
apply Gaussian radial basis, extend bias, apply output weights.  
  *Study note:* formula \(\phi_j(x) = \exp(-\epsilon^2\|x-c_j\|^2)\); 
`epsilon` controls spread (small = narrow peaks, large = wide overlap).
- **RBF_initialize_centres.m** — choose centres (`W1`) for the hidden 
layer: random subset, fuzzy c-means clustering, or debug fixed positions.  
  *Study note:* centre placement is critical — clustering ensures coverage 
of data space.
- **RBF_train_offline.m** — train output weights (`W2`) via least squares 
once centres/width are set.  
  *Study note:* because hidden activations are fixed, training reduces to 
linear regression: `W2 = (A1' \ y)'`.
- **RBF_predict.m** — convenience wrapper: forward pass using trained 
`W1`, `W2`, and `epsilon` to get predictions.

### End-to-end demos
- **mog1D_MAIN.m** — 1D demo: generate data, set hidden units and epsilon, 
initialize centres, train offline, predict, plot, and compute MSE.  
  *Study note:* uses MSE = \(\frac{1}{2N}\sum (y-\hat{y})^2\) (includes ½ 
factor from classical squared error).
- **mog2D_MAIN.m** — 2D demo: same pipeline, applied to 2D synthetic data; 
visualizes scatter of predictions and computes MSE.

---

## Key concepts
- **RBF network structure:**  
  Input → RBF hidden layer (Gaussian units) → Linear output layer (+ 
bias).
- **Centres:** define where Gaussian bumps are located; can be random or 
data-driven.  
- **Widths (`epsilon`):** control how “local” each basis is.  
- **Offline training:** once centres and widths are fixed, output weights 
can be solved in closed form (least squares).  
- **Universal approximation:** with enough centres, an RBF network can 
approximate any continuous function.

