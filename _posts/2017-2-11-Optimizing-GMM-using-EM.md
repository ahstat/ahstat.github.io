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
This one is self-contained, use inductive reasoning, and focuses on math computations. No implementation is provided.

<center>
<img src="../images/2017-2-11-Optimizing-GMM-using-EM/before.png" alt="2D dataset to cluster" width="49%"/>

<img src="../images/2017-2-11-Optimizing-GMM-using-EM/after.png" alt="2D dataset after GMM clustering" width="49%"/>

</center>


*Fig. 1. Clustering a 2D dataset into 3 clusters using GMM. Left: Dataset before clustering. Right: Clustered data with position of fitted mean for each Gaussian.*

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

Initially, we only observe $$x_i$$, *without any information about the corresponding label*.
We say that $$Z_i$$ is a latent variable.
Using the law of total probability, we reveal the latent variable (in the formula, $$x \in \mathbb{R}^d$$):

$$p(X_i = x) = \sum_{k = 1}^K p(X_i = x | Z_i = k) \times P(Z_i = k).$$

GMM assumes that three hypotheses are verified:
1. The vector of couples $$(X_i, Z_i)_i$$ forms an independent vector over $$i$$,
2. Each record belongs to a cluster $$Z_i = k$$ with probability $$\pi_k$$ (with $$\pi_k > 0$$),
3. Each conditional variable $$(X_i \mid Z_i = k)$$ follows a Gaussian distribution with mean $$m_k$$ and covariance matrix $$\Sigma_k$$.

We let $$f_{(m, \Sigma)}$$ the density function of a Gaussian with parameters $$m$$ and $$\Sigma$$.
Using hypotheses 2 and 3, the last equation is rewritten as follows (for all $$i, x$$):

$$p(X_i = x) = \sum_{k = 1}^K f_{(m_k, \Sigma_k)}(x_i) \times \pi_k.$$

Unknown (fixed) parameters of the model are grouped together into:

$$\theta := ((\pi_k)_{k \in \lbrace 1, \ldots, K \rbrace}, (m_k)_{k \in \lbrace 1, \ldots, K \rbrace}, (\Sigma_k)_{k \in \lbrace 1, \ldots, K \rbrace}).$$

We let $$\mathbf{X} := (X_i)_{i \in \lbrace 1, \ldots n \rbrace}$$ and $$\mathbf{Z} := (Z_i)_{i \in \lbrace 1, \ldots n \rbrace}$$. The realization of the couple $$(X_i, Z_i)$$ is noted $$(x_i, z_i)$$ ($$z_i$$ remains unknown and is the true label related to $$x_i$$).

The chosen strategy to estimate $$\theta$$ is to maximize the log-likelihood of observed data $$\mathbf{x}$$, as defined by the density of probability to observe $$\mathbf{x}$$ given $$\theta$$:

$$\log L(\theta ; \mathbf{x}) := \log p_{\theta}(\mathbf{X} = \mathbf{x}).$$

Using the three hypotheses of GMM, we obtain:

$$
\begin{align}
\log L(\theta ; \mathbf{x}) =& \log \prod_{i=1}^n p_{\theta}(X_i = x_i) \\
=& \sum_{i=1}^n \log p_{\theta}(X_i = x_i) \\
=& \sum_{i=1}^n \log \left[ \sum_{k = 1}^K p_{\theta}(X_i = x_i | Z_i = k) P_{\theta}(Z_i = k) \right] \\
=& \sum_{i=1}^n \log \left[ \sum_{k = 1}^K f_{(m_k, \Sigma_k)}(x_i) \times \pi_k \right] \\
\end{align}
$$

However, this log-likelihood function is non-convex (as a function of $$\theta$$) and direct optimization is intractable (see [this post for a discussion](https://stats.stackexchange.com/questions/94559/why-is-optimizing-a-mixture-of-gaussian-directly-computationally-hard)). We introduce EM to circumvent this problem (other methods could work, see [this post for a discussion](https://stats.stackexchange.com/questions/158859/why-should-one-use-em-vs-say-gradient-descent-with-mle)).

## What is EM algorithm?

EM is "an iterative method to find maximum likelihood estimates of parameters in statistical models, where the model depends on unobserved latent variables" ([Wikipedia](https://en.wikipedia.org/wiki/Expectation%E2%80%93maximization_algorithm)).

It works when we are in the following context:
"If latent variables were observed, then the maximum likelihood estimation would be easy" ([CS229 Lecture](http://cs229.stanford.edu/notes/cs229-notes8.pdf)).



In this section, $$\mathbf{x} \in \left(\mathbb{R}^d \right)^n$$ is the set of observed data, $$\mathbf{z}_{\text{true}} \in \lbrace 1, \ldots, K \rbrace^n$$ the set of unobserved latent data, and $$\theta$$ the unknown (fixed) set of parameters. The couple $$(\mathbf{x}, \mathbf{z}_{\text{true}})$$ is a realization of the random variable $$(\mathbf{X}, \mathbf{Z})$$.

We continue to use letter $$p$$ for density and $$P$$ for probabilities.
For the sake of conciseness, we discard notation of the random variable: For example, we write $$P(\mathbf{z})$$ for  $$P(\mathbf{Z} = \mathbf{z})$$, and $$p(\mathbf{x})$$ for $$p(\mathbf{X} = \mathbf{x})$$.

In the following equations, we always consider cases where all terms are well-defined.


The context is as follows: Knowing $$(\mathbf{x}, \mathbf{z})$$


First state the algorithm, what we compute. And only after, we make some inductive proof, so this can be skipped in first lecture (Core of EM not that easy!)


### Two equations.

#### Knowing $$z$$...

$$p_{\theta}(\mathbf{x}, \mathbf{z}) = p_{\theta}(\mathbf{x} | \mathbf{z}) P_{\theta}(\mathbf{z})$$

If $$\mathbf{x}$$ and $$\mathbf{z}$$ are available, it is easy to compute $$p_{\theta}(\mathbf{x}, \mathbf{z})$$ using this above equation.

If $$\mathbf{z}$$ is unobserved, we need to sum over all $$\mathbf{z}$$ to compute $$p_{\theta}(\mathbf{x})$$, and this is difficult to optimize (as seen in section I)

$$p_{\theta}(\mathbf{x}) = \sum_{\mathbf{z}} p_{\theta}(\mathbf{x}, \mathbf{z}) = \sum_{\mathbf{z}} p_{\theta}(\mathbf{x} | \mathbf{z}) P_{\theta}(\mathbf{z})$$

#### Expectation....

$$p_{\theta}(\mathbf{x}, \mathbf{z}) = P_{\theta}(\mathbf{z} | \mathbf{x}) p_{\theta}(\mathbf{x})$$

Something great, the likelihood of observations $$p_{\theta}(\mathbf{x})$$ is here.

We obtain:

$$\log p_{\theta}(\mathbf{x}) = \log p_{\theta}(\mathbf{x}, \mathbf{z}) - \log P_{\theta}(\mathbf{z} | \mathbf{x})$$

The previous equation is valid for any $$z$$.

On the right it is the likelihood; First term on the right is the joint density which is straightforward (see previous equation); Second term on the right is the problematic one. How could we compute this???

Answer: We will not compute this.
First from the equation, $$\mathbf{z}$$ is any element. 
So for any distribution $$(r_\mathbf{z})_{\mathbf{z}}$$ (so nonnegative and sum to $$1$$), we have:

$$\sum_{\mathbf{z}} r_\mathbf{z} \log p_{\theta}(\mathbf{x}) = \sum_{\mathbf{z}} r_\mathbf{z} \log p_{\theta}(\mathbf{x}, \mathbf{z}) - \sum_{\mathbf{z}} r_\mathbf{z} \log P_{\theta}(\mathbf{z} | \mathbf{x})$$

But $$\log p_{\theta}(\mathbf{x})$$ does not depend on $$\mathbf{z}$$, and $$\sum_{\mathbf{z}} r_\mathbf{z}$$ sums to one, so:

$$\log p_{\theta}(\mathbf{x}) = \sum_{\mathbf{z}} r_\mathbf{z} \log p_{\theta}(\mathbf{x}, \mathbf{z}) - \sum_{\mathbf{z}} r_\mathbf{z} \log P_{\theta}(\mathbf{z} | \mathbf{x}).$$

To interpret it now, it is expectancy, as if $$\mathbf{z}$$ has been sampled from $$(r_\mathbf{z})_{\mathbf{z}}$$.

We've said that second term on the right is the problem, so it is:

$$- \sum_{\mathbf{z}} r_\mathbf{z} \log P_{\theta}(\mathbf{z} | \mathbf{x})$$

We would like to select $$r_\mathbf{z}$$ such that previous equation has a special form. Cannot decrease... Ok try it.

We let:
$$H(\theta, r) = - \sum_{\mathbf{z}} r_\mathbf{z} \log P_{\theta}(\mathbf{z} | \mathbf{x}).$$

We assume that we have selected current parameters $$\theta_0$$.
Can we select $$r$$ such that for all choice of $$\theta$$,

$$H(\theta, r) \geq H(\theta_0, r)?$$

Try to find it.

$$ -\sum_{\mathbf{z}} r_\mathbf{z} \log P_{\theta}(\mathbf{z} | \mathbf{x}) \geq -\sum_{\mathbf{z}} r_\mathbf{z} \log P_{\theta_0}(\mathbf{z} | \mathbf{x})?$$

Let $$p = P_{\theta_0}(\mathbf{z} \mid \mathbf{x})$$, $$q = P_{\theta}(\mathbf{z} \mid \mathbf{x})$$

$$ -\sum_{\mathbf{z}} r_\mathbf{z} \log q_\mathbf{z} \geq -\sum_{\mathbf{z}} r_\mathbf{z} \log p_\mathbf{z} ?$$

If we index with $$i$$:

$$ -\sum_{i} r_i \log q_i \geq -\sum_{i} r_i \log p_i ?$$

$$ \sum_{i} r_i \times (-\log q_i/p_i) \geq 0 ?$$

Sum not easy to compute, but $$-\log$$ is convex, so try Jensen's inequality. We have:

$$ \sum_{i} r_i \times (-\log q_i/p_i) \geq - \log \sum_{i} r_i q_i/p_i$$

We want $$- \log \sum_{i} r_i q_i/p_i \geq 0$$
so $$\sum_{i} r_i q_i/p_i \leq 1$$

From here, a natural choice would be: $$r_i := p_i$$.
For this one it is working, and also a nice interpretation with Kullback's divergence.

So we rewrite our notations for $$H$$.

Then the equation with $$Q$$ and $$H$$.

What do it say: Expectation.

### Maximization

Over $$\theta$$.

$$p_{\theta}(\mathbf{x}, \mathbf{z}) = p_{\theta}(\mathbf{x} | \mathbf{z}) P_{\theta}(\mathbf{z})$$

Maybe a little confuse how this work in detail, especially for the maximization step.

One thing good with GMM, is that in that case, we can have closed form formulas for this maximization steps. Let's see how it works in the next step.

## Applying EM to GMM

Update formulas for mean and variance and the latent proba.

## Final algorithm to cluster data 

Here the final simple algorithm.

update GMM parameters iteratively

The aim is to identify the most probable label $$k$$ for $$x_i$$.

## References

English wikipedia. For formulas, it's good and concise. https://en.wikipedia.org/wiki/Expectation%E2%80%93maximization_algorithm

This one is great. Quite the same perspective as in this post.
http://cs229.stanford.edu/notes/cs229-notes8.pdf

https://www.cs.utah.edu/~piyush/teaching/EM_algorithm.pdf ?

user.it.uu.se/~thosc112/pubpdf/schonem2009.pdf ?
