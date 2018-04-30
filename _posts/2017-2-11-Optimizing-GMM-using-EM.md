---
layout: post
title: Optimizing GMM parameters using EM
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

*Gaussian Mixture Models* (GMM) are a parametric clustering method which models data as a finite mixture of Gaussians.
The number of Gaussians $$K$$ is the number of clusters and is initially selected.
Compared to $$K$$-means, GMM allows clusters with uneven variance and density.

Parameters are usually estimated using an *Expectation-Maximization* (EM) algorithm,
its aim being to iteratively increase likelihood of the set.
GMM is actually a perfect model to understand how EM is working.

Many introductions of GMM and EM exist on the web. 
This one is self-contained and focuses on math computations. No implementation is provided.

<center>
<img src="../images/2017-2-11-Optimizing-GMM-using-EM/before.png" alt="2D dataset to cluster" width="49%"/>

<img src="../images/2017-2-11-Optimizing-GMM-using-EM/after.png" alt="2D dataset after GMM clustering" width="49%"/>

</center>


*Fig. 1. Illustration of clustering a 2D dataset into 3 clusters using GMM. Left: Dataset before clustering. Right: Clustered data with position of fitted means for each Gaussian.*

We begin by describing GMM and list parameters of the model.
Then, we introduce EM and explain how it is useful to optimize parameters.
We continue by applying EM to GMM and derive update formulas.
The final algorithm to update GMM parameters iteratively is finally given.

## What is GMM?

Let $$\mathbf{x} = (x_i)_{i \in \lbrace 1, \ldots n \rbrace}$$ a dataset of $$\mathbb{R}^d$$.

Let $$i$$ any element of $$\lbrace 1, \ldots n \rbrace$$.
We assume that $$x_i$$ has been sampled from a random variable $$X_i$$.
We assume that $$X_i$$ follows a probability distribution with a certain density.
The density of $$X_i$$ in any $$x \in \mathbb{R}^d$$ is written as follows:

$$p(X_i = x).$$

In addition, we assume that $$x_i$$ is labeled with a certain $$k \in \lbrace 1, \ldots, K \rbrace$$,
where $$K$$ is a fixed integer.
The underlying random variable to model the label is noted $$Z_i$$, and the probability
to be labeled $$k$$ is written as follows:

$$P(Z_i = k).$$

Initially, we only observe $$x_i$$, without any information about related label.
We say that $$Z_i$$ is a latent variable.
The aim is to identify the most probable label $$k$$ for $$x_i$$.

Using the law of total probability, we reveal the hidden variable (for $$x \in \mathbb{R}^d$$):

$$p(X_i = x) = \sum_{k = 1}^K p(X_i = x | Z_i = k) P(Z_i = k).$$

On the whole, GMM assumes that three hypotheses are verified:
- The set of couples $$(X_i, Z_i)_i$$ is an independent vector over the rows $i$,
- Each record belongs to a cluster $$Z_i = k \in \lbrace 1, \ldots, K \rbrace$$ with probability $$\pi_k$$,
- Each conditional variable $$(X_i \mid Z_i = k)$$ follows a Gaussian distribution with mean and variance $$m_k, \Sigma_k$$.

Unknown parameters of the model are grouped together into:

$$\theta := ((\pi_k)_{k \in \lbrace 1, \ldots, K \rbrace}, (m_k)_{k \in \lbrace 1, \ldots, K \rbrace}, (\Sigma_k)_{k \in \lbrace 1, \ldots, K \rbrace}).$$



## What is EM?

## Applying EM to GMM

## Final algorithm to update GMM parameters iteratively

