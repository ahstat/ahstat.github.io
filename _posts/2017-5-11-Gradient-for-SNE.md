---
layout: post
title: Computation of the gradient for SNE
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

Many methods exist to visualize high-dimensional data by mapping them into a two-dimensional map. Those include linear techniques such as PCA (Principal Component Analysis, 1933) and MDS (MultiDimensional Scaling, 1952); as well as nonlinear ones such as Isomap (2000), LLE (Locally Linear Embedding, 2000), SNE (Stochastic Neighbor Embedding, 2002), and t-SNE (t-Distributed Stochastic Neighbor Embedding, 2008). Some of those dimensionality reduction methods are illustrated in [this sklearn example](http://scikit-learn.org/stable/auto_examples/manifold/plot_compare_methods.html).

The most popular method for nonlinear mapping is t-SNE. This method was developed by Laurens van der Maaten and Geoffrey Hinton in [1][1]. It is based on SNE and improves it by addressing the "crowding problem" (tendency of mapped points to aggregate into a unique central cluster).
You can [familiarize yourself with t-SNE here](https://distill.pub/2016/misread-tsne/), which allows to explore various examples interactively.

In this post, we propose to derive gradient for SNE algorithm (not to be confused with t-SNE, for which gradient calculation is provided in Appendix A of [1][1]).

Note that formula for SNE gradient is given in both original and t-SNE article, but neither detail calculations (given respectively in Equation 5 of [2][2], and Section 2 of [1][1]). 


In the following, we describe how works SNE (which is essentially a rewriting of Section 2 from [1]), before deriving SNE gradient step by step.

**How works SNE**

*High-dimensional points*

We have points $$(x_i)_i$$ is an high-dimensional space. We can measure distance between two points $$i$$ and $$j$$ with $$\| x_i - x_j \|$$.

We define the similarity between points $$i$$ and $$j$$ as a conditional probability:

$$p_{j \mid i} := \frac{\exp \left( - \| x_i - x_j \|^2 / 2 \sigma_i^2 \right)}{\sum_{k \neq i} \exp \left( - \| x_i - x_k \|^2 / 2 \sigma_i^2 \right)}.$$

$$p_{j \mid i}$$ represents the probability "that $$x_i$$ would pick $$x_j$$ as its neighbor, if neighbors were picked in proportion to their probability density under a Gaussian centered at $$x_i$$". We let $$p_{i \mid i}:=0$$.

The method for determining $$\sigma_i$$ is presented in [1][1] and is quite related with *perplexity*.

*Low-dimensional mapping*

We wish points $$(y_i)_i$$ in a two-dimensional space, $$y_i$$ representing the corresponding $$x_i$$.

We define the similarity between points $$i$$ and $$j$$ in this space:

$$q_{j \mid i} := \frac{\exp \left( - \| y_i - y_j \|^2 \right)}{\sum_{k \neq i} \exp \left( - \| y_i - y_k \|^2 \right)}.$$

We let $$q_{i \mid i}:=0$$.

*What is a good map from $$(x_i)_i$$ to $$(y_i)_i$$?*

A good map from $$(x_i)_i$$ to $$(y_i)_i$$ is a map for which distributions $$P_i: j \mapsto p_{j|i}$$ and $$Q_i: j \mapsto q_{j|i}$$ are equal (for all $$i$$).

We measure the distance between distributions $$P_i$$ and $$Q_i$$ with the Kullback-Leibler divergence:

$$\text{KL}(P_i \mid \mid Q_i) = \sum_{j} p_{j \mid i} \log \frac{p_{j \mid i}}{q_{j \mid i}}.$$

[See post about KL for more details].

Since we want to minimize them for all $$i$$, we finally define the cost function as:

$$C = \sum_i \text{KL}(P_i \mid \mid Q_i).$$

*Asymmetry of $$\text{KL}$$*

Recall Fig. 3.6 of the "Deep learning book" to see the asymmetry effect of $$\text{KL}$$. Here, we focus on representing a distribution $$Q_i$$ which is fair for the whole distribution $$P_i$$, then we choose $$\text{KL}(P_i \mid \mid Q_i)$$ (it is more clear on the figure…).

This means:
- If we use widely separated points to represent nearby datapoints, there will be a large cost (i.e. we have a small $$q_(j \mid i)$$ to model a large $$p_(j \mid i)$$, i.e. the points are close on $$X$$ but far away on $$Y$$),
- If we use nearby points to represent widely separated datapoints, there will be a small cost (i.e. we have a large $$q_(j \mid i)$$ to model a small $$p_(j \mid i)$$, i.e. the points are far away on $$X$$ but close on $$Y$$).

On the whole, "the SNE cost function focuses on retaining the local structure of the data in the map".


*Gradient descent*

TODO Explain the method


**Derivation of the SNE gradient**

TODO

In the original article, it is said that:

"Differentiating $$C$$ is tedious because $$y_k$$ affects q_{ij} via the normalization term in Eq. 3, but the result is simple.
**.."

In [1]
"The gradient has a surprisingly simple form"



*References*

[1]: http://www.jmlr.org/papers/volume9/vandermaaten08a/vandermaaten08a.pdf Visualizing Data using t-SNE 
[2]: http://papers.nips.cc/paper/2276-stochastic-neighbor-embedding.pdf Stochastic Neighbor Embedding








