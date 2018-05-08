---
layout: post
title: Rediscover EM algorithm from scratch
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

Many introductions of EM exist on the web. 
This one starts from the problem and use inductive reasoning to bring out EM.
No implementation is provided here.
To understand how to use and implement EM algorithm in practice, please check out [this post explaining how to estimate parameters for GMM using EM](...todo).

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

(rebuild or delete this part, because it is specific to GMM, not EM in general)

We begin with initial parameters $$\theta^{(0)}$$:

$$\theta^{(0)} := (\pi_k^{(0)}, m_k^{(0)}, \Sigma_k^{(0)})_{k \in \lbrace 1, \ldots, K \rbrace}.$$

Here, we let for all $$k$$: 
- $$\pi_k^{(0)} = 1 / K$$, 
- $$\Sigma_k^{(0)}$$ the identity matrix of size
$$K \times K$$, and 
- $$(m_k^{(0)})_{k \in \lbrace 1, \ldots, K \rbrace}$$ some positions obtained with $$K$$-means.

### Step $$t$$ to $$t+1$$

(rebuild or delete this part, because it is specific to GMM, not EM in general)

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

Using [Jensen's inequality](https://en.wikipedia.org/wiki/Jensen%27s_inequality) or [Gibbs inequality](https://en.wikipedia.org/wiki/Gibbs%27_inequality), we obtain for all $$\theta$$:

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
\begin{align}
Q(\theta | \theta^{(t)}) =& \sum_{\mathbf{z}} \log p_{\theta}(\mathbf{x}, \mathbf{z}) P_{\theta^{(t)}}(\mathbf{z} | \mathbf{x}) \\
=& \sum_{\mathbf{z}} \log \left[ p_{\theta}(\mathbf{x} | \mathbf{z}) p_{\theta}(\mathbf{z}) \right] \frac{p_{\theta^{(t)}}(\mathbf{z}, \mathbf{x})}{p_{\theta^{(t)}}(\mathbf{x})} \\
=& \sum_{\mathbf{z}} \left[ \log p_{\theta}(\mathbf{x} | \mathbf{z}) + \log p_{\theta}(\mathbf{z}) \right] \frac{p_{\theta^{(t)}}(\mathbf{z}, \mathbf{x})}{\sum_{\mathbf{z}'} p_{\theta^{(t)}}(\mathbf{z}', \mathbf{x})}.
\end{align}
$$

It should easier to maximize this function of $$\theta$$, compared to the initial log-likelihood function.
In the next section, this maximization is made explicitly (closed formulas).

## References

see them again

- [English wikipedia about EM](https://en.wikipedia.org/wiki/Expectation%E2%80%93maximization_algorithm). For formulas, it's concise. 

- [An introduction of EM following a similar perspective](http://cs229.stanford.edu/notes/cs229-notes8.pdf)

- [The Matrix Cookbook](https://www.math.uwaterloo.ca/~hwolkowi/matrixcookbook.pdf). I've just discovered it, and it is really useful for reference.
