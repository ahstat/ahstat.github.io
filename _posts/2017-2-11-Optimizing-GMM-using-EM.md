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
This one starts from the problem and use inductive reasoning to bring out EM.
No implementation is provided.

<center>
<img src="../images/2017-2-11-Optimizing-GMM-using-EM/before.png" alt="2D dataset to cluster" width="49%"/>

<img src="../images/2017-2-11-Optimizing-GMM-using-EM/after.png" alt="2D dataset after GMM clustering" width="49%"/>

</center>


*Fig. 1. Clustering a 2D dataset into 3 clusters using GMM. Left: Dataset before clustering. Right: Clustered data with position of fitted mean for each Gaussian.*

[TODO again]
We begin by describing GMM and list parameters of the model.
Then, we introduce EM and explain how it is useful to optimize parameters.
We continue by applying EM to GMM and derive update formulas.
The final algorithm to cluster data is finally given.
[TODO again end]

## What is GMM?

Let $$\mathbf{x} = (x_i)_{i \in \lbrace 1, \ldots n \rbrace}$$ a dataset of $$\mathbb{R}^d$$.

Let $$i$$ any element of $$\lbrace 1, \ldots n \rbrace$$.
We assume that $$x_i \in \mathbb{R}^d$$ has been sampled from a random variable $$X_i$$.
We assume that $$X_i$$ follows a probability distribution with a certain density.
The density of $$X_i$$ in any $$x \in \mathbb{R}^d$$ is written as follows:

$$p(X_i = x).$$

In addition, we assume that $$x_i$$ is labeled with a certain $$z_i^{(\text{true})} \in \lbrace 1, \ldots, K \rbrace$$,
where $$K$$ is a fixed integer.
Those labels exist (and are fixed), but we only observe $$x_i$$, *without explicit knowledge of the corresponding label* $$z_i^{(\text{true})}$$.
The underlying random variable to model the label is noted $$Z_i$$, and the probability
to be labeled $$k \in \lbrace 1, \ldots, K \rbrace$$ is written as follows:

$$P(Z_i = k).$$

We say that $$Z_i$$ is a latent variable.
Using the law of total probability, we can reveal the latent variable (in the formula, $$x \in \mathbb{R}^d$$):

$$p(X_i = x) = \sum_{k = 1}^K p(X_i = x | Z_i = k) \times P(Z_i = k).$$

GMM assumes that three hypotheses are verified:
1. The vector of couples $$(X_i, Z_i)_i$$ forms an independent vector over $$i$$,
2. Each record belongs to a cluster $$Z_i = k$$ with probability $$\pi_k$$ (with $$\pi_k > 0$$),
3. Each conditional variable $$(X_i \mid Z_i = k)$$ follows a Gaussian distribution with mean $$m_k$$ and covariance matrix $$\Sigma_k$$.

We let $$f_{(m, \Sigma)}$$ the density function of a Gaussian with parameters $$m$$ and $$\Sigma$$ on $$\mathbb{R}^d$$.
Using hypotheses 2 and 3, the last equation is rewritten as follows (for all $$i, x$$):

$$p(X_i = x) = \sum_{k = 1}^K f_{(m_k, \Sigma_k)}(x_i) \times \pi_k.$$

Unknown (fixed) parameters of the model are grouped together into:

$$\theta^{(\text{true})} := (\pi_k^{(\text{true})}, m_k^{(\text{true})}, \Sigma_k^{(\text{true})})_{k \in \lbrace 1, \ldots, K \rbrace}.$$

The chosen strategy to estimate $$\theta^{(\text{true})}$$ is to maximize the log-likelihood of observed data $$\mathbf{x} := (x_1, \ldots, x_n)$$, as defined by the density of probability to observe $$\mathbf{x}$$ given $$\theta$$:

$$\log L(\theta ; \mathbf{x}) := \log p_{\theta}((X_1, \ldots, X_n) = (x_1, \ldots, x_n)).$$

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

## Step by step advances to the EM algorithm

In this section, $$\mathbf{x} \in \left(\mathbb{R}^d \right)^n$$ is the set of observed data, $$\mathbf{z}^{(\text{true})} \in \lbrace 1, \ldots, K \rbrace^n$$ the set of unobserved latent data, and $$\theta^{(\text{true})}$$ the unknown (fixed) set of parameters. The couple $$(\mathbf{x}, \mathbf{z}^{(\text{true})})$$ is a realization of the random variable $$(\mathbf{X}, \mathbf{Z})$$.

We continue to use letter $$p$$ for density and $$P$$ for probabilities.
For the sake of conciseness, we discard notation of the random variable: For example, we write $$P(\mathbf{z})$$ for  $$P(\mathbf{Z} = \mathbf{z})$$, and $$p(\mathbf{x})$$ for $$p(\mathbf{X} = \mathbf{x})$$.

In the following equations, we always consider cases where all terms are well-defined.

If we decompose log-likelihood as in the previous section, we obtain:

$$
\begin{align}
\log L(\theta ; \mathbf{x}) = \log p_{\theta}(\mathbf{x})
= \log \left[ \sum_{\mathbf{z}} p_{\theta}(\mathbf{x}, \mathbf{z}) \right].
\end{align}
$$

The problem of this decomposition is the presence of $$\log$$ before a sum.
We would like to let the $$\log$$ inside the sum 
(which is not possible directly because $$\log$$ is not linear!).
See for example the expression:
$$\sum_{\mathbf{z}} \log p_{\theta}(\mathbf{x}, \mathbf{z}) = \sum_{\mathbf{z}} \log p_{\theta}(\mathbf{x} | \mathbf{z}) + \sum_{\mathbf{z}} \log P(\mathbf{z}).$$
This expression would be easy to maximize over $$\theta$$ (assuming that $$(\mathbf{X} | \mathbf{Z})$$ and $$\mathbf{Z}$$ are independent and well-known; this is the case for GMM).

Basicly, EM will find a mean to include the $$\log$$ inside the sum.
To do this, we let $$\mathbf{z}$$ any element of $$\lbrace 1, \ldots, K \rbrace^n$$
and write:

$$p_{\theta}(\mathbf{x}, \mathbf{z}) = P_{\theta}(\mathbf{z} | \mathbf{x}) p_{\theta}(\mathbf{x}).$$

Taking the $$\log$$, we obtain:

$$\log L(\theta ; \mathbf{x}) = \log p_{\theta}(\mathbf{x}) = \log p_{\theta}(\mathbf{x}, \mathbf{z}) - \log P_{\theta}(\mathbf{z} | \mathbf{x}).$$

The previous formula is valid for all $$\mathbf{z}$$.
This is a great step, because the term of interest $$\log p_{\theta}(\mathbf{x}, \mathbf{z})$$ is here.
The first idea would be to sum over all $$\mathbf{z} \in \lbrace 1, \ldots, K \rbrace^n$$:

$$\sum_{\mathbf{z}} \log L(\theta ; \mathbf{x}) = \sum_{\mathbf{z}} \log p_{\theta}(\mathbf{x}, \mathbf{z}) - \sum_{\mathbf{z}} \log P_{\theta}(\mathbf{z} | \mathbf{x}).$$

On the left, there is no dependence in $$\mathbf{z}$$, so we end with:

$$\log L(\theta ; \mathbf{x}) = \frac{1}{K^n} \sum_{\mathbf{z}} \log p_{\theta}(\mathbf{x}, \mathbf{z}) - \frac{1}{K^n} \sum_{\mathbf{z}} \log P_{\theta}(\mathbf{z} | \mathbf{x}).$$

There is a new problem: The term containing $$P_{\theta}(\mathbf{z} | \mathbf{x})$$ on the right.
We don't have assumption on the conditional variable $$(\mathbf{Z} | \mathbf{X})$$, and Bayes' formula
does not help (using it, the denominator is $$p_{\theta}(\mathbf{x})$$ and we're stucked).

So how to do then? We come back to this formula, which is valid for all $$\mathbf{z}$$:

$$\log L(\theta ; \mathbf{x}) = \log p_{\theta}(\mathbf{x}, \mathbf{z}) - \log P_{\theta}(\mathbf{z} | \mathbf{x}).$$

We've seen that summing over all $$\mathbf{z}$$ and dividing by $$K^n$$ is not suitable to solve our problem (because of the term on the right).
There is another perspective: Summing over all $$\mathbf{z}$$ and dividing by $$K^n$$ corresponds to select each $$\mathbf{z}$$ with the uniform weight $$1 / K^n$$.
But we could also select any other distribution to weight each element $$\mathbf{z}$$.

Let $$(r_{\mathbf{z}})$$ be some distribution over $$\mathbf{z}$$.
Since $$\log L(\theta ; \mathbf{x})$$ does not depend on $$\mathbf{z}$$, and $$r_\mathbf{z}$$ sums to one over $$\mathbf{z}$$, we get:

$$\log L(\theta ; \mathbf{x}) = \sum_{\mathbf{z}} r_\mathbf{z} \log p_{\theta}(\mathbf{x}, \mathbf{z}) - \sum_{\mathbf{z}} r_\mathbf{z} \log P_{\theta}(\mathbf{z} | \mathbf{x}).$$

This is interpreted as the expectancy over a variable $$\hat{\mathbf{Z}}$$ following $$(r_\mathbf{z})_{\mathbf{z}}$$:

$$\log L(\theta ; \mathbf{x}) = E(\log p_{\theta}(\mathbf{x}, \hat{\mathbf{Z}})) - E(\log P_{\theta}(\hat{\mathbf{Z}} | \mathbf{x})).$$

We've said that second term on the right is the problem. We name it $$H$$:

$$H(\theta, r) := - \sum_{\mathbf{z}} r_\mathbf{z} \log P_{\theta}(\mathbf{z} | \mathbf{x}).$$

We assume that we have selected some current parameters $$\theta_0$$.
We would like to select $$r$$ such that for all choice of $$\theta$$,
$$H(\theta, r) \geq H(\theta_0, r).$$
If we can do this, $$H$$ would not be a problem anymore (try to see why now; Hint: we still cannot compute $$H$$, but we would know it cannot decrease; Answer in a subsequent paragraph).

We define two distributions $$(p_{\mathbf{z}})$$ and $$(q_{\mathbf{z}})$$:

$$p_{\mathbf{z}} := P_{\theta_0}(\mathbf{z} \mid \mathbf{x}),$$

$$q_{\mathbf{z}} := P_{\theta}(\mathbf{z} \mid \mathbf{x}).$$

The inequality $$H(\theta, r) \geq H(\theta_0, r)$$ can be rewritten as follows:

$$ -\sum_{\mathbf{z}} r_\mathbf{z} \log q_\mathbf{z} \geq -\sum_{\mathbf{z}} r_\mathbf{z} \log p_\mathbf{z}.$$

We group terms to obtain:

$$ \sum_{\mathbf{z}} r_{\mathbf{z}} \times \left( -\log \frac{q_{\mathbf{z}}}{p_{\mathbf{z}}} \right) \geq 0.$$

The sum on the right is not easy to compute, but $$-\log$$ is convex, so we try the [Jensen's inequality](https://en.wikipedia.org/wiki/Jensen%27s_inequality). The following inequality in valid for any distribution $$r$$:

$$ \sum_{\mathbf{z}} r_{\mathbf{z}} \times \left( -\log \frac{q_{\mathbf{z}}}{p_{\mathbf{z}}} \right) \geq - \log \sum_{\mathbf{z}} r_{\mathbf{z}} \frac{q_{\mathbf{z}}}{p_{\mathbf{z}}}.$$

By selecting $$r$$ such that $$- \log \sum_{\mathbf{z}} r_{\mathbf{z}} \frac{q_{\mathbf{z}}}{p_{\mathbf{z}}} \geq 0$$, we will end up with $$H(\theta, r) \geq H(\theta_0, r).$$

Now the inequality 
$$- \log \sum_{\mathbf{z}} r_{\mathbf{z}} \frac{q_{\mathbf{z}}}{p_{\mathbf{z}}} \geq 0$$ 
can be rewritten as: 
$$\sum_{\mathbf{z}} r_{\mathbf{z}} \frac{q_{\mathbf{z}}}{p_{\mathbf{z}}} \leq 1.$$

A natural choice is to select $$r_{\mathbf{z}} := p_{\mathbf{z}}$$ for all $$\mathbf{z}$$.

This choice has a nice interpretation in terms of entropy.
By rewriting the difference $$H(\theta, r) - H(\theta_0, r)$$ with $$r = p$$, we get (where $$\text{KL}$$ stands for the Kullback-Leibler divergence):

$$H(\theta, p) - H(\theta_0, p) = - \sum_{\mathbf{z}} p_{\mathbf{z}} \times \log \frac{q_{\mathbf{z}}}{p_{\mathbf{z}}} =: \text{KL}(p \mid \mid q) \geq 0.$$

[See post about KL for more details].

We put together our advances. For all $$\theta, \theta_0$$, the log-likelihood of $$\mathbf{x}$$ given parameters $$\theta$$ is expressed as:

$$\log L(\theta ; \mathbf{x}) = \sum_{\mathbf{z}} P_{\theta_0}(\mathbf{z} \mid \mathbf{x}) \log p_{\theta}(\mathbf{x}, \mathbf{z}) - \sum_{\mathbf{z}} P_{\theta_0}(\mathbf{z} \mid \mathbf{x}) \log P_{\theta}(\mathbf{z} | \mathbf{x}).$$

The first term of the sum is named $$Q$$:

$$Q(\theta | \theta_0) := \sum_{\mathbf{z}} P_{\theta_0}(\mathbf{z} \mid \mathbf{x}) \log p_{\theta}(\mathbf{x}, \mathbf{z}).$$

[Note that this can be seen as an expectancy. Let $$\hat{Z}_{\theta_0}$$ a random variable following distribution $$P_{\theta_0}(. \mid \mathbf{x})$$. Then:
$$Q(\theta | \theta_0) = E(\log p_{\theta}(\mathbf{x}, \hat{Z}_{\theta_0}))$$].

The second term is rewritten $$H$$:

$$H(\theta | \theta_0) := - \sum_{\mathbf{z}} P_{\theta_0}(\mathbf{z} \mid \mathbf{x}) \log P_{\theta}(\mathbf{z} | \mathbf{x}).$$

[Note that with previous notations, $$H(\theta, p) = H(\theta \mid \theta_0)$$
and $$H(\theta, q) = H(\theta \mid \theta)$$].

On the whole, for all $$\theta, \theta_0$$, the log-likelihood of $$\mathbf{x}$$ given parameters $$\theta$$ is:

$$\log L(\theta ; \mathbf{x}) = Q(\theta | \theta_0) + H(\theta | \theta_0).$$

and, for all $$\theta, \theta_0$$,

$$H(\theta | \theta_0) \geq H(\theta_0 | \theta_0).$$

This induces a method to increase log-likelihood of the dataset, described in the next section.

## What is EM algorithm?

We recall notations of the previous section. Let $$\mathbf{x} \in \left(\mathbb{R}^d \right)^n$$ the set of observed data, $$\mathbf{z}^{(\text{true})} \in \lbrace 1, \ldots, K \rbrace^n$$ the set of unobserved latent data, and $$\theta^{(\text{true})}$$ the unknown (fixed) set of parameters.

Log-likelihood of data is $$\log L(\theta ; \mathbf{x}) = \log p_{\theta}(\mathbf{x})$$.

The EM algorithm computes sets of parameters 

$$\theta^{(0)}, \theta^{(1)}, \theta^{(2)}, \ldots$$

such that the corresponding log-likelihoods nondecrease:

$$\log L(\theta^{(0)} ; \mathbf{x}) \leq \log L(\theta^{(1)} ; \mathbf{x}) \leq \log L(\theta^{(2)} ; \mathbf{x}), \ldots$$

EM is an iterative algorithm.

### Step 0

We begin with initial parameters $$\theta^{(0)}$$:

$$\theta^{(0)} := (\pi_k^{(0)}, m_k^{(0)}, \Sigma_k^{(0)})_{k \in \lbrace 1, \ldots, K \rbrace}.$$

Here, we let for all $$k$$: 
- $$\pi_k^{(0)} = 1 / K$$, 
- $$\Sigma_k^{(0)}$$ the identity matrix of size
$$K \times K$$, and 
- $$(m_k^{(0)})_{k \in \lbrace 1, \ldots, K \rbrace}$$ some positions obtained with $$K$$-means.

### Step $$t$$ to $$t+1$$

We have $$\theta^{(t)}$$.

We define for all $$\theta$$:

$$Q(\theta | \theta^{(t)}) := E(\log p_{\theta}(\mathbf{x}, \hat{Z}_{\theta^{(t)}})) = \sum_{\mathbf{z}} \log p_{\theta}(\mathbf{x}, \mathbf{z}) P_{\theta^{(t)}}(\mathbf{z} \mid \mathbf{x}),$$

where $$\hat{Z}_{\theta^{(t)}}$$ is a random variable following distribution $$P_{\theta^{(t)}}(. \mid \mathbf{x})$$

We let 

$$\theta^{(t+1)} := \text{argmax}_{\theta} Q(\theta | \theta^{(t)}).$$

The step of defining $$Q$$ is the *Expectation step*, 
the step of maximizing $$Q$$ is the *Maximization step*.

### Improvement of the likelihood using EM algorithm

We theoretically ensure that likelihood is nondecreasing when EM algorithm is used.
This paragraph formalizes the previous section.

At step $$t$$, we have for all $$\theta$$:

$$\log L(\theta ; \mathbf{x}) = Q(\theta | \theta^{(t)}) + H(\theta | \theta^{(t)}).$$

with:

$$H(\theta | \theta^{(t)}) = - \sum_{\mathbf{z}} P_{\theta^{(t)}}(\mathbf{z} \mid \mathbf{x}) \log P_{\theta}(\mathbf{z} | \mathbf{x}).$$

We compute:

$$
\begin{align}
\log L(\theta ; \mathbf{x}) - \log L(\theta^{(t)} ; \mathbf{x}) =& Q(\theta | \theta^{(t)}) - Q(\theta^{(t)} | \theta^{(t)}) + H(\theta | \theta^{(t)}) - H(\theta^{(t)} | \theta^{(t)})
\end{align}
$$

Using [Jensen's inequality](https://en.wikipedia.org/wiki/Jensen%27s_inequality) or [Gibbs inequality](https://en.wikipedia.org/wiki/Gibbs%27_inequality), we obtain for all $$theta$$:

$$H(\theta | \theta^{(t)}) \geq H(\theta^{(t)} | \theta^{(t)})$$

and so:

$$
\begin{align}
\log L(\theta ; \mathbf{x}) - \log L(\theta^{(t)} ; \mathbf{x}) \geq Q(\theta | \theta^{(t)}) - Q(\theta^{(t)} | \theta^{(t)})
\end{align}
$$

By choosing $$\theta^{(t+1)} = \text{argmax}_{\theta} Q(\theta \mid \theta^{(t)})$$, we have:

$$Q(\theta^{(t+1)} | \theta^{(t)}) \geq Q(\theta^{(t)} | \theta^{(t)})$$

and so:

$$
\begin{align}
\log L(\theta^{(t+1)} ; \mathbf{x}) - \log L(\theta^{(t)} ; \mathbf{x}) \geq 0.
\end{align}
$$

This ends the proof.

*A warning:* The previous proof ensures that likelihood is not decreasing. 
It does not say how parameters compare with $$\theta^{\text{(true)}}$$ (really unknown) or even $$\theta^{\text{(MLE)}}$$ (obtained using maximum likelihood estimate, but intractable).

### How to compute and maximize $$Q$$ in practice?

We make a full decomposition of $$Q$$:

$$
Q(\theta | \theta^{(t)}) = \sum_{\mathbf{z}} \log p_{\theta}
$$

$$
(\mathbf{x}, \mathbf{z})
$$

$$
P_{\theta^{(t)}}(\mathbf{z} | \mathbf{x})
$$

$$
\sum_{\mathbf{z}} \log \left[ p_{\theta}(\mathbf{x} | \mathbf{z}) p_{\theta}(\mathbf{z}) \right] \frac{p_{\theta^{(t)}}(\mathbf{z}, \mathbf{x})}{p_{\theta^{(t)}}(\mathbf{x})}
$$

$$
\sum_{\mathbf{z}} \left[ \log p_{\theta}(\mathbf{x} | \mathbf{z}) + \log p_{\theta}(\mathbf{z}) \right] \frac{p_{\theta^{(t)}}(\mathbf{z}, \mathbf{x})}{\sum_{\mathbf{z}'} p_{\theta^{(t)}}(\mathbf{z}', \mathbf{x})}
$$

test

$$
\begin{align}
Q(\theta | \theta^{(t)}) =& \sum_{\mathbf{z}} \log p_{\theta}(\mathbf{x}, \mathbf{z}) P_{\theta^{(t)}}(\mathbf{z} | \mathbf{x}) \\
=& \sum_{\mathbf{z}} \log \left[ p_{\theta}(\mathbf{x} | \mathbf{z}) p_{\theta}(\mathbf{z}) \right] \frac{p_{\theta^{(t)}}(\mathbf{z}, \mathbf{x})}{p_{\theta^{(t)}}(\mathbf{x})} \\
=& \sum_{\mathbf{z}} \left[ \log p_{\theta}(\mathbf{x} | \mathbf{z}) + \log p_{\theta}(\mathbf{z}) \right] \frac{p_{\theta^{(t)}}(\mathbf{z}, \mathbf{x})}{\sum_{\mathbf{z}'} p_{\theta^{(t)}}(\mathbf{z}', \mathbf{x})}.
$$

It should easier to maximize this function of $$\theta$$, compared to the initial log-likelihood function.
In the next section, this maximization is made explicitly (closed formulas).

## Applying EM to GMM

For EM, 

$$
\begin{align}
Q(\theta | \theta^{(t)}) =& \sum_{\mathbf{z}} \left[ \log p_{\theta}(\mathbf{x} | \mathbf{z}) + \log p_{\theta}(\mathbf{z}) \right] \frac{p_{\theta^{(t)}}(\mathbf{z}, \mathbf{x})}{\sum_{\mathbf{z}'} p_{\theta^{(t)}}(\mathbf{z}', \mathbf{x})} \\
=& \sum_{i = 1}^{N} \sum_{z_i = 1}^{K} \left[\log p_{\theta}(x_i |z_i) + \log p_{\theta}(z_i) \right] \frac{p_{\theta^{(t)}}(z_i, x_i)}{\sum_{z_i'} p_{\theta^{(t)}}(z_i', x_i)} \\
=& \sum_{i = 1}^{N} \sum_{k = 1}^{K} \left[\log p_{\theta}(x_i | k) + \log p_{\theta}(k) \right] \frac{p_{\theta^{(t)}}(k, x_i)}{\sum_{k' = 1}^{K} p_{\theta^{(t)}}(k', x_i)} \\
=& \sum_{i = 1}^{N} \sum_{k = 1}^{K} \left[\log f_{(m_k^{\theta}, \Sigma_k^{\theta})}(x_i) + \log \pi_k^{\theta} \right] \frac{f_{(m_k^{\theta^{(t)}}, \Sigma_k^{\theta^{(t)}})}(x_i) \pi_k^{\theta^{(t)}}}{\sum_{k' = 1}^{K} f_{(m_{k'}^{\theta^{(t)}}, \Sigma_{k'}^{\theta^{(t)}})}(x_i) \pi_{k'}^{\theta^{(t)}}}
\end{align}
$$



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
