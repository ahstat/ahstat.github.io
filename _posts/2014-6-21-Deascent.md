---
layout: post
title: Introduction to hidden Markov models 2
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>
<a href="../images/2014-6-11-Introduction-hmm/HMM_introduction.pdf" target="_blank"><img src = "../images/2014-6-11-Introduction-hmm/HMM_introduction.png"></a>


This is a draft in progress.

# Definitions

## Introduction: Idea of the system in the specific case of a mixture of Gaussians

### Definition of the system in this case

For points $$x_1, \ldots, x_n \in \mathbb{R}^d$$, we define $$f_{x_1, \ldots, x_n}$$ the mixture of the densities $$f_1, \ldots, f_n$$, where for each $$i \in \lbrace 1, \ldots n \rbrace$$, $$f_i$$ is a Gaussian density centered in $$x_i$$ and with $$\sigma^2 I$$ matrix of variance-covariance.

The dynamic of the system is described as follows.

First, we initialize points $$x_1^{(1)}, \ldots, x_n^{(1)} \in \mathbb{R}^d$$.

Then, for each $$t \in \mathbb{N}^{*}$$, for each $$i \in \lbrace 1, \ldots n \rbrace$$, we let the point $$x_i^{(t)}$$ performs a gradient descent step following $$f_{(x_1^{(t)}, \ldots, x_n^{(t)})}$$ with a learning rate of $$\alpha > 0$$:

$$x_i^{(t+1)} = x_i^{(t)} - \alpha \nabla f_{(x_1^{(t)}, \ldots, x_n^{(t)})}(x_i^{(t)}).$$

We continue until a certain step $$N$$.

### Precomputations

Defining $$g_\sigma:= x \mapsto - \left( 2 \pi \right)^{-d/2} \sigma^{-d-2} e^{-\frac{x^2}{2\sigma^2}} x$$, which is the derivative of a marginal density of an isotropic Gaussian centered in $$0$$ and with variance $$\sigma^2 I$$, we rewrite (details in Annex 1):

$$\nabla f_{(x_1, \ldots, x_n)}(x_i) = -n^{-1} \sum_{j=1}^{n} g_\sigma \left( \|x_j-x_i\| \right)  \frac{x_j-x_i}{\|x_j-x_i\|}.$$
### Alternatives

#### Alternative 1

Instead of updating the mixture density at each step, we can consider the initial mixture density only, that is, we let some initial points $$x_1^{(1)}, \ldots, x_n^{(1)}$$ and define the evolution of the system, for all $$t$$ and $$i$$, with:

$$x_i^{(t+1)} = x_i^{(t)} - \alpha \nabla f_{(x_1^{(1)}, \ldots, x_n^{(1)})}(x_i^{(t)}).$$

#### Alternative 2

Instead of updating the mixture density at each step, we perform the Alternative 1 until convergence. If there is no convergence for some points, we stop with error. Otherwise, we take the final points as initial points and repeat the process (performing Alternative 1 until convergence). We stop when the initial and the final points are the same during one step of the process.

### Look

[How many modes can a Gaussian mixture have?](https://www.cs.toronto.edu/~miguel/research/GMmodes.html)


## Euclidian case

Let $$K$$ be $$\mathbb{R}$$ or $$\mathbb{C}$$.
Let $$g$$ be a function from $$\mathbb{R}^{+}$$ to $$K$$ such that $$g(0) = 0$$.
Let $$x_1, \ldots, x_n \in K^d$$ be points of the space.
Let $$\lambda_1, \ldots, \lambda_n \in K$$ be the type of each point.
Let $$\mu_1, \ldots, \mu_n \in K$$ be the densitype of each point.

### Action of the points on $$x_i$$

Consider $$x_i$$ one of the points. We can look at the vector space centered on it, so $$x_i$$ is our new origin $$O$$: The position of any $$x_j$$ as seen by $$x_i$$ is $$x_j - x_i$$ (Note: this is the Log function for the Euclidian space).

The unit vector from $$x_i$$ to $$x_j$$ is $$(x_j - x_i) / \| x_j - x_i \|$$.

<!---
We define the force of the action between $$x_i$$ and $$x_j$$ as proportional to $$g(\| x_j - x_i \|)$$.

We also multiply by $$\mu_j$$ the densitype of $$x_j$$.
-->

The force of $$x_j$$ on $$x_i$$ is defined by:

$$\mu_j  g(\| x_j - x_i \|)  \frac{x_j - x_i}{\| x_j - x_i \|}.$$

The global force of all the points on $$x_i$$ is defined by:

$$F_i := \lambda_i n^{-1} \sum_{j=1}^{n} \mu_j g(\| x_j - x_i \|) \frac{x_j - x_i}{\| x_j - x_i \|}.$$

Note that in this formula we let the action of $$i$$ on itself at $$0$$. This is why $$g(0)$$ must be $$0$$.

<!---
Better, we would like $$x \times g(|| x ||) / || x || -> 0$$ when $$|| x || -> 0$$, so $$g(|| x ||) -> 0$$ when $$|| x || -> 0$$
-->


### Dynamics

Let $$\alpha > 0$$ as small as possible the speed rate and $$N$$ a number of steps.

$$x_i$$ was one of the points. We looked at the vector space centered on it, so $$x_i$$ was our origin $$O$$: The position of $$x_i$$ after applying $$\alpha F_i$$ is $$x_i + \alpha F_i$$ (Note: this is the Exp function for the Euclidian space).
We do it for all points and we get one step. We repeat this $$N$$ times.

That is, the dynamic is for all $$t$$ and $$i$$:

$$x_i^{(t+1)} = x_i^{(t)} + \alpha F_i(t).$$

### Mixture of Gaussians as a special case

Take $$K= \mathbb{R}$$, 
$$g_\sigma:= x \mapsto - \left( 2 \pi \right)^{-d/2} \sigma^{-d-2} e^{-\frac{x^2}{2\sigma^2}} x$$,
$$\lambda_1 = \ldots = \lambda_n = 1$$,
$$\mu_1 = \ldots = \mu_n = 1$$.

Then,

$$F_i= n^{-1} \sum_{j=1}^{n} g_\sigma(\| x_j - x_i \|) \frac{x_j - x_i}{\| x_j - x_i \|}$$

and

$$x_i^{(t+1)} = x_i^{(t)} - \alpha \left( - n^{-1} \sum_{j=1}^{n} g_\sigma(\| x_j^{(t)} - x_i^{(t)} \|) \frac{x_j^{(t)} - x_i^{(t)}}{\| x_j^{(t)} - x_i^{(t)} \|} \right),$$

which is exactly a gradient descent step as seen in the introduction.

### Notes

With $$\lambda_1 = \ldots = \lambda_n = 1$$ and $$\mu_1 = \ldots = \mu_n = 1$$, we are doing a gradient descent step.

With $$\lambda_1 = \ldots = \lambda_n = -1$$ and $$\mu_1 = \ldots = \mu_n = 1$$, we are doing a gradient ascent step.

Some other special cases exist, some giving also gradient descent and ascent, but the interpretation is not straightforward.

Changing $$\lambda_i \neq 1$$ corresponds to alter the reaction to have for $$x_i$$ given the mean force received.

Changing $$\mu_j \neq 1$$ corresponds to alter the force of $$x_j$$ on any other point.

$$g$$ is possibly the first marginal of the derivative of an isotropic density function.

#### Implementation

For implementation, we write $$F_i = n^{-1} \sum_{j=1}^n F_{ij}$$ with
$$F_{ij} := \lambda_i \mu_j g(\| x_j - x_i \|) \frac{x_j - x_i}{\| x_j - x_i \|}.$$

#### Interpretation as an ODE

The system corresponds to the ODE:

$$\mathbf{x}'(t) = \mathbf{F}(t, \mathbf{x}(t)) = \mathbf{F}(\mathbf{x}(t))$$

with $$\mathbf{F} = (F_1, \ldots, F_n)$$ and $$\mathbf{x} = (x_1, \ldots, x_n).$$

<!---
$$x_i^{(t+1)} = x_i^{(t)} + \alpha F_i(t).$$
$$(x_i^{(t+dt)} - x_i^{(t)}) / dt  = F_i(t)$$
F = (F_1, ... F_n)
x = (x_1, ..., x_n)
$$(x^{(t+dt)} - x^{(t)}) / dt  = F(t)$$
Finite_difference_method and link with EDO.
Look the EDO linked with those steps, not so difficult:
+: close to what is done, so allows to compare dynamic systems and see if it already exists. Possible to solve it in special cases!
-: probably cannot be solved in general
-->

## General case

Let $$M$$ be a Riemannian manifold like $$\mathbb{R}^d$$ or $$\mathbb{S}^{d-1}$$.

todo

In the general case, ok with the sphere, but in general the maps Exp, Log are local only, must sum over all possible paths? Etc not so straightforward.
Better only to get $$2$$ cases (Euclidian and spherical).
Here: https://ronnybergmann.net/mvirt/manifolds/Hn.html Very good to get Euclidian, sphere, hyperbolic, and we can see how to do torus.



We are able to compute the exponential map locally. 
https://math.stackexchange.com/questions/2538499

https://fr.wikipedia.org/wiki/Vari%C3%A9t%C3%A9_riemannienne
https://en.wikipedia.org/wiki/Riemannian_manifold
https://en.wikipedia.org/wiki/Geodesic
https://math.stackexchange.com/questions/1708146/shortest-path-between-two-points-on-a-surface
topology/dim

Df (or multiple Df?)

init / number of elements

types / densitypes / Nsteps / alpha


Description:

#[0,pi[ --> [0,+inf[
#x |--> tan(x/2)
x = seq(from = 0, to = pi, length.out = 1000)
plot(tan(x/2), tan(-sin(x)/2), xlim = c(0,20))

y = tan(x/2)
plot(y, tan(-sin(2*atan(y))/2), xlim = c(0,20))
plot(y, tan(-y/(1+y^2)), xlim = c(0,20))
lines(y, -y/(1+y^2), xlim = c(0,20), col = "blue")



# Implementation

todo

# Annexes

### Annex 1. Precomputations in case of mixture of Gaussians

Let $$p$$ be the density of a Gaussian with mean $$m$$ and matrix of variance-covariance $$\Sigma$$. According to the [Matrix Cookbook 8.1.1](https://www.math.uwaterloo.ca/~hwolkowi/matrixcookbook.pdf):

$$\nabla p(x) = -p(x) \Sigma^{-1} (x-m) = -\frac{1}{\sqrt{\det(2 \pi \Sigma)}} \exp \left[ -\frac{1}{2} (x-m)^{T} \Sigma^{-1} (x-m) \right] \Sigma^{-1} (x-m).$$

Let $$f$$ be a mixture of $$n$$ Gaussians, each $$f_j$$ with parameter $$m_j = x_j$$ and $$\Sigma_j = \sigma^2 I$$ for a certain $$\sigma > 0$$. We obtain:

$$\nabla f(x) = \frac{1}{n} \sum_{j=1}^{n} \nabla f_j(x) = \left( 2 \pi \right)^{-d/2} \sigma^{-d-2} n^{-1} \sum_{j=1}^{n} \left( e^{-\frac{1}{2\sigma^2} \|x_j-x\|^2}  (x_j-x) \right).$$



<!---

Intermediate

$$\nabla f(x) = \frac{1}{n} \sum_{j=1}^{n} \nabla f_j(x) = - \frac{1}{n} \sum_{j=1}^{n} \left( \frac{1}{\sqrt{\det(2 \pi \Sigma_j)}} \exp \left[ -\frac{1}{2} (x-m_j)^{T} \Sigma_j^{-1} (x-m_j) \right] \Sigma_j^{-1} (x-m_j) \right).$$

With $$m_j = x_j$$ and $$\Sigma_j = \sigma^2 I$$ for a certain $$\sigma > 0$$,

$$\nabla f(x) = - \frac{1}{n \sigma^2} \left( 2 \pi \sigma^2 \right)^{-d/2} \sum_{j=1}^{n} \left(  \exp \left[ -\frac{1}{2\sigma^2} (x-x_j)^{T} (x-x_j) \right] (x-x_j) \right).$$

$$\nabla f(x) = - \left( 2 \pi \right)^{-d/2} \sigma^{-d-2} n^{-1} \sum_{j=1}^{n} \left( e^{-\frac{1}{2\sigma^2} \|x-x_j\|^2}  (x-x_j) \right)$$

-->

Here we have expressed in terms of $$x_j - x$$ (instead of $$x - x_j$$), because we look at the sum with a fixed $$x$$ which is our *origin* point at this moment. The density $$f_0$$ of a Gaussian with mean $$0$$ and variance $$\sigma^2 I$$ is isotropic, and the marginal of the first component of the derivative of the density $$g_\sigma: x \mapsto \nabla f_0(x, 0, \ldots, 0)$$ is given by:

$$g_\sigma:= x \mapsto - \left( 2 \pi \right)^{-d/2} \sigma^{-d-2} e^{-\frac{x^2}{2\sigma^2}} x.$$

We obtain our final expression for $$\nabla f(x)$$:

<!---
$$\nabla f(x) = n^{-1} \sum_{j=1}^{n} g_\sigma \left( \|x-x_j\| \right)  \frac{x-x_j}{\|x-x_j\|} $$
-->

$$\nabla f(x) = -n^{-1} \sum_{j=1}^{n} g_\sigma \left( \|x_j-x\| \right)  \frac{x_j-x}{\|x_j-x\|}.$$

<!---
In the case $$\sigma = 1$$, we let $$g = g_1 = x \mapsto - \left( 2 \pi \right)^{-d/2} e^{-\frac{x^2}{2}} x$$ and 

$$\nabla f_{(x_1, \ldots, x_n)}(x) = -n^{-1} \sum_{j=1}^{n} g \left( \|x_j-x\| \right)  \frac{x_j-x}{\|x_j-x\|}.$$
-->




