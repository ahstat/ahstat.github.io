---
layout: post
title: Divisibility of the exponential distribution
published: true
comments: true
output: html_document
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

Let $$Z$$ be a $$\text{Exp}(1)$$ random variable.
For $$\alpha_1, \ldots \alpha_N \in \mathbb{R}_{+}^{*}$$, we are looking for variables $$X_1, \ldots X_N$$ independent and following the same distribution such that:

$$Z = \sum_{j=1}^{N} \alpha_j X_j.$$

For the special case where all $$\alpha_j$$ are equal, this corresponds to the problem of *infinite divisibility* of the exponential distribution, and in this case $$X_1$$ follows $$\text{Gamma}(1/N, 1/\alpha_1)$$, a gamma variable with shape $$1/N$$ and scale $$1/\alpha_1$$ (in particular when $$N=1$$, we have $$X_1 \sim \text{Exp}(\alpha_1) = \text{Gamma}(1, 1/\alpha_1)$$).

We are willing to extend this divisibility property and give methods to derive the density distribution of $$X_1$$ along with a way to generate it.



First, the characteristic function $$\varphi$$ of $$X_1$$ is given, for $$\vert t \vert \leq \max \alpha_j$$, by:

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

which gives the characteristic function for $$\vert t \vert \leq \max \alpha_j$$:

$$\varphi(t) := \exp \left( \sum_{k=1}^{\infty} \frac{i^k t^k}{k \sum_{l = 1}^N \alpha_l^k }  \right).$$

</details>
<br/>

{::options parse_block_html="false" /}

From this characteristic function, we deduce:

$$\log \varphi(t) = \sum_{k=1}^{\infty} \frac{(k-1)!}{\sum_{l = 1}^N \alpha_l^k } \frac{\left( it \right)^k}{k!},$$

so the cumulants are given by: $$\kappa_k = (k-1)! / \sum_{l = 1}^N \alpha_l^k.$$
For instance the mean and variance of $$X_1$$ are $$\mu = \kappa_1 = 1/\sum_{l = 1}^N \alpha_l$$
and $$\sigma^2 = \kappa_2 = 1/\sum_{l = 1}^N \alpha_l^2$$.

It is also possible to express $$\varphi$$ as an analytic function using the (complete exponential) Bell polynomials. For $$k \geq 0$$, we define the sequence $$p_k := \left( \sum_{l = 1}^N \alpha_l^k \right)^{-1}$$ and we rewrite, for $$\vert t \vert \leq \max \alpha_j$$,:

$$\varphi(t) = \sum_{n=0}^{\infty} B_n \left(p_1, p_2, 2! p_3, \ldots, (n-1)! p_{n} \right) \frac{\left(it \right)^n}{n!}.$$


{::options parse_block_html="true" /}

<details><summary markdown="span">Proof.</summary>
We further define $$q_k := (k-1)! p_k$$ and we express $$\varphi$$ following [Wikipedia](https://en.wikipedia.org/wiki/Bell_polynomials):

$$
\begin{align*}
\varphi(t) =& \exp \left( \sum_{k=1}^{\infty} \frac{(k-1)!}{\sum_{l = 1}^N \alpha_l^k} \frac{\left(it \right)^k}{k!  }  \right) \\
 =& \exp \left( \sum_{k=1}^{\infty} q_k \frac{\left(it \right)^k}{k!  }  \right) \\
=& \sum_{n=0}^{\infty} B_n(q_1, q_2, q_3, \ldots, q_n) \frac{\left(it \right)^n}{n!} \\
=& \sum_{n=0}^{\infty} B_n \left(p_1, p_2, 2! p_3, \ldots, (n-1)! p_{n} \right) \frac{\left(it \right)^n}{n!}.
\end{align*}
$$

</details>
<br/>

{::options parse_block_html="false" /}

We would like to extend the characteristic function on $$t \in \mathbb{R}$$. We order the indexes to get: $$\alpha_1 \leq \ldots \leq  \alpha_N $$.
In the case where all coefficients are equal, we already expressed the solution in the introduction. Otherwise, there exists $$p \in [1,N-1]$$ such that $$\alpha_1 \leq \ldots \leq \alpha_{N-p} < \alpha_{N-p+1} = \ldots = \alpha_{N}$$. The integer $$p$$ is the number of indexes equal to $$\alpha_N$$; in most of the cases we have $$p = 1$$ hence $$\alpha_{N-1} < \alpha_{N}$$.

We rewrite the functional relation of the characteristic function as follows, for $$t \in \mathbb{R}$$:

$$\frac{1}{1-it} = \prod_{j=1}^{N-p} \varphi(\alpha_j t) \prod_{j=N-p+1}^{N} \varphi(\alpha_j t) = \prod_{j=1}^{N-p} \varphi(\alpha_j t) \varphi(\alpha_N t)^p,$$

and by taking the logarithm:

$$\log \varphi(\alpha_N t) = - \frac{1}{p} \log \left( 1-it \right) - \frac{1}{p} \sum_{j=1}^{N-p} \log \varphi(\alpha_j t)$$

which gives for $$t \in \mathbb{R}$$:

$$\log \varphi(t) = - \frac{1}{p} \log \left( 1-\frac{1}{\alpha_N}it \right) - \frac{1}{p} \sum_{j=1}^{N-p} \log \varphi \left(\frac{\alpha_j}{\alpha_N} t \right).$$

We use the functionality of the equation: We first evaluate the previous equation in $$\frac{\alpha_j}{\alpha_N} t$$, and we then use the result to replace the terms in the same equation. 

First, for all $$\alpha_j$$, we have (taking care of using another index name for the sum in the right term):

$$\log \varphi(\frac{\alpha_j}{\alpha_N} t) = - \frac{1}{p} \log \left( 1-\frac{\alpha_j}{\alpha_N^2} it \right) - \frac{1}{p} \sum_{k=1}^{N-p} \log \varphi \left( \frac{\alpha_j\alpha_k}{\alpha_N^2} t \right)$$

Then, we put it in the previous equation to get:

$$\log \varphi(t) = - \frac{1}{p} \log \left( 1-\frac{1}{\alpha_N}it \right) + \frac{1}{p^2} \sum_{j=1}^{N-p}  \log \left( 1-\frac{\alpha_j}{\alpha_N^2} it \right) + \frac{1}{p^2} \sum_{j=1}^{N-p} \sum_{k=1}^{N-p} \log \varphi \left(\frac{\alpha_j\alpha_k}{\alpha_N^2} t \right).$$

We use again the functionality of the equation. We first write:

$$\log \varphi \left(\frac{\alpha_j\alpha_k}{\alpha_N^2} t \right) = - \frac{1}{p} \log \left( 1- \frac{\alpha_j\alpha_k}{\alpha_N^3} it \right) - \frac{1}{p} \sum_{l=1}^{N-p} \log \varphi \left(\frac{\alpha_j\alpha_k\alpha_l}{\alpha_N^3} t \right)$$

to then get:

$$\log \varphi(t) = - \frac{1}{p} \log \left( 1-\frac{1}{\alpha_N}it \right) + \frac{1}{p^2} \sum_{j=1}^{N-p}  \log \left( 1-\frac{\alpha_j}{\alpha_N^2} it \right) -  \frac{1}{p^3} \sum_{j=1}^{N-p} \sum_{k=1}^{N-p} \log \left( 1- \frac{\alpha_j\alpha_k}{\alpha_N^3} it \right) - \frac{1}{p^3} \sum_{j=1}^{N-p} \sum_{k=1}^{N-p} \sum_{l=1}^{N-p} \log \varphi \left(\frac{\alpha_j\alpha_k\alpha_l}{\alpha_N^3} t \right).$$

We continue by induction to obtain, for all $$D \geq 1$$:

$$\log \varphi(t) = - \frac{1}{p} \log \left( 1- \frac{1}{\alpha_N}it \right) + \sum_{d=2}^{D} \left( \frac{-1}{p} \right)^d \left[\sum_{j_{1}=1}^{N-p} \ldots \sum_{j_{d-1}=1}^{N-p}  \log \left( 1-\frac{\prod_{k=1}^{d-1} \alpha_{j_k}}{\alpha_N^d} it \right) \right] + \left( \frac{-1}{p} \right)^D \sum_{j_{1}=1}^{N-p} \ldots \sum_{j_{D}=1}^{N-p} \log \varphi \left( \frac{\prod_{k=1}^{D} \alpha_{j_k}}{\alpha_N^D} t \right).$$

Given $$t \in \mathbb{R}$$, there exists $$D$$ such that $$\left( \frac{\alpha_{N-p}}{\alpha_N} \right)^D \vert t \vert \leq 1$$ and from this $$D$$, the previous formula has all the terms evaluated in the interval $$[-1, 1]$$, hence $$\phi(t)$$ is well defined. An explicit value of $$D$$ is given by: $$D := \lceil \frac{\log \vert t \vert}{\log \alpha_N - \log \alpha_{N-p}} \rceil$$.




Ideas: case with negative $$\alpha$$ (or more *complex*), e.g. $$Z = \vert X - Y \vert$$? It's not possible to get directly $$Z = X - Y$$ with same distributed $$X$$ and $$Y$$, because $$Z$$ is nonnegative.
