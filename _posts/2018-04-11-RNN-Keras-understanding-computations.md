---
layout: post
title: RNN with Keras&#58; Understanding computations
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

This tutorial highlights structure of common RNN algorithms by following and understanding computations carried out by each model.
It is intended for anyone without prior understanding of RNN.
If you really never heard about RNN, you *need* to [read this post of Christopher Olah](http://colah.github.io/posts/2015-08-Understanding-LSTMs/) first.

The present post focuses on understanding step by step computations in each model, without paying attention to train something useful.
It is illustrated with [Keras](https://keras.io/) codes
and divided in five parts:

- TimeDistributed component,
- Simple RNN,
- Simple RNN with two hidden layers,
- LSTM,
- GRU.


Inputs and outputs for this section
Model definition and training
Understanding the weights
Understanding the computations






## Part A: Explanation of the TimeDistributed component

**A very simple network.**
Let's begin with one-dimensional input and output.
In Keras, the command line:

```python
Dense(activation='sigmoid', units=1)
```

corresponds to the mathematical equation:

$$y = \sigma(W x + b).$$

Input $$x$$ and output $$y$$ are one-dimensional, so the weights are such that $$W \in \mathbb{R}$$ and $$b \in \mathbb{R}$$. The output layer is indeed one-dimensional because we let `units = 1` in the previous command line.
This equation can be represented by the following diagram (note that bias term $$b$$ and activation function $$\sigma$$ have been masked to improve lisibility):

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/time_distributed_first.svg" alt="" width="40%"/></center>

**TimeDistributed wrapper in dimension 1.** 
The TimeDistributed wrapper applies the same layer at each time step. 
For example, with one-dimensional input and output along $$T = 6$$ dates, input is represented with $$(x_0, \ldots, x_5) \in \mathbb{R}^6$$ and output with $$(y_0, \ldots, y_5) \in \mathbb{R}^6$$. Then, the model:

```python
TimeDistributed(Dense(activation='sigmoid', units=1),
                input_shape=(None, 1))
```

corresponds to the equation:

$$y_t = \sigma(W x_t + b)$$

applied at each $$t \in \lbrace 0, \ldots 5 \rbrace$$. Note that $$W \in \mathbb{R}$$ and $$b \in \mathbb{R}$$ are identical for each $$t$$. In the previous command line, `input_shape=(None, 1)` means that input layer is an array of shape $$T \times 1$$, and `units = 1` means that output layer contains $$1$$ unit for each $$t$$. This model can be represented by the diagram:

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/time_distributed.svg" alt="" width="40%"/></center>

**Input and output shapes in practice.**
Input has usually the shape $$(N, T, m)$$, where $$N$$ is sample size, $$T$$ is temporal size, and $$m$$ is the dimension of each input vector.
Output has the shape $$(N, T, m')$$, where $$m'$$ is the dimension of each output vector.
In the previous example, we have selected $$T = 6$$, $$m = 1$$, and $$m' = 1$$. 

**Prediction of new inputs.**
Given a model trained on inputs of shape $$(N, T, m)$$,
we can feed the model with new inputs of shape $$(k, l, m)$$.

In the previous example, we can select for example:

```python
new_input = np.array([[[1],[0.8],[0.6],[0.2],
                      [1],[0],[1],[1]]])
new_input.shape # (1, 8, 1)
print(model.predict(new_input))
```

**Complete example of TimeDistributed with higher dimensions.**
Let $$N = 256$$, $$T = 6$$, $$m = 2$$, $$m' = 3$$. Training inputs have shape $$(256, 6, 2)$$ and training outputs have shape $$(256, 6, 3)$$.

The model is built and trained as follows:

```python
dim_in = 2
dim_out = 3
model=Sequential()
model.add(TimeDistributed(Dense(activation='sigmoid', units=dim_out), # target is dim_out-dimensional
                          input_shape=(None, dim_in))) # input is dim_in-dimensional
model.compile(loss = 'mse', optimizer = 'rmsprop')
model.fit(x_train, y_train, epochs = 100, batch_size = 32)
```

Output for a new input of shape $$(k, l, m)$$ can be predicted as follows:

```python
new_input = np.array([[[1,1],[0.8,0.8],[0.6,0.6],[0.2,0.2],[1,1],[0,0]]])
new_input.shape # (1, 6, 2), which is a valid shape for this model
print(model.predict(new_input))
# [[[ 0.67353392  0.59669352  0.57625091]
#   [ 0.61093992  0.56769931  0.55657816]
#   [ 0.54446143  0.53823376  0.53672636]
#   [ 0.40912622  0.47870329  0.4967348 ]
#   [ 0.67353392  0.59669352  0.57625091]
#   [ 0.34512752  0.44905871  0.47672269]]]
# output is (1, 6, 3) as expected.
# Note that each column has been trained differently
```

Computations can be understood in details:

```python
W = model.get_weights()[0] # this is a (2,3) matrix
b = model.get_weights()[1] # this is a (3,1) vector
# At each time, we have a dense neural network 
# (without hidden layer) from 2+1 inputs to 3 outputs.
# On the whole, there are 9 parameters 
# (the same parameters are used at each time).

[[sigmoid(y)
  for y in np.dot(x,W) + b] # like doing X * beta
  for x in [[1,1],[0.8,0.8],[0.6,0.6],[0.2,0.2],[1,1],[0,0]]]
# We obtain the same results as with 'model.predict'
```

For each element of the sample $$n$$, for each time step $$t$$, we
take $$x_t$$ a two-dimensional vector. This is $$(1,1)$$ for $$n = 0$$ and $$t = 0$$ in the previous example.
We compute $$W x_t + b$$ and obtain a three-dimensional vector.
We finally apply the sigmoid function $$\sigma$$ to each component.

## Part B: Explanation of simple RNN

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/time_distributed_first.svg" alt="" width="50%"/></center>

text

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/time_distributed.svg" alt="" width="50%"/></center>

text

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/rnn.svg" alt="" width="40%"/></center>

text

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/double_all.svg" alt="" width="80%"/></center>

text

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/lstm3.svg" alt="" width="80%"/></center>

text

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/gru.svg" alt="" width="80%"/></center>

text

### Inputs and outputs for this section



### Model definition and training


### Understanding the weights


### Understanding the computations



## Part C: Explanation of simple RNN with two hidden layers



### Inputs and outputs for this section



### Model definition and training


### Understanding the weights


### Understanding the computations


## Part D: Explanation of LSTM


### Inputs and outputs for this section



### Model definition and training


### Understanding the weights


### Understanding the computations


## Part E: Explanation of GRU


### Inputs and outputs for this section



### Model definition and training


### Understanding the weights


### Understanding the computations


### References

For TimeDistributed: [https://stackoverflow.com/questions/38294046]() and [https://keras.io/layers/wrappers/]().
