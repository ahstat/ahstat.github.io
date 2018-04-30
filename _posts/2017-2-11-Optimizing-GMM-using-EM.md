---
layout: post
title: Optimizing GMM parameters using EM
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

A *Gaussian Mixture Model* (GMM) models data as a finite mixture of Gaussians. It is often used to perform clustering. In this case, the number of Gaussians $$K$$ is the number of clusters and is initially selected.
Compared to $$K$$-means, GMM allows clusters with uneven variance and density.

Parameters are usually estimated using an *Expectation-Maximization* (EM) algorithm,
its aim being to iteratively increase likelihood of the dataset.
GMM is actually a perfect model to understand how EM is working.

Many introductions of GMM and EM exist on the web. 
This one is self-contained and focuses on math computations. No implementation is provided.

<center>
<img src="../images/2017-2-11-Optimizing-GMM-using-EM/before.png" alt="2D dataset to cluster" width="49%"/>

<img src="../images/2017-2-11-Optimizing-GMM-using-EM/after.png" alt="2D dataset after GMM clustering" width="49%"/>

</center>


*Fig. 1. Clustering a 2D dataset into 3 clusters using GMM. Left: Dataset before clustering. Right: Clustered data with position of fitted means for each Gaussian.*

We begin by describing GMM and list parameters of the model.
Then, we introduce EM and explain how it is useful to optimize parameters.
We continue by applying EM to GMM and derive update formulas.
The final algorithm to cluster data is finally given.

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

Initially, we only observe $$x_i$$, without any information about the corresponding label.
We say that $$Z_i$$ is a latent variable.
Using the law of total probability, we reveal the latent variable (in the formula, $$x \in \mathbb{R}^d$$):

$$p(X_i = x) = \sum_{k = 1}^K p(X_i = x | Z_i = k) P(Z_i = k).$$

GMM assumes that three hypotheses are verified:
- The vector of couples $$(X_i, Z_i)_i$$ forms an independent vector over $$i$$,
- Each record belongs to a cluster $$Z_i = k$$ with probability $$\pi_k$$,
- Each conditional variable $$(X_i \mid Z_i = k)$$ follows a Gaussian distribution with mean $$m_k$$ and variance $$\Sigma_k$$.

Unknown (fixed) parameters of the model are grouped together into:

$$\theta := ((\pi_k)_{k \in \lbrace 1, \ldots, K \rbrace}, (m_k)_{k \in \lbrace 1, \ldots, K \rbrace}, (\Sigma_k)_{k \in \lbrace 1, \ldots, K \rbrace}).$$

We let $$X := (X_i)_{i \in \lbrace 1, \ldots n \rbrace}$$, $$Z := (Z_i)_{i \in \lbrace 1, \ldots n \rbrace}$$, $$\mathbf{z} := (z_i)_{i \in \lbrace 1, \ldots n \rbrace}$$, and $$f_{(m, \Sigma)}$$ the density of a Gaussian with parameters $$m$$ and $$\Sigma$$.

The chosen strategy to estimate $$\theta$$ is to maximize the likelihood of observed data $$\mathbf{x}$$, as defined by the density of probability to observe $$\mathbf{x}$$ given $$\theta$$:

$$L(\theta ; \mathbf{x}) := p_{\theta}(X = \mathbf{x}).$$

Using the three hypotheses of GMM, we obtain:

$$
\begin{align}
L(\theta ; \mathbf{x}) =& \prod_{i=1}^n p_{\theta}(X_i = x_i) \\
=& \prod_{i=1}^n \left[ \sum_{k = 1}^K p_{\theta}(X_i = x_i | Z_i = k) P_{\theta}(Z_i = k) \right] \\
=& \prod_{i=1}^n \left[ \sum_{k = 1}^K f_{(m_k, \Sigma_k)}(x_i) \times \pi_k \right] \\
\end{align}
$$

Under this form (a product of a sum), likelihood optimization is intractable. We introduce EM to circumvent this problem.

## What is EM?


$$
\begin{align}
L(\theta ; (\mathbf{x}, \mathbf{z})) =& \prod_{i=1}^n p_{\theta}(X_i = x_i, Z_i = z_i) \\
=& \prod_{i=1}^n \left[ p_{\theta}(Z_i = z_i | X_i = x_i) P_{\theta}(X_i = x_i) \right] \\
=& \prod_{i=1}^n \left[ p_{\theta}(Z_i = z_i | X_i = x_i) \prod_{i=1}^n P_{\theta}(X_i = x_i) \right] \\
=& \prod_{i=1}^n \left[ p_{\theta}(Z_i = z_i | X_i = x_i) \right] L(\theta ; \mathbf{x})
\end{align}
$$

## Applying EM to GMM

## Final algorithm to cluster data 

update GMM parameters iteratively

The aim is to identify the most probable label $$k$$ for $$x_i$$.
