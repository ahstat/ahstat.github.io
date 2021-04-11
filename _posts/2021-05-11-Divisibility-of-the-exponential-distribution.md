---
layout: post
title: Divisibility of the exponential distribution
published: true
comments: true
output: html_document
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

Let $$Z$$ be a $$\text{Exp}(1)$$ random variable.
For $$\alpha_1, \ldots \alpha_N \in \mathbb{R}$$, we are looking for variables $$X_1, \ldots X_N$$ independent and following the same distribution such that:

$$Z = \sum_{j=1}^{N} \alpha_j X_j.$$

For the special case where all $$\alpha_j$$ are equal and positive, this corresponds to the problem of *infinite divisibility* of the exponential distribution, and in this case $$X_1$$ follows $$\text{Gamma}(1/N, 1/\alpha_1)$$, a gamma variable with shape $$1/N$$ and scale $$1/\alpha_1$$ (in particular when $$N=1$$, we have $$X_1 \sim \text{Exp}(\alpha_1) = \text{Gamma}(1, 1/\alpha_1)$$).

We are willing to extend this divisibility property and give methods to derive the density distribution of $$X_1$$ along with a way to generate it.



First, the characteristic function $$\varphi$$ of $$X_1$$ is given, for $$\vert t \vert \leq \max \vert \alpha_j \vert$$, by:

$$\varphi(t) = \exp \left( \sum_{k=1}^{\infty} \frac{i^k t^k}{k \sum_{l = 1}^N \alpha_l^k }  \right).$$


{::options parse_block_html="true" /}

<details><summary markdown="span">Proof.</summary>
By writing $$Z = \sum_{j=1}^{N} \alpha_j X_j$$ in terms of characteristic function, we are looking for $$\varphi$$ verifying for $$t \in \mathbb{R}$$:

$$
\begin{equation}\label{expo_phi_equality}
\frac{1}{1-it} = \prod_{j=1}^{N} \varphi(\alpha_j t).
\end{equation}
$$

We express the characteristic of the exponential distribution for $$\vert t \vert \leq 1$$ as follows:

$$
\begin{align*}
\frac{1}{1-it} =& \exp \left( - \log \left( 1 - it \right) \right) \\
=& \exp \left( \sum_{k=1}^{\infty} \frac{i^kt^k}{k} \right) \\
=& \exp \left( \sum_{k=1}^{\infty} \frac{i^k t^k \sum_{j = 1}^N \alpha_j^k}{k \sum_{l = 1}^N \alpha_l^k }  \right) \\
=& \exp \left( \sum_{j = 1}^N \sum_{k=1}^{\infty} \frac{i^k t^k \alpha_j^k}{k \sum_{l = 1}^N \alpha_l^k }  \right) \\
=& \prod_{j = 1}^N \exp \left( \sum_{k=1}^{\infty} \frac{i^k \left(\alpha_j t \right)^k}{k \sum_{l = 1}^N \alpha_l^k }  \right),
\end{align*}
$$

which gives the characteristic function for $$\vert t \vert \leq \max \vert \alpha_j \vert$$:

$$\varphi(t) := \exp \left( \sum_{k=1}^{\infty} \frac{i^k t^k}{k \sum_{l = 1}^N \alpha_l^k }  \right).$$

</details>
<br/>

{::options parse_block_html="false" /}

From this characteristic function, we deduce: 
$$\log \varphi(t) = \sum_{k=1}^{\infty} \frac{(k-1)!}{\sum_{l = 1}^N \alpha_l^k } \frac{\left( it \right)^k}{k!}$$
so the cumulants are given by: $$\kappa_k = \frac{(k-1)!}{\sum_{l = 1}^N \alpha_l^k }.$$
For instance the mean and variance of $$X_1$$ are $$\mu = \kappa_1 = \frac{1}{\sum_{l = 1}^N \alpha_l }$$
and $$\sigma^2 = \kappa_2 = \frac{1}{\sum_{l = 1}^N \alpha_l^2}$$.

It is also possible to express $\varphi$ as an analytic function using the (complete exponential) Bell polynomials. For $$k \geq 0$$, we define the sequence $$p_k := \left( \sum_{l = 1}^N \alpha_l^k \right)^{-1}$$ and we rewrite, for $$\vert t \vert \leq \max \vert \alpha_j \vert$$,:

$$\varphi(t) = \sum_{n=0}^{\infty} B_n \left(p_1, p_2, 2! p_3, \ldots, (n-1)! p_{n} \right) \frac{\left(it \right)^n}{n!}.$$


{::options parse_block_html="true" /}

<details><summary markdown="span">Proof.</summary>
We further define $$q_k := (k-1)! p_k$$ and we express $\varphi$ following [Wikipedia](https://en.wikipedia.org/wiki/Bell_polynomials):

\begin{align*}
\varphi(t) =& \exp \left( \sum_{k=1}^{\infty} \frac{(k-1)!}{\sum_{l = 1}^N \alpha_l^k} \frac{\left(it \right)^k}{k!  }  \right) \\
 =& \exp \left( \sum_{k=1}^{\infty} q_k \frac{\left(it \right)^k}{k!  }  \right) \\
=& \sum_{n=0}^{\infty} B_n(q_1, q_2, q_3, \ldots, q_n) \frac{\left(it \right)^n}{n!} \\
=& \sum_{n=0}^{\infty} B_n \left(p_1, p_2, 2! p_3, \ldots, (n-1)! p_{n} \right) \frac{\left(it \right)^n}{n!}.
\end{align*}

</details>
<br/>

{::options parse_block_html="false" /}

We would like to extend the characteristic function on $$t \in \mathbb{R}$$. We order the indexes to get: $$\vert \alpha_1 \vert \leq \ldots \leq \vert \alpha_N \vert$$.



