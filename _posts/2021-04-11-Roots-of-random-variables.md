---
layout: post
title: Roots of random variables
published: true
comments: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>


Given a univariate random variable $$Z$$ with density $$f_Z$$, and a polynomial $$Q[X_1, \ldots, X_n]$$, we are interested in finding a random variable $$X$$ such that, given independent copies of it $$X_1, \ldots, X_n$$ (where $$\stackrel{\text{D}}{=}$$ stands for the equality in distribution):

$$Z \stackrel{\text{D}}{=} Q[X_1, \ldots, X_n].$$

This is a different problem from studying the root of a random polynomial, where the coefficients are random but not the variables. This is also different from computing $$Z$$ given $$X$$ (which is the inverse problem).

We only consider the case of multivariate monomials ($$X_1^3, X_1 X_2 X_3, X_1^2 X_2, \ldots$$) and of some common distributions on $$\mathbb{R}$$ (normal, exponential, gamma distributions).

We consider at first the cases $$X_1^k$$ and $$X_1 \ldots X_k$$ before moving to the monomials up to degree five (the number of monomials of degree $$k$$ is given by [the partition numbers](http://oeis.org/A000041)):

- $$X_1$$,
- $$X_1^2$$, $$X_1 X_2$$,
- $$X_1^3$$, $$X_1^2 X_2$$, $$X_1 X_2 X_3$$,
- $$X_1^4$$, $$X_1^3 X_2$$, $$X_1^2 X_2^2$$, $$X_1^2 X_2 X_3$$, $$X_1 X_2 X_3 X_4$$,
- $$X_1^5$$, $$X_1^4 X_2$$, $$X_1^3 X_2^2$$, $$X_1^3 X_2 X_3$$, $$X_1^2 X_2 X_3 X_4$$, $$X_1^2 X_2^2 X_3$$, $$X_1 X_2 X_3 X_4 X_5.$$

## Root of $$X^k = Z$$

### Case of positive variables

For $$Z$$ distributed on $$\mathbb{R}^{+}$$, and $$X$$ searched as nonnegative too, 
a change of variable gives the following density function, for $$x \geq 0$$:

$$f_X(x) = k x^{k-1} f_Z(x^k).$$

A way of generating $$X$$ from $$Z$$ is given by: 

$$X = Z^{1/k}.$$

### Other cases

For $$k = 2$$, if $$Z$$ is nonnegative but $$X$$ is real, then $$X = -\sqrt{Z}$$ also works. 
But $$X = (-1)^{\mathbf{1}_{Z \leq 1}} \sqrt{Z}$$ also. 


<details>
  <summary>Test 1</summary>
  
  ## Heading
  1. A numbered
  2. list
     * With some
     * Sub bullets
</details>

<details>
  <summary>Test 1.5</summary>

  ## Heading
  1. A numbered
  2. list
     * With some
     * Sub bullets
</details>

<details>
  <summary>Test 2</summary>

  Simple text
</details>

<details>
  <summary>Test 3</summary>

## Heading
1. A numbered
2. list
   * With some
   * Sub bullets
</details>

<details>
  <summary>Test 4</summary>
  
## Heading
1. A numbered
2. list
   * With some
   * Sub bullets
</details>

<details>
  <summary>Test 5</summary>
  
```python
TimeDistributed(Dense(activation='sigmoid', units=1),
                input_shape=(None, 1))
```
</details>

<details>
  <summary>Test 6</summary>
  
  ```python
  TimeDistributed(Dense(activation='sigmoid', units=1),
                  input_shape=(None, 1))
  ```
</details>

<details>
  <summary>Click to expand</summary>
  
  ```R
  N = 1e7
  lambda = 1
  k = 2
  Z = rexp(N, lambda)
  
  ## Positive square-root
  X = Z^(1/k)
  hist(X, probability = TRUE, breaks = 300)
  x = seq(from = -10, to = 10, length.out = 1000)
  lines(x, k * x^(k-1) * dexp(x^k, lambda) * (x > 0), col = "red")
  
  # Check that Z is here after taking the power value
  hist(X^k, probability = TRUE, breaks = 300)
  lines(x, dexp(x, lambda), col = "red")
  
  ## Negative square-root (only for k = 2)
  X = -Z^(1/k)
  hist(X, probability = TRUE, breaks = 300)
  x = seq(from = -10, to = 10, length.out = 1000)
  lines(x, k * abs(x)^(k-1) * dexp(x^k, lambda) * (x < 0), col = "red")
  
  # Check that Z is here after taking the power value
  hist(X^k, probability = TRUE, breaks = 300)
  lines(x, dexp(x, lambda), col = "red")
  
  ## Another alternative square-root (only for k = 2)
  X = ifelse(Z <= 1, Z^(1/k), -Z^(1/k))
  hist(X, probability = TRUE, breaks = 300)
  x = seq(from = -10, to = 10, length.out = 1000)
  lines(x, k * abs(x)^(k-1) * dexp(x^k, lambda) * (x < -1 | (x < 1 & x > 0)), col = "red")
  
  # Check that Z is here after taking the power value
  hist(X^k, probability = TRUE, breaks = 300)
  lines(x, dexp(x, lambda), col = "red")
  ```
  
  ## Heading
  1. A numbered
  2. list
     * With some
     * Sub bullets
</details>



If $$Z$$ has a positive probability to be negative (such as a normal variable), the variable $$X$$ may need to live on $$\mathbb{C}$$ to exist (e.g. for $$k=2$$, defining $$X := \sqrt{\mid Z \mid}$$ if $$\text{sign}(Z) \geq 0$$ and $$X := i \sqrt{\mid Z \mid}$$ otherwise will work, there are other variables that will give $$Z$$).

If $$Z$$ is a positive variable but $$X$$ is authorized to take negative values, different variables also exist.

$$Z$$ | $$Z^{1/k}$$ | After
--- | --- | ---
$$\text{Exp}(\lambda)$$ | $$k x^{k-1} \lambda \exp{-\lambda x^k}$$ | nicely
1 | 2 | 3

## Root $$\sqrt[k]{Z}$$ given by $$X_1 \ldots X_k = Z$$


$$P[X_1]$$ includes $$X_1^n$$

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
