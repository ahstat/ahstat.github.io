---
layout: post
title: Maximizing likelihood is equivalent to minimizing KL-divergence
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

This post explains why maximizing likelihood is equivalent to minimizing KL-divergence.
This can be already found [here](https://wiseodd.github.io/techblog/2017/01/26/kl-mle/) and [here](http://thirdorderscientist.org/homoclinic-orbit/2013/4/1/maximum-likelihood-and-entropy), but I restate this in my "own" words.

More generally, I encourage you to read Section 3.13 of [Deep Learning book](https://www.deeplearningbook.org/contents/prob.html) for insights on information theory.

Let $$\mathbf{x}$$ a dataset of $$n$$ elements.

We assume that $$\mathbf{x}$$ comes from a random variable $$\mathbf{X}$$ with density $$p = p_{\theta_0}$$ and corresponding to a true (unknown) parameter $$\theta_0$$.

We let $$q = p_{\theta}$$ the density function corresponding to another parameter $$\theta$$.

The likelihood of $$\mathbf{x}$$ given $$\theta$$ is $$L_{\theta}(\mathbf{x}) = p_{\theta_0}(\mathbf{x})$$.

The opposite of likelihood divided by $$n$$ is:

$$-\frac{1}{N} \log L_{\theta}(\mathbf{x}) = -\frac{1}{N} \log p_{\theta_0}(\mathbf{x}) 
\rightarrow E_{\theta_0} \left[ - \log p_{\theta}(X) \right] = - \int \log p_{\theta}(x) dp_{\theta_0}(x) = - \int \log q(x) dp(x) =: H(p, q).$$

In the previous equation, $$H(p, q)$$ stands for the (continuous) cross-entropy between $$p$$ and $$q$$.

Since $$H(p, q) = H(p) + \text{KL}(p \mid \mid q)$$,
maximizing likelihood is equivalent to minimizing KL-divergence.
