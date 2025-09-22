# Linear, Logistic & Perceptron Models with Gradient Descent

This directory collects MATLAB implementations of three foundational 
machine learning models and several gradient descent demos:

- **Linear Regression** (MSE loss, gradient descent)  
- **Logistic Regression** (Binary Cross-Entropy loss, gradient descent)  
- **Perceptron** (delta rule, Heaviside activation)  
- **Gradient Descent demos** for optimization and modeling intuition:
  - Interpolation vs. approximation (Runge-style behavior)  
  - Linear least squares via per-sample GD  
  - Minimization of a sixtic polynomial via GD  

---

## Contents

### Linear Regression (MSE + GD)
- **lin_regr_assuming_MSE_and_using_GD.m** — core trainer (MSE + GD).  
- **lin_regr_assuming_MSE_and_using_GD_MAIN.m** — demo: synthetic 2D data, 
fitted plane, MSE curve.  

### Logistic Regression (BCE + GD)
- **log_regr_assuming_BCE_and_using_GD.m** — core trainer (BCE + GD).  
- **log_regr_assuming_BCE_and_using_GD_MAIN.m** — demo: two-class data, 
decision boundary, BCE curve.  

### Perceptron
- **perceptron_train.m** — perceptron training with delta rule.  
- **perceptron_MAIN.m** — demo: two-class data, decision boundary, 3D 
surface.  

### Gradient Descent Demos
- **interpolation_vs_approximation.m** — degree-9 interpolation vs 
low-bias approximation.  
- **linearLeastSquaresUsingGD.m** — linear least squares via per-sample GD 
(with `LLS_by_GD` helper).  
- **minimumOfASixticPolynomialUsingGD.m** — GD minimization of a 
6th-degree polynomial, convergence visualization.  

### Utilities
- **polydisp.m** — pretty printer for polynomial coefficient vectors.  

---

## Key concepts

- **Linear Regression**  
  - Model: \(\hat{y}=U e\), with extended inputs \(U=[1,x_1,\dots,x_D]\).  
  - Loss: \(\mathcal{L}_{\text{MSE}}=\frac{1}{2N}\sum (y-\hat{y})^2\).  
  - Update: \(e \leftarrow e - \eta \cdot \frac{1}{N} U^\top(\hat{y}-y)\).  

- **Logistic Regression**  
  - Model: \(\hat{y}=\sigma(w^\top x)\).  
  - Loss: \(\mathcal{L}_{\text{BCE}}=-\frac{1}{N}\sum 
\big[y\log\hat{y}+(1-y)\log(1-\hat{y})\big]\).  
  - Update: \(w \leftarrow w - \eta \cdot \frac{1}{N} X^\top(\hat{y}-y)\).  

- **Perceptron**  
  - Prediction: \(\hat{y}=\mathbb{1}[w^\top x>0]\).  
  - Update: \(w \leftarrow w - \eta(\hat{y}-y)x\), repeated until 
convergence.  

- **Gradient Descent Demos**  
  - **Interpolation vs approximation:** shows high-degree oscillation vs 
smoother fits.  
  - **Linear least squares:** per-sample updates illustrate GD mechanics.  
  - **Sixtic minimization:** GD applied to a polynomial, with progress 
visualization.  

---

## Quick start
1. Run `lin_regr_assuming_MSE_and_using_GD_MAIN.m` for linear regression.  
2. Run `log_regr_assuming_BCE_and_using_GD_MAIN.m` for logistic 
regression.  
3. Run `perceptron_MAIN.m` for perceptron training.  
4. Try `interpolation_vs_approximation.m`, `linearLeastSquaresUsingGD.m`, 
or `minimumOfASixticPolynomialUsingGD.m` for GD demos.  

