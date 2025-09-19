# Multilayer Perceptron (MLP) Classifier with Softmax

This folder contains MATLAB scripts implementing a **multilayer perceptron 
(MLP)** with one hidden layer (sigmoid activation) and a softmax output, 
trained using **categorical cross-entropy loss** and mini-batch stochastic 
gradient descent.

The model is applied both to a **synthetic 2D dataset** and to **MNIST**.

---

## Contents

### Core MLP utilities
- **MLP_initialize_weights.m** — initialize random weights for hidden and 
output layers (uniform in [-1,1]), including bias columns.
- **MLP_extend.m** — prepend a bias row of ones to activations.
- **MLP_sigmoid.m** — element-wise sigmoid activation function.
- **MLP_sigmoid_gradient.m** — derivative of sigmoid: σ(z)·(1−σ(z)).
- **MLP_softmax.m** — compute softmax outputs (column-wise) for 
classification.
- **MLP_CCESM_forward.m** — forward pass: bias extension → hidden sigmoid 
→ bias extension → softmax output.
- **MLP_CCESM_train.m** — training loop: mini-batch SGD with momentum, 
optional L1/L2 regularization, learning rate decay, and monitoring of 
loss.
- **MLP_CCESM_predict.m** — compute predictions by forward pass and taking 
`argmax`.

### Synthetic dataset
- **synth_gen.m** — generate a toy 2D classification dataset (4 Gaussian 
blobs, classes 0–3).
- **synth_display.m** — plot synthetic dataset points and class labels.
- **synth_MAIN_CCESM.m** — demo: train MLP on synthetic data, plot loss 
curve, and display confusion matrix.

### MNIST dataset
- **mnist_load.m** — load MNIST digits into training and test sets, with 
class selection and size control.
- **mnist_display.m** — visualize a grid of MNIST digit samples.
- **mnist_MAIN_CCESM.m** — demo: train MLP on MNIST (0–9 classes), plot 
loss, and display confusion matrix.

---

## Key concepts
- **Forward pass:**  
  \(A_0 = \text{extend}(X),\; Z_1=W_1A_0,\; A_1=\sigma(Z_1),\; 
Z_2=W_2\text{extend}(A_1),\; A_2=\text{softmax}(Z_2)\).
- **Loss:** categorical cross-entropy with optional L1/L2 penalties.  
- **Backpropagation:**  
  - \(dZ_2 = A_2 - Y\) (softmax + CCE gradient identity).  
  - \(dZ_1 = (W_2^\top dZ_2)_{\text{no-bias}} \odot \sigma'(Z_1)\).  
  - \(dW_2 = dZ_2 A_1^\top,\; dW_1 = dZ_1 A_0^\top\).  
- **SGD update:** with learning rate decay (`decrease_const`) and momentum 
(`alpha`).

---

## Study notes
- **Softmax + CCE:** gradient simplifies to `dZ2 = A2 - Yenc`.  
- **Bias in backprop:** must drop the bias row of `dA1` before applying 
σ′.  
- **Sigmoid derivative:** σ(z)(1−σ(z)) — already in 
`MLP_sigmoid_gradient`.  
- **Weight init:** random uniform in [-1,1], shaped with bias columns.  
- **Regularization:** `model.l1` and `model.l2` available; in theory add 
to grads (`+2λW` or `+λ sign(W)`), though Week 6 code doesn’t explicitly.  
- **Momentum (α):** adds part of the previous update, stabilizes and 
accelerates training.  
- **Learning rate decay:** gradually decreases η to improve convergence 
stability.  
- **Confusion matrix:** used in `*_MAIN.m` scripts to evaluate 
classification accuracy.

