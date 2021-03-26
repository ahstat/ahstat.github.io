---
layout: post
title: Roots of random variables
published: true
comments: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

Given a univariate random variable $Z$ with density $f$, and a polynomial $P[X_1, \lods, X_n]$, we are interested in finding a random variable $X$ such that, given independent copies of it $X_1, \ldots, X_n$ (where $\stackrel{\text{D}}{=}$ stands for the equality in distribution):

$$Z \stackrel{\text{D}}{=} P[X_1, \lods, X_n].$$

This is a different problem from studying the root of a random polynomial, where the coefficients are random but not the variables.


$P[X_1]$ includes $X_1^n$

etc.

TODO the rest




y never heard about RNN, you can [name to give](https://address/) first.

The present post focuses on understanding computations in each model step by step, without paying attention to train something useful.
It is illustrated with [Keras](https://keras.io/) codes
and divided into five parts:

- TimeDistributed component,
- Simple RNN,
- Simple RNN with two hidden layers,
- LSTM,
- GRU.

<center><a href="https://ahstat.github.io/RNN-Keras-understanding-computations/"><img src="../images/2018-04-11-RNN-Keras-understanding-computations/lstm3.svg" alt="" width="80%"/></a></center>


*This diagram is an illustration of an LSTM cell. Check out part D for details.*

Companion source code for this post is available [here](https://github.com/ahstat/deep-learning/blob/master/rnn/1_math_structure_of_rnn.py).

long-dependence series. The main issue is caused by the [vanishing gradient problem](https://en.wikipedia.org/wiki/Vanishing_gradient_problem). This problem is detailed in [Section 10.7 of the Deep Learning book](https://www.deeplearningbook.org/contents/rnn.html).

## Part A: Explanation of the TimeDistributed component

**A very simple network.**
Let's begin with one-dimensional input and output.


### References

- [Companion code for this post](https://github.com/ahstat/deep-learning/blob/master/rnn/1_math_structure_of_rnn.py)
- [Understanding LSTM Networks](https://colah.github.io/posts/2015-08-Understanding-LSTMs/) by Christopher Olah,
- [Keras documentation for TimeDistributed](https://keras.io/layers/wrappers/),
- [Keras documentation for RNN](https://keras.io/layers/recurrent/),
- [Wikipedia page on RNN describing the Elman networks](https://en.wikipedia.org/wiki/Recurrent_neural_network).
- Thanks to J. Leon for this [Tikz figure](https://tex.stackexchange.com/questions/432312/how-do-i-draw-an-lstm-cell-in-tikz), on which I made figures ([full sources are here](https://github.com/ahstat/ahstat.github.io/tree/master/images/2018-04-11-RNN-Keras-understanding-computations/tex_archives))
