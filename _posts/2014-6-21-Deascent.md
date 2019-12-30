---
layout: post
title: Introduction to hidden Markov models 2
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>
<a href="../images/2014-6-11-Introduction-hmm/HMM_introduction.pdf" target="_blank"><img src = "../images/2014-6-11-Introduction-hmm/HMM_introduction.png"></a>


This is a draft in progress.
Let $$\mathbb{E}$$ be something like $$\mathbb{R}^n$$ or $$\mathbb{S}^{n-1}$$.


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


