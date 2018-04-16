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
and such that, for $$n \geq 4$$ (with $$N: x \mapsto \frac{x}{\| x \|}$$ where $$ \|.\|$$ is a norm):

$$x_{n} = x_{n-1} - N(x_{n-1} - x_{n-3}).$$

We would like to study how behaves this sequence for large $$n$$.


Except for the last part of this post, 
we select the Euclidian norm and identify the plane with the complex plane.

**Understanding the recurrence on an example**

We illustrate the first steps of the sequence when $$x_1=(0,0)$$, $$x_2=(1,0)$$, $$x_3=(1,1)$$.
The construction of $$x_4$$ is shown in Fig. 2.
This can be computed from the formula:

$$x_{4} = x_{3} - N(x_{3} - x_{1}) = (1,1) - N((1,1)) = (1 - 1/\sqrt{2}, 1 - 1/\sqrt{2}).$$

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/1.png" alt="step 1" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/1_begin.png" alt="step 1 to step 2" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/1_end.png" alt="step 2" width="31%"/>

*Fig. 2. Construction of $$x_4$$ from $$x_1$$ and $$x_3$$*

Next points $$x_5$$ and $$x_6$$ are more difficult to calculate from the formula, and we only provide the construction (Fig. 3 and 4).

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/2.png" alt="step 2" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/2_begin.png" alt="step 2 to step 3" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/2_end.png" alt="step 3" width="31%"/>

*Fig. 3. Construction of $$x_5$$ from $$x_2$$ and $$x_4$$*

<img src="../images/2017-6-11-Triangle-pursuit/intro_images/3.png" alt="step 3" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/3_begin.png" alt="step 3 to step 4" width="31%"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/3_end.png" alt="step 4" width="31%"/>

*Fig. 4. Construction of $$x_6$$ from $$x_3$$ and $$x_5$$*

After some steps, we obtain $$3$$ adherent points forming an equilateral triangle.
Initial and final steps are shown in Fig. 5.

<center>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/1.png" alt="step 1"/>
<img src="../images/2017-6-11-Triangle-pursuit/intro_images/14.png" alt="step 14"/>
</center>

*Fig. 5. Initial and final step*

Note that the sequence may be undefined for some initial triplets (for example when $$x_1 = x_2 = x_3$$).

**Reducing dimension of the problem**
 
Each triplet contains $$6$$ real parameters. We will show that we can reduce the *triangle pursuit* problem to $$1$$ parameter without loss of generality. Explicitly, our final parameter will be $$t \in (0, 2 \pi) \setminus \lbrace \pi \rbrace$$, related with triplet $$(x_1, x_2, x_3) = (0, 1, e^{it})$$.

***Applying rotation and translation***

Suppose that $$(x_n)_n$$ is well-defined from triplet $$(x_1, x_2, x_3)$$.
Let $$\theta \in [0, 2 \pi)$$ and $$b \in \mathbb{C}$$.
Let for $$k \in \lbrace 1, 2, 3 \rbrace$$:

$$x'_k := e^{-i \theta} (x_k - b).$$

Then, for $$k \in \lbrace 1, 2, 3 \rbrace$$, $$x_k = e^{i  \theta} x'_k + b$$
and 

$$x_4 = x_3 - N(x_3 - x_1) = e^{i  \theta} x'_3 + b - N(e^{i  \theta} x'_3 - e^{i  \theta} x'_1)$$.

Because $$N(.)$$ is defined with the Euclidian norm, we have:

$$x_4 = e^{i  \theta} x'_3 + b - e^{i  \theta} N( x'_3 - x'_1)
= e^{i  \theta} \left(x'_3 - N( x'_3 - x'_1) \right) + b$$

Since $$x_4$$ exists, $$x'_3 - N( x'_3 - x'_1)$$ exists and we define:
$$x'_4 := x'_3 - N( x'_3 - x'_1).$$

We can continue and define $$(x'_n)$$ such that for all $$n$$:

$$x'_n := e^{i \theta} x'_n + b.$$

***From 6 to 3 parameters***

Rotation and translation have released $$3$$ degree of freedom.


 From 6 to 1 parameter (with translation and rotation invariance)
 
 
 **Form for dimension 1**
 
 
 **Illustration with other norms**
 
 
Continue here






Remember to add illustration like that


<img src="../images/2017-6-11-Triangle-pursuit/illustration/rot_onenorm.png" alt="Illustration. Adherent points of rotated triangles, when norm one is used"/>

*Fig. 1. Illustration explained later in this post*
