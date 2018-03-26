---
layout: post
title: RNN with Keras&#58; Predicting time series
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>
This tutorial provides a complete introduction of time series prediction with RNN.

In part A, we predict *short* time series using stateless LSTM. Computations give good results for this kind of series.

In part B, we try to predict *long* time series using stateless LSTM. In that case, models lead to poor results. 

In part C, we circumvent this issue by training **stateful LSTM**. We consider the case of one input and one output. Stateful models are tricky with Keras, because you need to be careful on how to cut time series, select batch size, and reset states. I wrote a wrapper function working in all cases for that purpose.

In part D, stateful LSTM is used to predict multiple outputs from multiple inputs.

<center><img src="../images/2018-03-11-RNN-Keras-time-series/intro14.png" alt="framework with T=10"/></center>



*Fig. 1. Framework with input time series on the left, RNN model in the middle, and output time series on the right*





Companion source code for this post is available [here](https://github.com/ahstat/deep-learning/blob/master/rnn/4_lagging_and_stateful.py).

### Description of the problem

We focus on the following problem.
Let $$x_1, x_2, x_3, x_4$$ four time series following the uniform distribution on $$[0, 1]$$. Each time series is indexed by $$\lbrace 0, 1, \ldots, T-1 \rbrace$$.

Let $$y_1, y_2, y_3$$ three time series defined as:

* $$y_1(t) = x_1(t-2)$$ for $$t \geq 2$$,
* $$y_2(t) = x_2(t-1) \times x_3(t-2)$$ for $$t \geq 2$$,
* $$y_3(t) = x_4(t-3)$$ for $$t \geq 3$$.

Each time series is also indexed by $$\lbrace 0, 1, \ldots, T-1$$ (First undefined elements of $$y_1, y_2, y_3$$ are randomly sampled).

Our task is to predict the three lagged time series $$y = (y_1, y_2, y_3)$$ based on inputs $$x = (x_1, x_2, x_3, x_4)$$. To this end, we will train different RNN models.
Fig. 1 represents the framework when $$T=10$$.


### Training and test sets

Two parameters are used to define training and test sets: $$N$$ the number of sample elements and $$T$$ the length of each time series. Each sample element consists of inputs $$x = (x_1, x_2, x_3, x_4)$$ (four time series of length $$T$$) and outputs $$y = (y_1, y_2, y_3)$$ (three time series of length $$T$$).

We take the same number of elements $$N$$ in the training and the test set.

On the whole, for $$i \in \lbrace 0, ..., N-1 \rbrace$$, the $$i$$-th element of the training set is:
$$(x^{i,\text{train}}, y^{i,\text{train}}),$$
and the $$i$$-th element of the test set is:
$$(x^{i,\text{test}}, y^{i,\text{test}}).$$

For example, $$x^{i,\text{train}}_2(t) \in [0, 1]$$ is the value at date $$t$$ of the time series $$x^{i,\text{train}}_2$$, which is the second input of 
$$(x^{i,\text{train}}, y^{i,\text{train}})$$, which is the $$i$$-th element of the training set.

This is implemented with the function `sample_time_series_roll`

## Part A: Short time series with stateless LSTM

We consider short time series of length $$T = 37$$ and sample size $$N = 663$$.

In this part, the most difficult task is to reshape inputs and outputs correctly using numpy tools. We obtain inputs with shape $$(N, T, 4)$$ and outputs with shape $$(N, T, 3)$$.

Then, an classic LSTM model is defined and trained with $$10$$ units.

```
##
# Model
##
model=Sequential()
dim_in = 4
dim_out = 3
nb_units = 10
model.add(LSTM(input_shape=(None, dim_in),
               return_sequences=True, 
               units=nb_units))
model.add(TimeDistributed(Dense(activation='linear', 
                                units=dim_out)))
model.compile(loss = 'mse', optimizer = 'rmsprop')

##
# Training
##
# 2 seconds for each epoch
np.random.seed(1337)
history = model.fit(inputs, outputs, 
                    epochs = 500, batch_size = 32,
                    validation_data=(inputs_test, 
                                     outputs_test))
plotting(history)
```

Training performs well (see Fig. 2), and after $$500$$ epochs, training and test losses have reached $$0.0061$$.

<center><img src="../images/2018-03-11-RNN-Keras-time-series/A/4_A_y123_from_x1234.png" alt="decreasing MSE loss for short time series model"/></center>

*Fig. 2. MSE loss as a function of the number of epochs for short time series with stateless LSTM*

Results are also checked visually, here for $$i=0$$ (blue for true output; orange for predicted outputs):

<center><img src="../images/2018-03-11-RNN-Keras-time-series/A/4_A_y123_from_x1234_ts0_y1.png" alt="true and predicting outputs for y1"/></center>

*Fig. 3.a. Prediction for $$y_1$$ for short time series with stateless LSTM*

<center><img src="../images/2018-03-11-RNN-Keras-time-series/A/4_A_y123_from_x1234_ts0_y2.png" alt="true and predicting outputs for y2"/></center>

*Fig. 3.a. Prediction for $$y_2$$ for short time series with stateless LSTM*

<center><img src="../images/2018-03-11-RNN-Keras-time-series/A/4_A_y123_from_x1234_ts0_y3.png" alt="true and predicting outputs for y3"/></center>

*Fig. 3.a. Prediction for $$y_3$$ for short time series with stateless LSTM*

**Conclusion of this part:** LSTM models works well to learn short sequences.

## Part B: Problem to predict long time series with stateless LSTM

We consider long time series of length $$T = 1443$$ and sample size $$N = 17$$.
Note that product $$N \times T$$ is the same in parts A and B (so computation of $$500$$ epochs takes the same time).

We repeat the methodology described in part A in a simplified setting: We only predict $$y_1$$ (the first time series output) as a function of $$x_1$$ (the first time series input).
Even in this case, predictions are not satisfactory after $$500$$ epochs.
Training and test losses have decreased to $$0.036$$ (see Fig. 6), but it is not enough to give accurate predictions (see Fig. 7). 

Results are also checked visually for the $$50$$ first elements, here for $$i=0$$ (blue for true output; orange for predicted outputs):

<center><img src="../images/2018-03-11-RNN-Keras-time-series/A/4_B_y1_from_x1.png" alt="decreasing MSE loss for long time series model with stateless LSTM"/></center>

*Fig. 4. MSE loss as a function of the number of epochs for long time series with stateless LSTM*

Results are also checked visually, here for $$i=0$$ (blue for true output; orange for predicted outputs):

<center><img src="../images/2018-03-11-RNN-Keras-time-series/A/4_A_y123_from_x1234_ts0_y1.png" alt="true and predicting outputs for y1"/></center>

*Fig. 5. Prediction for $$y_1$$ for long time series with stateless LSTM, restricted to the $$50$$ first dates*



Conclusion: not so good to learn $$y_t = x_{t-2}$$. We need more epochs to continue learning.
In general, not working well, and we need to switch to statefull LSTM.





## Part C: Long time series with stateful LSTM
we consider stateful LSTM to perform prediction with long
time series (with user defined number of cuts and batches).

## Part D: Long time series prediction involving multiple inputs and outputs
we apply those predictions with multiple inputs and outputs


## References
To deal with part C, we consider a 0/1 time series described by Philippe
Remy in http://philipperemy.github.io/keras-stateful-lstm/ and we follow
stateful implementation in Keras according to 
https://stackoverflow.com/questions/43882796/

Model defined in https://stackoverflow.com/questions/41947039

Based on question https://stackoverflow.com/questions/41947039 called
"Keras RNN with LSTM cells for predicting multiple output time series based 
on multiple input time series"
