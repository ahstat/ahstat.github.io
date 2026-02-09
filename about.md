---
layout: page
title: About
permalink: /about/
---

I'm Alexis Huet. [I got a PhD in mathematics](https://www.theses.fr/2014LYO10126) in 2014 from the University of Lyon, France (after passing the [agrégation de mathématiques](https://en.wikipedia.org/wiki/Agr%C3%A9gation) in 2009). I work in data science, and have been at Huawei since 2018, after three years in Nanjing. I primarily code in Python ![]({{site.baseurl}}/images/Python_logo.png) and R ![]({{site.baseurl}}/images/R_logo.png). On this site, I write detailed posts about maths, machine learning, and some of my own projects.

### Contact me

alexis.huet.phd@gmail.com

### Profiles

[Google Scholar](https://scholar.google.com/citations?user=l31QllYAAAAJ) • [LinkedIn](https://fr.linkedin.com/in/ahstat) • [GitHub](https://github.com/ahstat) • [X](https://x.com/ahstat)

### Reviewing

**Conferences**: KDD (2024–2026, Excellence Award), ICLR (2025-2026), ACML (2024-2025), CIKM (2025)

**Journals**: IEEE TPAMI, ACM TKDD, IEEE TNSM, Springer Machine Learning

### Invited talks

- Keynote, XTempLLMs Workshop @ COLM 2025

### Patents

- 15+ patents filed

### 语言

除了法语和英语，我也在学中文，通过了HSK五级。[这是最近在INALCO课上的一个分享]({{site.baseurl}}/images/短剧.pdf)。

### Selected publications

These are some papers I enjoyed writing. I like when other researchers use the algorithms, benchmarks, or metrics we built, and take them further. I care most about methodological aspects, metrics, and evaluation.

<h4 style="margin-bottom: 0">Episodic memory generation and evaluation benchmark for large language models</h4>
(ICLR 2025) • [[paper]]({{site.baseurl}}/images/2025-llm1-iclr-paper.pdf) • [[poster]]({{site.baseurl}}/images/2025-llm1-iclr-poster.png) • [[code]](https://github.com/ahstat/episodic-memory-benchmark)

A benchmark for evaluating episodic memory in long-context LLMs. Questions require retrieving multiple events across chapters, for example all entities seen at a given location. I enjoyed the modeling of events as (time, space, entity, content) tuples and the metric design. For the broader vision connecting episodic memory to computational neuroscience, see [Zied's home page](https://bendiogene.github.io).

<h4 style="margin-bottom: 0">Changepoint detection via subset chains</h4>
(PAKDD 2025) • [[paper]]({{site.baseurl}}/images/2025-anomaly8-pakdd-paper.pdf) • [[presentation]]({{site.baseurl}}/images/2025-anomaly8-pakdd-presentation.pdf) • [[code]](https://github.com/ahstat/scoth-segmentation)

A method for detecting change points in time series at multiple levels of granularity. Existing methods require setting a threshold or penalty that is hard to choose well. The idea here is to split the problem in two: first score every point by how important it is as a potential change, then threshold recursively to reveal changes level by level, from major to minor. This also matches how humans see it: different annotators label different levels of detail, and each finds a level that fits.

<h4 style="margin-bottom: 0">Local evaluation of time series anomaly detection algorithms</h4>
(KDD 2022) • [[paper]]({{site.baseurl}}/images/2022-anomaly1-kdd-paper.pdf) • [[poster]]({{site.baseurl}}/images/2022-anomaly1-kdd-poster.pdf) • [[code]](https://github.com/ahstat/affiliation-metrics-py)

A parameter-free metric for evaluating time series anomaly detection algorithms. Each ground truth event gets its own precision and recall with interpretable distances, which makes it easy to visualize what the detector actually got right or wrong. The metric verifies theoretical properties that ensure discriminative ranking between algorithms (that can be tested e.g. with [autorank](https://github.com/sherbold/autorank)).

<h4 style="margin-bottom: 0">Web QoE from encrypted traffic</h4>
(IFIP Networking 2020, IEEE TNSM 2021) • [[paper]]({{site.baseurl}}/images/2020-qoe5-networking-paper.pdf) • [[poster]]({{site.baseurl}}/images/2019-qoe2-sigcomm-poster.pdf) • [[demo]](https://huawei-webqoe.shinyapps.io/sigcommdemo)

A way to estimate web browsing quality from encrypted traffic, building on the Byte Index metric introduced in [Bocchi et al., 2016](https://webqoe.telecom-paristech.fr/metrics/). An interesting feature is that the session-level Byte Index decomposes exactly into per-flow contributions (proof in the journal version), enabling routers to compute it online from simple operations.



<!--
### Q/A on Stackoverflow

- [Keras RNN with LSTM cells for predicting multiple output time series based on multiple intput time series](https://stackoverflow.com/questions/41947039/keras-rnn-with-lstm-cells-for-predicting-multiple-output-time-series-based-on-mu/48521460#48521460) (answer)
- [Good accuracy despite high loss value](https://stats.stackexchange.com/questions/258166/good-accuracy-despite-high-loss-value/281651#281651) (answer)
- [Clustering as dimensionality reduction](https://stats.stackexchange.com/questions/288668/clustering-as-dimensionality-reduction) (question)
- [Remove anti-aliasing for pandas plot.area](https://stackoverflow.com/questions/44612797/remove-anti-aliasing-for-pandas-plot-area) (question)

I code in R ![]({{site.baseurl}}/images/R_logo.png) and Python ![]({{site.baseurl}}/images/Python_logo.png), sometimes in Javascript ![]({{site.baseurl}}/images/Javascript_logo.png) and C++ ![]({{site.baseurl}}/images/Cpp_logo.png).

-->

### Posts about deep learning

- [RNN with Keras: Predicting time series](https://ahstat.github.io/RNN-Keras-time-series/) ![]({{site.baseurl}}/images/Python_logo.png) Complete introduction of time series prediction with RNN. This tutorial has been written for answering a [stackoverflow post](https://stackoverflow.com/questions/41947039/keras-rnn-with-lstm-cells-for-predicting-multiple-output-time-series-based-on-mu/48521460#48521460), and has been used later [in a real-world context](https://stackoverflow.com/questions/48929272/non-linear-multivariate-time-series-response-prediction-using-rnn/49666510#49666510).

- [RNN with Keras: Understanding computations](https://ahstat.github.io/RNN-Keras-understanding-computations/) ![]({{site.baseurl}}/images/Python_logo.png) Highlights structure of common RNN algorithms by following computations carried out by each model. It provides a clear summary of command lines, math equations and diagrams.

### Posts about maths in data science

- [Optimizing GMM parameters using EM](https://ahstat.github.io/Optimizing-GMM-using-EM/). Description of GMM; How to update parameters using EM; Illustration on a simple example. Unlike many other sources, I fully detail parameters' update using gradient and Hessian.

- [Rediscover EM algorithm from scratch](https://ahstat.github.io/Rediscover-EM-algorithm/). Many introductions of EM exist on the web. This one starts from the likelihood computation problem and uses inductive reasoning to bring out EM.

- [Computation of the gradient for SNE](https://ahstat.github.io/Gradient-for-SNE/). Deriving gradient of the SNE algorithm, fully detailed.

- [An illustration of Metropolis–Hastings algorithm](https://ahstat.github.io/Metropolis-Hastings-example/). Toy example for understanding Metropolis–Hastings algorithm on a simple example.

- [Maximizing likelihood is equivalent to minimizing KL-divergence](https://ahstat.github.io/Kullback-Leibler-divergence/). Restating this classic equivalence in my "own" words.

- [Introduction to particle filters](https://github.com/ahstat/introduction-particle-filters) ![]({{site.baseurl}}/images/R_logo.png) Introduction to particle filters, with an homemade example of trajectory tracking.

- [Introduction to hidden Markov models](https://github.com/ahstat/introduction-hmm) ![]({{site.baseurl}}/images/R_logo.png) Introduction to hidden Markov models on finite state spaces, following the tutorial of L. R. Rabiner.

### Own projects

- [Langton's ant extended to Voronoi tessellations](https://ahstat.github.io/Langton-Voronoi/) ![]({{site.baseurl}}/images/R_logo.png) A program extending Langton's ant to any Voronoi tessellation of the plane. Simulations show interesting walks for some partitions of the plane, including chaotic structures, highway patterns and even bounded evolutions.

- [Anabasis webapp](https://ahstat.github.io/Anabasis/) ![]({{site.baseurl}}/images/Javascript_logo.png) Webapp where players can draw collaborative paintings. It was built with node.js combined with mongodb, and hosted on Heroku and MLab. Analysis of collected data is also available [in this post](https://ahstat.github.io/Clickstream/).

- [Trigger snake](https://ahstat.github.io/Trigger-snake/) ![]({{site.baseurl}}/images/Cpp_logo.png) A challenging snake game built in C++/Qt4

- [Nim function for take-a-prime game](https://ahstat.github.io/Nim-take-a-prime/) ![]({{site.baseurl}}/images/Python_logo.png) Simulation of a recursive math sequence with interesting patterns, accelerated using C++ language.

- [Coal: Composition of Linear Functions](https://ahstat.github.io/Coal/) ![]({{site.baseurl}}/images/R_logo.png) A program for automating composition of linear functions. `gmp` package has been used to keep exact results for big rational numbers.

- [Triangle pursuit](https://ahstat.github.io/Triangle-pursuit/) ![]({{site.baseurl}}/images/R_logo.png) A program computing recurrent sequences, offering generalization for different rules, different norms, larger number of initial points and higher dimensions.

- [Gender of French nouns](https://ahstat.github.io/Gender-french-nouns/) ![]({{site.baseurl}}/images/R_logo.png) Check out the distribution of the gender of French nouns across the letters.

- [Description and modeling of FlapMMO score data](https://ahstat.github.io/Flap-mmo/) ![]({{site.baseurl}}/images/R_logo.png) FlapMMO is an online game similar to Flappy Bird. This post explores a collected dataset of scores, using descriptive statistics and testing probabilistic models.

- [Watering and draining planets](https://ahstat.github.io/Topography/) ![]({{site.baseurl}}/images/R_logo.png) And what would be the Moon, Mars and Venus with as much water in proportion as on the Earth?

- [An enigma](https://ahstat.github.io/Enigme/) Could you find the missing symbol?

