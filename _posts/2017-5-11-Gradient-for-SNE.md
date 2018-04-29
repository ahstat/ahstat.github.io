---
layout: post
title: Computation of the gradient for SNE
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

Many methods exist to visualize high-dimensional data through a two-dimensional map. Those include linear techniques such as PCA and MDS; as well as nonlinear ones such as Isomap, LLE, SNE and t-SNE (resp. Principal Component Analysis, 1933; MultiDimensional Scaling, 1952; Isomap, 2000; Locally Linear Embedding, 2000; Stochastic Neighbor Embedding, 2002; t-Distributed Stochastic Neighbor Embedding, 2008). Some of those dimensionality reduction methods are illustrated in [this sklearn example](http://scikit-learn.org/stable/auto_examples/manifold/plot_compare_methods.html).

A popular method for nonlinear mapping is t-SNE. This method has been developed by Laurens van der Maaten and Geoffrey Hinton in [\[1\]][1]. It is based on SNE and improves it by addressing the "crowding problem" (tendency of mapped points to aggregate into a unique central cluster).
You can [familiarize yourself with t-SNE here](https://distill.pub/2016/misread-tsne/), which allows exploration of various examples interactively.

In this post, we propose to derive gradient for the SNE algorithm (not to be confused with t-SNE, for which gradient calculation is detailed in Appendix A of [\[1\]][1]).
SNE gradient is given in both original and t-SNE article, but neither detailed (see Equation 5 of [\[2\]][2], and Section 2 of [\[1\]][1]). 

In the following, we describe how works SNE (which is essentially a rewriting of Section 2 from [\[1\]][1]), before deriving SNE gradient step by step.

## How works SNE

### High-dimensional points

We have points $$(x_i)_i$$ is an high-dimensional space. We can measure distance between two points $$i$$ and $$j$$ with $$\| x_i - x_j \|$$.

We define the similarity between points $$i$$ and $$j$$ as a conditional probability:

$$p_{j \mid i} := \frac{\exp \left( - \| x_i - x_j \|^2 / 2 \sigma_i^2 \right)}{\sum_{k \neq i} \exp \left( - \| x_i - x_k \|^2 / 2 \sigma_i^2 \right)}.$$

$$p_{j \mid i}$$ represents the probability "that $$x_i$$ would pick $$x_j$$ as its neighbor, if neighbors were picked in proportion to their probability density under a Gaussian centered at $$x_i$$". We let $$p_{i \mid i}:=0$$.

The method for determining $$\sigma_i$$ is presented in [1][1] and is quite related with *perplexity*.

### Low-dimensional mapping

We wish points $$(y_i)_i$$ in a two-dimensional space, $$y_i$$ representing the corresponding $$x_i$$.

We define the similarity between points $$i$$ and $$j$$ in this space:

$$q_{j \mid i} := \frac{\exp \left( - \| y_i - y_j \|^2 \right)}{\sum_{k \neq i} \exp \left( - \| y_i - y_k \|^2 \right)}.$$

We let $$q_{i \mid i}:=0$$.

### What is a good map from $$(x_i)_i$$ to $$(y_i)_i$$?

A good map from $$(x_i)_i$$ to $$(y_i)_i$$ is a map for which distributions $$P_i: j \mapsto p_{j \mid i}$$ and $$Q_i: j \mapsto q_{j \mid i}$$ are equal (for all $$i$$).

We measure the distance between distributions $$P_i$$ and $$Q_i$$ with the Kullback-Leibler divergence:

$$\text{KL}(P_i \mid \mid Q_i) = \sum_{j} p_{j \mid i} \log \frac{p_{j \mid i}}{q_{j \mid i}}.$$

[See post about KL for more details].

Since we want to minimize them for all $$i$$, we finally define the cost function as:

$$C = \sum_i \text{KL}(P_i \mid \mid Q_i).$$

### Asymmetry of $$\text{KL}$$

Recall Fig. 3.6 of the "Deep learning book" to see the asymmetry effect of $$\text{KL}$$. Here, we focus on representing a distribution $$Q_i$$ which is fair for the whole distribution $$P_i$$, then we choose $$\text{KL}(P_i \mid \mid Q_i)$$ (it is more clear on the figure…).

This means:
- If we use widely separated points to represent nearby datapoints, there will be a large cost (i.e. we have a small $$q_{j \mid i}$$ to model a large $$p_{j \mid i}$$, i.e. the points are close on $$X$$ but far away on $$Y$$),
- If we use nearby points to represent widely separated datapoints, there will be a small cost (i.e. we have a large $$q_{j \mid i}$$ to model a small $$p_{j \mid i}$$, i.e. the points are far away on $$X$$ but close on $$Y$$).

On the whole, "the SNE cost function focuses on retaining the local structure of the data in the map".


### Gradient descent

TODO Explain the method


## Derivation of the SNE gradient

We have with the notations in the article:

$$C = \sum_{i} KL(P_i || Q_i) = \sum_{i} \sum_{j \neq i} p_{j|i} \log \frac{p_{j|i}}{q_{j|i}}.$$

Taking the gradient, we want to compute

$$-\nabla_{y_l} C = \sum_{i} \sum_{j \neq i} p_{j|i} \frac{\nabla_{y_l} q_{j|i}}{q_{j|i}}$$

### Decomposition into 3 terms.

We separate the calculation into 3 terms:

$$-\nabla_{y_l} C = [1] + [2] + [3]$$

where $$[1]$$ is when $$i=l$$, $$[2]$$ is when $$j=l$$ and $$[3]$$ is the remainder term:

$$[1] = \sum_{j \neq l} p_{j|l} \frac{\nabla_{y_l} q_{j|l}}{q_{j|l}}$$

$$[2] = \sum_{i \neq l} p_{l|i} \frac{\nabla_{y_l} q_{l|i}}{q_{l|i}}$$

$$[3] = \sum_{i \neq l} \sum_{j \neq i,l} p_{j|i} \frac{\nabla_{y_l} q_{j|i}}{q_{j|i}}$$

#### Calculation of $$q_{j \mid i}$$ and $$\nabla_{y_l} q_{j \mid i}$$.*

We define for all $$(k,l)$$:

$$f_k(y_l) = \exp \left( -||y_l - y_k||^2 \right).$$

We have (because $$\nabla_{a} \| a - b \|^2 = 2(a-b)$$):

$$\nabla_{y_l} f_k(y_l) = -2(y_l - y_k) \exp \left( -||y_l - y_k||^2 \right) = -2(y_l - y_k) f_k(y_l).$$

We define for all $$j$$: $$S_j = \sum_k f_k(y_j)$$ and $$C = S_i^2$$ (definition or not? Confusing with previous $$C$$).

#### Case [1].
$$q_{j|l}$$ and $$\nabla_{y_l} q_{j|l}$$?

$$q_{j|l} = \frac{f_j(y_l)}{\sum_{k \neq l} f_k(y_l)}$$ 

(1)

$$\nabla_{y_l} q_{j|l} = \frac{\nabla_{y_l} f_j(y_l) \sum_{k \neq l} f_k(y_l) - f_j(y_l) \sum_{k \neq l}\nabla_{y_l} f_k(y_l)}{\left( \sum_{k \neq l} f_k(y_l) \right)^2}$$

$$\nabla_{y_l} q_{j|l} =
\frac{\nabla_{y_l} f_j(y_l)}{\sum_{k \neq l} f_k(y_l)} - \frac{f_j(y_l) \sum_{k \neq l} \nabla_{y_l} f_k(y_l)}{\left( \sum_{k \neq l} f_k(y_l) \right)^2}$$

(1')

#### Case [2].
$$q_{l|i}$$ and $$\nabla_{y_l} q_{l|i}$$?

$$q_{l|i} = \frac{f_i(y_l)}{f_i(y_l) + \sum_{k \neq \lbrace i, l \rbrace} \exp \left( - ||y_i - y_k ||^2 \right)} =: \frac{f_i(y_l)}{f_i(y_l) + B}$$ 

(2)

$$\nabla_{y_l} q_{l|i} = \frac{\nabla_{y_l} f_i(y_l) (f_i(y_l) + B) - f_i(y_l) \nabla_{y_l} f_i(y_l)}{ \left( \sum_{k \neq i} \exp \left( - ||y_i - y_k||^2 \right) \right)^2} = \frac{S_i \nabla_{y_l} f_i(y_l) - f_i(y_l) \nabla_{y_l} f_i(y_l)}{C}$$ 

(2')

#### Case [3].
$$q_{j|i}$$ and $$\nabla_{y_l} q_{j|i}$$?

$$q_{j|i} = \frac{\exp(-||y_i - y_j||^2)}{f_i(y_l) + \sum_{k \neq \lbrace i, l \rbrace} \exp \left( -||y_i - y_k||^2 \right)} =: \frac{A}{f_i(y_l) + B}$$ 

(3)

$$\nabla_{y_l} q_{j|i} = \frac{-A \nabla_{y_l} f_i(y_l)}{\left( f_i(y_l) + B \right)^2} = \frac{2A(y_l - y_i) f_i(y_l)}{\left( \sum_{k \neq i} \exp \left( - ||y_i - y_k || \right)^2 \right)^2} = \frac{2 A (y_l - y_i) f_i(y_l)}{C}$$

### Calculation of [1] = $$\sum_{j \neq l} p_{j|l} \frac{\nabla_{y_l} q_{j|l}}{q_{j|l}}$$

$$[1] = \sum_{j \neq l} p_{j|l} \frac{\nabla_{y_l} q_{j|l}}{q_{j|l}} = \sum_{j \neq l} p_{j|l}
\frac{\sum_{k \neq l} f_k(y_l)}{f_j(y_l)} \left( \frac{\nabla_{y_l} f_j(y_l)}{\sum_{k \neq l} f_k(y_l)} - \frac{f_j(y_l) \sum_{k \neq l} \nabla_{y_l} f_k(y_l)}{\left( \sum_{k \neq l} f_k(y_l) \right)^2} \right)$$

$$[1] = \sum_{j \neq l} p_{j|l} \left( \frac{\nabla_{y_l} f_j(y_l)}{f_j(y_l)} - \frac{\sum_{k \neq l} \nabla_{y_l} f_k(y_l)}{\sum_{k \neq l} f_k(y_l) } \right)$$

$$[1] = \sum_{j \neq l} p_{j|l} \left( -2(y_l - y_j) + \frac{\sum_{k \neq l} 2(y_l - y_k) f_k(y_l)}{\sum_{k \neq l} f_k(y_l) } \right)$$

$$[1] = - 2 \sum_{j \neq l} p_{j|l} (y_l - y_j) + 2 \sum_{j \neq l} p_{j|l} \left( \sum_{k \neq l} (y_l - y_k) \frac{f_k(y_l)}{\sum_{k \neq l} f_k(y_l)} \right)$$

But we have: 
$$q_{k|l} = \frac{f_k(y_l)}{\sum_{k \neq l} f_k(y_l)}$$ so:

$$[1] = - 2 \sum_{j \neq l} p_{j|l} (y_l - y_j) + 2 \left( \sum_{k \neq l} (y_l - y_k) q_{k|l} \right)  \left( \sum_{j \neq l} p_{j|l} \right)$$

And $$\sum_{j \neq l} p_{j \mid l} = 1$$, then:

$$[1] = - 2 \sum_{j \neq l} p_{j|l} (y_l - y_j) + 2 \sum_{k \neq l} (y_l - y_k) q_{k|l}$$

$$[1] = - 2 \sum_{i \neq l} p_{i|l} (y_l - y_i) + 2 \sum_{i \neq l} (y_l - y_i) q_{i|l}$$

### Calculation of [2] = $$\sum_{i \neq l} p_{l|i} \frac{\nabla_{y_l} q_{l|i}}{q_{l|i}}$$

$$[2] = \sum_{i \neq l} p_{l|i} \frac{\nabla_{y_l} q_{l|i}}{q_{l|i}} = \sum_{i \neq l} p_{l|i} \left( \frac{f_i(y_l) + B}{f_i(y_l)} \right) \left( \frac{S_i \nabla_{y_l} f_i(y_l) - f_i(y_l) \nabla_{y_l} f_i(y_l)}{C} \right) $$

Since $$S_i = f_i(y_l) + B$$ and $$C = S_i^2$$, we have:

$$[2] = \sum_{i \neq l} p_{l|i} \left( \frac{\nabla_{y_l} f_i(y_l)}{f_i(y_l)} - \frac{\nabla_{y_l} f_i(y_l)}{S_i} \right) $$

$$[2] = \sum_{i \neq l} p_{l|i} \left( - 2(y_l - y_i) + 2 (y_l - y_i) \frac{f_i(y_l)}{S_i} \right) $$

But we have: $$q_{l \mid i} = \frac{f_i(y_l)}{S_i}$$, so:

$$[2] = -2 \sum_{i \neq l} p_{l|i}  (y_l - y_i) + 2 \sum_{i \neq l} p_{l|i} (y_l - y_i) q_{l|i}.$$

### Calculation of [3] = $$\sum_{i \neq l} \sum_{j \neq i,l} p_{j|i} \frac{\nabla_{y_l} q_{j|i}}{q_{j|i}}$$

$$ [3] = \sum_{i \neq l} \sum_{j \neq i,l} p_{j|i} \frac{\nabla_{y_l} q_{j|i}}{q_{j|i}} = \sum_{i \neq l} \sum_{j \neq i,l} p_{j|i} \left( \frac{f_i(y_l) + B}{A} \right) \left( \frac{2A (y_l - y_i) f_i(y_l)}{C} \right)$$

Since $$S_i = f_i(y_l) + B$$ and $$C = S_i^2$$, we have:

$$ [3] = 2 \sum_{i \neq l} \sum_{j \neq i,l} p_{j|i} \left( \frac{(y_l - y_i) f_i(y_l)}{S_i} \right)$$

But we have: $$q_{l \mid i} = \frac{f_i(y_l)}{S_i}$$, so:

$$ [3] = 2 \sum_{i \neq l} \sum_{j \neq i,l} p_{j|i} (y_l - y_i) q_{l|i}$$

$$ [3] = 2 \sum_{i \neq l} \left[ (y_l - y_i) q_{l|i} \left( \sum_{j \neq i,l} p_{j|i} \right) \right]$$

We have: $$\sum_{j \neq i, l} p_{j \mid i} = 1 - p_{l \mid i}$$, so finally:

$$ [3] = 2 \sum_{i \neq l} (y_l - y_i) q_{l|i} \left( 1 - p_{l|i} \right) $$

### Final form of the gradient

test
$$
\begin{aligned}
 -\nabla_{y_l} C &= [1] + [2] + [3] \\
 &= - 2 \sum_{i \neq l} p_{i|l} (y_l - y_i) + 2 \sum_{i \neq l} (y_l - y_i) q_{i|l} -2 \sum_{i \neq l} p_{l|i}  (y_l - y_i) + 2 \sum_{i \neq l} p_{l|i} (y_l - y_i) q_{l|i}
\end{aligned}
$$
end test


$$-\nabla_{y_l} C = [1] + [2] + [3]$$


$$-\nabla_{y_l} C = - 2 \sum_{i \neq l} p_{i|l} (y_l - y_i) + 2 \sum_{i \neq l} (y_l - y_i) q_{i|l} -2 \sum_{i \neq l} p_{l|i}  (y_l - y_i) + 2 \sum_{i \neq l} p_{l|i} (y_l - y_i) q_{l|i} $$

$$ + 2 \sum_{i \neq l} (y_l - y_i) q_{l|i} \left( 1 - p_{l|i} \right) $$

So after simplification:

$$-\nabla_{y_l} C = - 2 \sum_{i \neq l} p_{i|l} (y_l - y_i) + 2 \sum_{i \neq l} (y_l - y_i) q_{i|l} -2 \sum_{i \neq l} p_{l|i}  (y_l - y_i) + 2 \sum_{i \neq l} (y_l - y_i) q_{l|i}$$

and:

$$\nabla_{y_l} C = 2 \sum_{i \neq l} (p_{i|l} - q_{i|l} + p_{l|i} - q_{l|i})(y_l - y_i)$$



## Then
TODO

In the original article, it is said that:

"Differentiating $$C$$ is tedious because $$y_k$$ affects q_{ij} via the normalization term in Eq. 3, but the result is simple.
**.."

In [1]
"The gradient has a surprisingly simple form"



## References

[1]: http://www.jmlr.org/papers/volume9/vandermaaten08a/vandermaaten08a.pdf Visualizing Data using t-SNE 
[2]: http://papers.nips.cc/paper/2276-stochastic-neighbor-embedding.pdf Stochastic Neighbor Embedding








