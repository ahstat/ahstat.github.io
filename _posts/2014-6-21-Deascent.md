---
layout: post
title: Introduction to hidden Markov models 2
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>
<a href="../images/2014-6-11-Introduction-hmm/HMM_introduction.pdf" target="_blank"><img src = "../images/2014-6-11-Introduction-hmm/HMM_introduction.png"></a>


This is a draft in progress.

## Specific case of mixture of Gaussians

This case is to get the general idea of the system.

### Definition of the system

For points $$x_1, \ldots, x_m \in \mathbb{R}^n$$, we define $$f_{x_1, \ldots, x_m}$$ the mixture of the densities $$f_1, \ldots, f_m$$, where for each $$i \in \lbrace 1, \ldots m \rbrace$$, $$f_i$$ is a Gaussian density centered in $$x_i$$ and with unit variance.

The dynamic of the system is described as follows.
First, we initialize points $$x_1^{(1)}, \ldots, x_m^{(1)} \in \mathbb{R}^n$$

Then, for each $$t \in \mathbb{N}^{*}$$, for each $$i \in \lbrace 1, \ldots m \rbrace$$, we let the point $$x_i^({t})$$ performs a gradient descent step following $$f_{(x_1^{(t)}, \ldots, x_m^{(t)})}$$ with a learning rate of $$\alpha > 0$$:

$$x_i^{(t+1)} = x_i^{(t)} - \alpha \nabla f_{(x_1^{(t)}, \ldots, x_m^{(t)})}(x_i^{(t)}).$$
We continue until a certain step $$N$$.

### Precomputations

$$\nabla f$$ has a closed-form... Write here.

### Alternatives

#### Alternative 1

Instead of updating the mixture density at each step, we can only consider the initial mixture density, that is, the initial points are the same and the evolution is as follows for all $$t$$ and $$i$$:

$$x_i^{(t+1)} = x_i^{(t)} - \alpha \nabla f_{(x_1^{(1)}, \ldots, x_m^{(1)})}(x_i^{(t)}).$$

#### Alternative 2

Instead of updating the mixture density at each step, we perform the Alternative 1 until convergence. If there is no convergence for some points, we stop with error. Otherwise, we take the final points as initial points and repeat the process (performing Alternative 1 until convergence). We stop when the initial and the final points are the same during one step of the process.

### Look

[How many modes can a Gaussian mixture have?](http://www.cs.toronto.edu/~miguel/research/GMmodes.html)


## General case for $$K^n$$

$$K$$ is $$\mathbb{R}$$ or $$\mathbb{C}$$.

Let $$g$$ be a function on $$\mathbb{R}^{+}$$ such that $$g(0) = 0$$.
Let $$x_1, \ldots, x_m \in K^n$$ be points of the space.
Let $$\lambda_1, \ldots, \lambda_m \in K$$ the type of each point.
Let $$\mu_1, \ldots, \mu_m \in K$$ the densitype of each point.

#### ...

Let $$\lambda_1, \ldots, \lambda_m \in \lbrace -1, 1 \rbrace$$ the type of each point.
Let $$\mu_1, \ldots, \mu_m \in \lbrace -1, 1 \rbrace$$ the densitype of each point.




Generalize here.
Possibly the derivative of a density function, for example the density of a Gaussian distribution.
If we take $$\lambda = \mu = 1$$, and $$f$$ is a density function, interpretation as a mixture, and the movement is for each point to follow the resulting density function.




### Action of the points on $$x_i$$

Consider $$x_i$$ one of the points. We can look at the vector space centered on it, so $$x_i$$ is our new origin $$O$$: The position of $$x_j$$ as seen by $$x_i$$ is $$x_j - x_i$$ (* this is Log function)

The unit vector from $$x_i$$ to $$x_j$$ is $$(x_j - x_i) / \| x_j - x_i \|$$.


We define the force of the action as proportional to $$g$$ of the distance between $$x_i$$ and $$x_j$$ i.e.  $$g(\| x_j - x_i \|)$$.

We also multiply by $$\mu_j$$ the densitype of $$x_j$$.

Finally, the action of $$x_j$$ on $$x_i$$ is given by:

$$\mu_j \times g(|| x_j - x_i ||) \times (x_j - x_i) / || x_j - x_i ||.$$

The global action of all the points is given by:

$$\frac{1}{n} \sum_{j=1}^{n} \mu_j \times g(|| x_j - x_i ||) \times (x_j - x_i) / || x_j - x_i ||.$$



Note that in this formula we let the action of $$i$$ on itself at $$0$$. This is why $$g(0)$$ must be $$0$$.
Better, we would like $$x \times g(|| x ||) / || x || --> 0$$ when $$|| x || --> 0$$, so
$$g(|| x ||) --> 0$$ when $$|| x || --> 0$$

The global action with $$\lambda_i$$ is given by:

$$F_i := \lambda_i \times \frac{1}{n} \sum_{j=1}^{n} \mu_j \times g(|| x_j - x_i ||) \times (x_j - x_i) / || x_j - x_i ||.$$

### Movement

Let $$\alpha > 0$$ as small as possible the speed rate and $$N$$ a number of steps.

$$x_i$$ was one of the points. We looked at the vector space centered on it, so $$x_i$$ was our origin $$O$$: The position of $$x_i$$ after applying $$F_i$$ is $$x_i + \alpha F_i$$ (** this is Exp function).

We do it for all points and we get one step. We repeat this $$N$$ times.

## Todo

$$\mathbb{R}^n$$ can be easily a field $$K$$, $$\mathbb{C}^n$$, or $$\mathbb{H}^n$$?

$$\lambda, \mu$$ can easily lives in the scalar $$K$$, not only $$\lbrace -1, 1 \rbrace$$?

In the general case, ok with the sphere, but in general the maps Exp, Log are local only, must sum over all possible paths? Etc not so straightforward.
Better only to get $$2$$ cases (Euclidian and spherical).
Here: https://ronnybergmann.net/mvirt/manifolds/Hn.html Very good to get Euclidian, sphere, hyperbolic, and we can see how to do torus.

Look the EDO linked with those steps, not so difficult:
+: close to what is done, so allows to compare dynamic systems and see if it already exists. Possible to solve it in special cases!
-: probably cannot be solved in general

## General case

Let $$M$$ be a Riemannian manifold like $$\mathbb{R}^n$$ or $$\mathbb{S}^{n-1}$$.

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


