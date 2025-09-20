# Multilayer Perceptron (MLP) Classifier with Sigmoid Output and Binary 
Cross-Entropy (BCESIG)

This folder contains MATLAB scripts implementing a **multilayer perceptron 
(MLP)** with one hidden layer (sigmoid activation) and a **sigmoid output 
layer**, trained using **binary cross-entropy (BCE) loss** and mini-batch 
stochastic gradient descent.

The model is applied both to a **synthetic 2D dataset** and to **MNIST**.

---

## Contents

### Core MLP utilities
- **MLP_initialize_weights.m** — initialize random weights for hidden and 
output layers (uniform in [-1,1]), including bias columns.  
- **MLP_extend.m** — prepend a bias row of ones to activations.  
- **MLP_sigmoid.m** — element-wise sigmoid activation function.  
- **MLP_sigmoid_gradient.m** — derivative of sigmoid: σ(z)·(1−σ(z)).  
- **MLP_BCESIG_forward.m** — forward pass: bias extension → hidden 
sigmoid → bias extension → output sigmoid.  
- **MLP_BCESIG_train.m** — training loop: mini-batch SGD with momentum, 
optional L1/L2 regularization, learning-rate decay, and monitoring of 
loss.  
- **MLP_BCESIG_predict.m** — compute predictions by forward pass and 
taking `argmax` over per-class sigmoid scores.*

\*Note: Sigmoid + BCE naturally supports **multi-label setups** 
(independent per-class probabilities). In the provided demos we enforce 
**single-label** by using `argmax`.

---

### Synthetic dataset
- **synth_gen.m** — generate a toy 2D classification dataset (Gaussian 
blobs, classes 0–3).  
- **synth_display.m** — plot synthetic dataset points and class labels.  
- **synth_MAIN_BCESIG.m** — demo: train MLP on synthetic data, plot loss 
curve, and display confusion matrix.

---

### MNIST dataset
- **mnist_load.m** — load MNIST digits into training and test sets, with 
class selection and size control.  
- **mnist_display.m** — visualize a grid of MNIST digit samples.  
- **mnist_MAIN_BCESIG.m** — demo: train MLP on MNIST (0–9 classes), plot 
loss, and display confusion matrix.

---

## Key concepts

- **Forward pass**  
  \[
  A_0 = \text{extend}(X), \quad
  Z_1 = W_1 A_0, \quad
  A_1 = \sigma(Z_1), \quad
  Z_2 = W_2 \,\text{extend}(A_1), \quad
  \hat{Y} = \sigma(Z_2)
  \]

- **Loss (Binary Cross-Entropy)**  
  \[
  \mathcal{L} = -\frac{1}{B}\sum_{b=1}^{B}\sum_{c=1}^{C}
  \Big(y_{c,b}\log \hat{y}_{c,b} + (1-y_{c,b})\log (1-\hat{y}_{c,b})\Big)
  \;+\;\lambda_1\|W\|_1 \;+\;\tfrac{\lambda_2}{2}\|W\|_2^2
  \]

- **Backpropagation**
  - \(dZ_2 = \hat{Y} - Y\) (sigmoid + BCE identity).  
  - \(dW_2 = dZ_2 A_1^\top\).  
  - \(dA_1 = W_2^\top dZ_2\) → drop bias row.  
  - \(dZ_1 = dA_1 \odot \sigma'(Z_1)\).  
  - \(dW_1 = dZ_1 A_0^\top\).  
  - Add L1/L2 terms if enabled.

- **Optimization**
  - **Mini-batch SGD** with momentum (`alpha`) and learning-rate decay 
(`decrease_const`).  
  - **Momentum:** stabilizes updates by adding a fraction of the previous 
update.  
  - **Learning rate decay:** gradually reduces η for convergence 
stability.

- **Evaluation**
  - **Single-label:** use `argmax` over sigmoid outputs.  
  - **Confusion matrix:** computed in demo scripts to evaluate accuracy.

---

## Study notes
- **Sigmoid + BCE gradient:** simplifies to `dZ2 = A2 - Y` (like softmax + 
CCE).  
- **Bias in backprop:** always drop the bias row before applying σ′.  
- **Regularization:** optional L1/L2, typically excluding bias terms.  
- **Single vs. multi-label:** with sigmoid outputs, you can either 
threshold at 0.5 for multi-label classification, or `argmax` for 
single-label tasks.  
- **Initialization:** random uniform in [-1,1] with bias columns included.  
- **Stability tricks:** momentum and LR decay improve training.

---

## Quick start
1. Generate data with `synth_gen.m` or `mnist_load.m`.  
2. Initialize `model` parameters (`n_hidden`, `n_output`, `eta`, `alpha`, 
`epochs`, `minibatches`, `decrease_const`, `l1`, `l2`).  
3. Call `MLP_initialize_weights`, then `MLP_BCESIG_train`.  
4. Evaluate with `MLP_BCESIG_predict` and visualize confusion matrix.  

