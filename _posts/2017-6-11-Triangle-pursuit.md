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
and such that, for $$n \geq 4$$ (with $$N: x \mapsto \frac{x}{\| x \|}$$ and $$ \|.\|$$ the Euclidian norm):

$$x_{n} = x_{n-1} - N(x_{n-1} - x_{n-3}).$$

Note that sequence may be undefined for some initial triplets (for example when $$x_1 = x_2 = x_3$$).

<img src="../images/2017-6-11-Triangle-pursuit/illustration/rot_onenorm.png" alt="Illustration. Adherent points of rotated triangles, when norm one is used instead of Euclidian norm"/>


With $$x_1=(0,0)$$, $$x_2=(1,0)$$, $$x_3=(1,1)$$, construction of the first steps are illustrated on the following figures.

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/1.png" alt="step 1" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/1_begin.png" alt="step 1 to step 2" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/1_end.png" alt="step 2" width="31%"/>
*Computing $$x_4$$ from $$x_1$$ and $$x_3$$*

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/2.png" alt="step 2" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/2_begin.png" alt="step 2 to step 3" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/2_end.png" alt="step 3" width="31%"/>
*Computing $$x_5$$ from $$x_2$$ and $$x_4$$*

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/3.png" alt="step 3" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/3_begin.png" alt="step 3 to step 4" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/3_end.png" alt="step 4" width="31%"/>
*Computing $$x_6$$ from $$x_3$$ and $$x_5$$*

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/4.png" alt="step 4" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/4_begin.png" alt="step 4 to step 5" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/4_end.png" alt="step 5" width="31%"/>
*Computing $$x_7$$ from $$x_4$$ and $$x_6$$*

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/5.png" alt="step 5" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/5_begin.png" alt="step 5 to step 6" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/5_end.png" alt="step 6" width="31%"/>
*Computing $$x_8$$ from $$x_5$$ and $$x_7$$*




Continue here