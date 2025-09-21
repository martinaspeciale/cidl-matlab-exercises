# Multilayer Perceptron (MLP) Regressor with Linear Output and Mean 
Squared Error (MSELIN)

This folder contains MATLAB scripts implementing a **multilayer perceptron 
(MLP)** with one hidden layer (sigmoid activation) and a **linear output 
layer**, trained using **mean squared error (MSE) loss** with mini-batch 
stochastic gradient descent.

The model is demonstrated on a **synthetic 2D regression dataset** 
generated from the sinc function.

---

## Contents

### Core MLP utilities
- **MLP_initialize_weights.m** — initialize random weights for hidden and 
output layers (uniform in [-1,1]), including bias columns.  
- **MLP_extend.m** — prepend a bias row of ones to activations.  
- **MLP_sigmoid.m** — element-wise sigmoid activation.  
- **MLP_sigmoid_derivative.m** — derivative of sigmoid: σ(z)·(1−σ(z)).  
- **MLP_MSELIN_forward.m** — forward pass: bias extension → hidden 
sigmoid → bias extension → linear output.  
- **MLP_MSELIN_train.m** — training loop: mini-batch SGD with MSE loss, 
optional L1/L2 regularization, and monitoring of cost.  
- **MLP_MSELIN_predict.m** — compute predictions from the trained MLP.

### Synthetic dataset
- **sinc2D_gen.m** — generate synthetic 2D regression dataset based on the 
sinc function.  
- **sinc2D_display.m** — visualize the 2D sinc surface.  
- **sinc2D_MAIN_MSELIN.m** — demo: train MLP on sinc dataset, plot 
training/test scatter, compute MSE, and show cost evolution.

---

## Key concepts

- **Forward pass**  
  \[
  A_0 = \text{extend}(X), \quad
  Z_1 = W_1 A_0, \quad
  A_1 = \sigma(Z_1), \quad
  Z_2 = W_2 \,\text{extend}(A_1), \quad
  \hat{Y} = Z_2
  \]

- **Loss (Mean Squared Error)**  
  \[
  \mathcal{L} = \frac{1}{2B}\sum_{b=1}^{B} (y_b - \hat{y}_b)^2
  \]

- **Backpropagation**
  - \(dZ_2 = \hat{Y} - Y\).  
  - \(dW_2 = dZ_2 A_1^\top\).  
  - \(dA_1 = W_2^\top dZ_2\); drop bias row.  
  - \(dZ_1 = dA_1 \odot \sigma'(Z_1)\).  
  - \(dW_1 = dZ_1 A_0^\top\).  

- **Regularization (optional)**  
  L1 and L2 penalties are available in the training code but commented out 
in the base implementation.  

- **Optimization**
  - **Mini-batch SGD** with learning rate η.  
  - Advanced extensions (momentum `alpha`, LR decay `decrease_const`, 
regularization `l1`, `l2`) are scaffolded.

- **Evaluation**
  - Outputs are real-valued predictions (regression).  
  - Accuracy measured via **MSE** on training and test sets.

---

## Study notes
- **Linear output + MSE**: natural choice for regression tasks.  
- **Bias handling**: always remove bias row before applying σ′.  
- **Regularization**: L1 encourages sparsity; L2 penalizes large weights.  
- **Initialization**: random uniform in [-1,1] with bias columns.  
- **Dataset**: sinc2D function provides a smooth nonlinear regression 
surface.  

---

## Quick start
1. Generate dataset with `sinc2D_gen.m`.  
2. Initialize `model` parameters (`n_hidden`, `n_output`, `eta`, `epochs`, 
`minibatches`).  
3. Train with `MLP_MSELIN_train`.  
4. Predict using `MLP_MSELIN_predict`.  
5. Visualize performance with scatter plots and training loss.

