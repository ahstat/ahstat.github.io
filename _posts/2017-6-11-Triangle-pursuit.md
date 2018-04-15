---
layout: post
title: Triangle pursuit
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>
Let $$x_1, x_2, x_3$$ be three points in a plane.
We define $$x_4$$ the point on the ray $$[x_3 x_1)$$ located at a distance $$1$$ of $$x_3$$.
It is as $$x_1$$ has been attracted to $$x_3$$ but kept at distance.
We continue by defining $$x_5$$ the point on the ray $$[x_4 x_2)$$ located at a distance $$1$$ of $$x_4$$.

On the whole, we define from $$(x_1, x_2, x_3)$$ a recurrent sequence taking values in $$\mathbb{R}^2$$
and such that, for $$n \geq 4$$,

$$x_{n} = x_{n-1} - N(x_{n-1} - x_{n-3})$$


with $$N: x \mapsto \frac{x}{\left| \left| x \right| \right| }$$

and $$ \left| \left| . \right| \right|$$ the Euclidian norm.

For example, with $$x_1=(0,0), x_2=(1,0), x_3=(1,1)$$, first steps are illustrated on the following figure.

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/1.png" alt="step 1" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/1_arrow.png" alt="step 1 with arrow" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/2.png" alt="step 2" width="31%"/>



<img src="../images/2017-6-11-Triangle-pursuit/intro_images/2.png" alt="step 2" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/2_arrow.png" alt="step 2 with arrow" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/3.png" alt="step 3" width="31%"/>

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/3.png" alt="step 3" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/3_arrow.png" alt="step 3 with arrow" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/4.png" alt="step 4" width="31%"/>

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/4.png" alt="step 4" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/4_arrow.png" alt="step 4 with arrow" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/5.png" alt="step 5" width="31%"/>

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/6.png" alt="step 6" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/7.png" alt="step 7" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/8.png" alt="step 8" width="31%"/>

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/9.png" alt="step 9" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/10.png" alt="step 10" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/11.png" alt="step 11" width="31%"/>

Note that sequence may be undefined for some initial triplets (for example when $$x_1 = x_2 = x_3$$).




Continue here