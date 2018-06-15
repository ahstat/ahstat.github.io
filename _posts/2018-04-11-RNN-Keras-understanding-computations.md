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

[INTRO to rewrite + add illustration]




## Part A: Explanation of the TimeDistributed component

**A very simple network.**
Let's begin with one-dimensional input and output.
In Keras, the command line:

```python
Dense(activation='sigmoid', units=1)
```

corresponds to the mathematical equation:

$$y = \sigma(W_y x + b_y).$$

Input $$x$$ and output $$y$$ are one-dimensional, so the weights are such that $$W_y \in \mathbb{R}$$ and $$b_y \in \mathbb{R}$$. The output layer is indeed one-dimensional because we let `units = 1` in the previous command line.
This equation can be represented by the following diagram (bias term $$b_y$$ has been masked to improve lisibility):

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/time_distributed_first.svg" alt="" width="50%"/></center>

**TimeDistributed wrapper in dimension 1.** 
The TimeDistributed wrapper applies the same layer at each time step. 
For example, with one-dimensional input and output along $$T = 6$$ dates, input is represented with $$(x_0, \ldots, x_5) \in \mathbb{R}^6$$ and output with $$(y_0, \ldots, y_5) \in \mathbb{R}^6$$. Then, the model:

```python
TimeDistributed(Dense(activation='sigmoid', units=1),
                input_shape=(None, 1))
```

corresponds to the equation:

$$y_t = \sigma(W_y x_t + b_y)$$

applied at each $$t \in \lbrace 0, \ldots 5 \rbrace$$. Note that $$W_y \in \mathbb{R}$$ and $$b_y \in \mathbb{R}$$ are identical for each $$t$$. In the previous command line, `input_shape=(None, 1)` means that input layer is an array of shape $$T \times 1$$, and `units = 1` means that output layer contains $$1$$ unit for each $$t$$. This model can be represented by the diagram:

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/time_distributed.svg" alt="" width="50%"/></center>

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
new_input = model.predict(np.array([[[1,1]]]))
new_input.shape # (1, 1, 2), which is a valid shape for this model
print(model.predict(new_input))
# [[[ 0.70669621  0.70633912  0.65635538]]]
# output is (1, 1, 3) as expected.
# Note that each column has been trained differently
```

This computation can be understood in details,
by taking $$x_t$$ a two-dimensional vector,
computing $$W_y x_t + b_y$$,
and then applying the sigmoid function $$\sigma$$ to each component.

```python
W_y = model.get_weights()[0] # this is a (2,3) matrix
b_y = model.get_weights()[1] # this is a (3,1) vector
# At each time, we have a dense neural network 
# (without hidden layer) from 2+1 inputs to 3 outputs.
# On the whole, there are 9 parameters 
# (the same parameters are used at each time).

[[sigmoid(y)
  for y in np.dot(x,W_y) + b_y] # like doing X * beta
  for x in [[1,1]]]
# We obtain the same results as with 'model.predict'
```

We have:
$$
W_y = \begin{bmatrix}
0.76 & 0.68 & 0.66 \\
0.92 & 0.99 & 0.52
\end{bmatrix}
$$,
$$
b_y = \begin{bmatrix}
-0.80 \\
-0.79 \\
-0.54
\end{bmatrix}
$$,
and we take
$$x_t = \begin{bmatrix}
1 \\
1
\end{bmatrix}$$.
The formula $$W_y^\intercal x_t + b_y$$ (note the transpose for dimensional correctness) gives
$$W_y^\intercal x_t + b_y = \begin{bmatrix}
0.88 \\
0.88 \\
0.65
\end{bmatrix},$$
and after applying the sigmoid on each component, we obtain:
$$y_t = \begin{bmatrix}
0.71 \\
0.71 \\
0.66
\end{bmatrix}$$.

## Part B: Explanation of simple RNN

*Simple RNN* is the simplest way for a neural network to keep information along time.
Information is stored in the hidden variable $$h$$ and updated at each time based on new inputs.
Simple RNN can be connected to a time distributed component to form the *Elman's network*, introduced in 1990. The time distributed component allows computing output from the hidden variable.
We describe this complete network in this part.

**Description of the network.**
In Keras, the command lines:

```python
dim_in=3; dim_out=2; nb_units=5;
model=Sequential()
model.add(SimpleRNN(input_shape=(None, dim_in), 
                    return_sequences=True, 
                    units=nb_units))
model.add(TimeDistributed(Dense(activation='sigmoid',
                                units=dim_out)))
```

corresponds to the mathematical equations (for all time $$t$$):

$$
\begin{align}
h_t =& \sigma(W_x x_t + W_h h_{t-1} + b_h), \\
y_t =& \sigma(W_y h_t + b_y).
\end{align}
$$

As before, training inputs have shape $$(N, T, m)$$ and training outputs have shape $$(N, T, m')$$. In this example, we have taken $$m = 3$$ and $$m' = 2$$, then $$x_t$$ is a two-dimensional vector and $$y_t$$ is a three-dimensional vector.
We have selected `units=5`, so $$h_t$$ is a five-dimensional vector.
In details, the `SimpleRNN` line computes the full sequence $$(h_0, \ldots h_T)$$ from $$(x_0, \ldots, x_T)$$ (and initial $$h_{-1}$$); the `TimeDistributed` line computes the sequence $$(y_0, \ldots y_T)$$ from $$(h_0, \ldots h_T)$$.

Those equations can be represented by the following diagram:

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/simple_all.svg" alt="" width="70%"/></center>

This diagram shows one temporal step of the network, explaining how to compute $$h_t$$ and $$y_t$$ from $$x_t$$ and $$h_{t-1}$$.

It remains to select the initial value $$h_{-1}$$ of the hidden variable, and we take the null vector: $$h_{-1} = \left( 0,0,0,0,0 \right)^\intercal$$.


**Complete example of simple RNN.**
Let $$N = 256$$, $$T = 6$$, $$m = 2$$, $$m' = 3$$. Training inputs have shape $$(256, 6, 2)$$ and training outputs have shape $$(256, 6, 3)$$.

The model is built and trained as follows:

```python
dim_in = 2; dim_out = 3; nb_units = 5
model=Sequential()
model.add(SimpleRNN(input_shape=(None, dim_in), 
                    return_sequences=True, 
                    units=nb_units))
model.add(TimeDistributed(Dense(activation='sigmoid', units=dim_out)))
model.compile(loss = 'mse', optimizer = 'rmsprop')
model.fit(x_train, y_train, epochs = 100, batch_size = 32)
```

The weights of the trained network are:

```python
W_x = model.get_weights()[0] # W_x a (3,5) matrix
W_h = model.get_weights()[1] # W_h a (5,5) matrix
b_h = model.get_weights()[2] # b_h a (5,1) vector
W_y = model.get_weights()[3] # W_y a (5,2) matrix
b_y = model.get_weights()[4] # b_y a (2,1) vector
```

We want to predict output for a new input of shape $$(k,l,m)$$. We take a shape $$(1, 3, 3)$$ and let:
$$x_0 = (4,2,1)^\intercal$$, $$x_1 = (1,1,1)^\intercal$$, and $$x_2 = (1,1,1)^\intercal$$. The model predicts output for this series:

```python
new_input = [[4,2,1], [1,1,1], [1,1,1]]
print(model.predict(np.array([new_input])))
# [[[ 0.79032147  0.42571515]
#   [ 0.59781438  0.55316663]
#   [ 0.87601596  0.86248338]]]
```

It is possible to retrive this result manually by computing $$h_0$$ from $$x_0$$ and $$h_{-1}$$; then $$y_0$$ from $$h_0$$; then $$h_1$$ from $$x_1$$ and $$h_{0}$$; then $$y_1$$ from $$h_1$$; then $$h_2$$ from $$x_2$$ and $$h_{1}$$; then $$y_2$$ from $$h_2$$. This is detailed in Part B of the companion code.

## Part C: Explanation of simple RNN with two hidden layers

In Part B, we have connected a `SimpleRNN` layer and a `TimeDistributed` layer to form an Elman's network with one hidden layer. It is easy to stack another `SimpleRNN` layer.

This Keras code:

```python
dim_in = 3; dim_out = 2
model=Sequential()
model.add(SimpleRNN(input_shape=(None, dim_in), 
                    return_sequences=True, 
                    units=5))
model.add(SimpleRNN(input_shape=(None,4), 
                    return_sequences=True, 
                    units=7))
model.add(TimeDistributed(Dense(activation='sigmoid',
                                units=dim_out)))
```

corresponds to the mathematical equations (for all time $$t$$):

$$
\begin{align}
h_t =& \sigma(W_x x_t + W_h h_{t-1} + b_h), \\
h'_t =& \sigma(W'_x h_t + W'_h h'_{t-1} + b'_h), \\
y_t =& \sigma(W_y h'_t + b_y).
\end{align}
$$

and is represented by the following diagram (two temporal steps are shown to help understanding how all is connecting together):

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/double_all.svg" alt="" width="80%"/></center>

In this example, at each time $$t$$, $$x_t$$, $$h_t$$, $$h'_t$$, $$y_t$$ are vectors of size $$2$$, $$5$$, $$7$$, $$3$$ respectively.

Shape of weight matrices and manual computations are detailed in Part C of the companion code.

## Part D: Explanation of LSTM

**From SimpleRNN layer to LSTM layer**
In Part B, we used a `SimpleRNN` layer to update the hidden variable $$h$$, i.e. to compute $$h_t$$ from $$(x_t, h_{t-1})$$. This layer in isolation is represented as follows: 

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/rnn.svg" alt="" width="40%"/></center>

Long short-term memory (LSTM) networks replace the `SimpleRNN` layer with an `LSTM` layer. An LSTM layer takes $$3$$ inputs $$(x_t, h_{t-1}, c_{t-1})$$ and outputs a couple $$(h_t, c_t)$$ at each step $$t$$. $$h$$ is the hidden variable and $$c$$ is the cell variable.

In Keras, the command line:
```python
LSTM(input_shape=(None, dim_in), 
                    return_sequences=True, 
                    units=nb_units,
                    recurrent_activation='sigmoid',
                    activation='tanh')
```

corresponds to the equations:

$$
\begin{align}
i_t = \sigma(W_{ix} x_t + W_{ih} h_{t-1} + b_i) \\
f_t = \sigma(W_{fx} x_t + W_{fh} h_{t-1} + b_f) \\
\tilde{c}_t = \tanh(W_{cx} x_t + W_{ch} h_{t-1} + b_c) \\
o_t = W_{ox} x_t + W_{oh} h_{t-1} + b_o) \\
   \\
c_t = f_t c_{t-1} + i_t \tilde{c}_t \\
h_t = o_t \tanh(c_t)
$$

and is represented by the following diagram:

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/lstm3.svg" alt="" width="80%"/></center>

**Dimension of each element.**
It can be confusing to understand how all the matrices are organized. ...







**Connecting LSTM layer with subsequent layers.**




Updated
...
Core idea of LSTMs is better explained in ...this post....
Here, only describe the network and how computed in Keras.



 is the simplest way for a neural network to keep information along time.




### Inputs and outputs for this section



### Model definition and training


### Understanding the weights


### Understanding the computations

text


text




## Part E: Explanation of GRU


### Inputs and outputs for this section



### Model definition and training


### Understanding the weights


### Understanding the computations

<center><img src="../images/2018-04-11-RNN-Keras-understanding-computations/gru.svg" alt="" width="80%"/></center>

text

### References

For TimeDistributed: [https://stackoverflow.com/questions/38294046]() and [https://keras.io/layers/wrappers/]().
