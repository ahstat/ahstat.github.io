---
layout: post
title: Optimizing GMM parameters using EM
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

*Gaussian Mixture Models* (GMM) is a parametric clustering method modeling data as a finite mixture of Gaussians.
The number of Gaussians $$K$$ is the number of clusters and is initially selected.
Compared to $$K$$-means, GMM allows uneven variance and density for clusters.

Parameters are usually estimated using an *Expectation-Maximization* (EM) algorithm,
its aim being to iteratively increase likelihood of the set.
GMM is actually a perfect model to understand how EM is working.

Many introductions of GMM and EM exist on the web. 
This one is self-contained and focuses on math computations. No implementation is provided.

<center>
<img src="../images/2017-2-11-Optimizing-GMM-using-EM/before.png" alt="2D dataset to cluster" width="49%"/>

<img src="../images/2017-2-11-Optimizing-GMM-using-EM/after.png" alt="2D dataset after GMM clustering" width="49%"/>

</center>


*Fig. 1. Illustration of clustering a 2D dataset into 3 clusters using GMM*

We begin by describing GMM and list parameters of the model.
Then, we introduce EM and explain how it is useful to optimize parameters.
We continue by applying EM to GMM to derive update formulas.
The final algorithm to update GMM parameters iteratively is finally given.

## What is GMM?

## What is EM?

## Applying EM to GMM

## Final algorithm to update GMM parameters iteratively

