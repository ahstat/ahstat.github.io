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

For the special case where all $alpha_j$ are equals and positive, this corresponds to the problem of *infinite divisibility* of the exponential distribution, and in this case we have $$X_1 \sim \text{Gamma}(\frac{1}{N}, \frac{1}{\alpha_1})$$, a gamma variable with shape $$\frac{1}{N}$$ and scale $$\frac{1}{\alpha_1}$$ (in particular when $$N=1$$, we have $$X_1 \sim \text{Exp}(\alpha_1) = \text{Gamma}(1, \frac{1}{\alpha_1})$$).

We are willing to extend this divisibility property and give methods to derive the density distribution of $$X_1$$ along with a way to generate it.



The characteristic function $$\varphi$$ of $$X_1$$ is given, for $|t| \leq \max |\alpha_j|$, by:

$$\varphi(t) = \exp \left( \sum_{k=1}^{\infty} \frac{i^k t^k}{k \sum_{l = 1}^N \alpha_l^k }  \right).$$


{::options parse_block_html="true" /}

<details><summary markdown="span">Proof.</summary>
By writing $$Z = \sum_{j=1}^{N} \alpha_j X_j$$ in terms of characteristic function, we are looking for $\varphi$ verifying for $t \in \mathbb{R}$:

\begin{equation}\label{expo_phi_equality}
\frac{1}{1-it} = \prod_{j=1}^{N} \varphi(\alpha_j t).
\end{equation}

We express the characteristic of the exponential distribution for $|t| \leq 1$ as follows:

\begin{align*}
\frac{1}{1-it} =& \exp \left( - \log \left( 1 - it \right) \right) \\
=& \exp \left( \sum_{k=1}^{\infty} \frac{i^kt^k}{k} \right) \\
=& \exp \left( \sum_{k=1}^{\infty} \frac{i^k t^k \sum_{j = 1}^N \alpha_j^k}{k \sum_{l = 1}^N \alpha_l^k }  \right) \\
=& \exp \left( \sum_{j = 1}^N \sum_{k=1}^{\infty} \frac{i^k t^k \alpha_j^k}{k \sum_{l = 1}^N \alpha_l^k }  \right) \\
=& \prod_{j = 1}^N \exp \left( \sum_{k=1}^{\infty} \frac{i^k \left(\alpha_j t \right)^k}{k \sum_{l = 1}^N \alpha_l^k }  \right),
\end{align*}

which gives the characteristic function for $$|t| \leq \max |\alpha_j|$$:

$$\varphi(t) := \exp \left( \sum_{k=1}^{\infty} \frac{i^k t^k}{k \sum_{l = 1}^N \alpha_l^k }  \right).$$
</details>
<br/>

{::options parse_block_html="false" /}




