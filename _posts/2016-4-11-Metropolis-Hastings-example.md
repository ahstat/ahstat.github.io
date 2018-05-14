---
layout: post
title: An illustration of the Metropolis–Hastings algorithm
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

The *Metropolis–Hastings algorithm* is a method for sampling from a probability distribution.
It is used when direct sampling is difficult.

This post provides an illustration through sampling from $$\mathcal{N}(. \mid > 5)$$ -- the normal distribution conditional on being greater than $$5$$. 


In practice, no need to use Metropolis–Hastings for such simple distribution see formula from

https://en.wikipedia.org/wiki/Truncated_normal_distribution#Simulating


Metropolis–Hastings often used for high-dimensional distributions, when normalization coefficient is unknown.

Noting that direction rejection does not work even in this case.

It is This example is only illustrative, 
offer a fair compromise between...


Simulation code is available has been written in R and say the link.



This code introduces a simple example of the algorithm, in the case
where the instrumental distribution is chosen symmetric.

### New paragraph

The aim is to simulate a sample following a distribution (target 
distribution). Density of this target distribution is only known up to a
multiplicative constant.

The idea is to perform simulations through another distribution (instrumental
distribution). This instrumental distribution is chosen to be easy to
compute. 

The simulations through the instrumental distribution are "corrected".
To do this, we construct a Markov chain which admits a unique
stationary distribution which is the target distribution.
In practice, steps of the chain follows the instrumental distribution,
but step can be rejected with a certain probability.

### New paragraph

In this example, we want to simulate a sample of the standard normal
distribution knowing that the values are greater than a limit 5. If we
want to obtain this sample directly by reject algorithm, most of values
are rejected.






<center>
<img src="../images/2016-4-11-Metropolis-Hastings-example/before.png" alt="2D dataset to cluster"/>

</center>


*Fig. 1. ...*
