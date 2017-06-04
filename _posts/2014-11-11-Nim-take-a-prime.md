---
layout: post
title: Nim function for take-a-prime game
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>
The *Nim function for take-a-prime game* is a math sequence with interesting patterns. 
We define this sequence $$(u_n)$$ recursively. For all $$n$$ in $$\mathbb{N}$$ (the set of non-negative integers), $$u_n$$ is the lowest number in $$\mathbb{N}$$ such that for all prime number $$p$$ (with $$n-p \geq 0$$), $$u_n \neq u_{n-p}$$.

<center><img src="../images/2014-11-11-Nim-take-a-prime/sequence_firsts.png" alt="first elements of the sequence"/></center>



To understand this definition, we detail how to compute the first terms. For $$n=0$$, no prime number verifies $$n-p \geq 0$$, then $$u_n$$ is the lowest number in $$\mathbb{N}$$ and $$u_0=0$$. We get the same for $$n=1$$ and get $$u_1=0$$.

For $$n=2$$, the only prime number $$p$$ which verifies $$n-p \geq 0$$ is $$p=2$$. Then, the condition means that we have to find the lowest number in $$\mathbb{N}$$ which is different from $$u_{n¨Cp} = u_{2¨C2} = u_0 = 0$$. We finally select $$u_2=1$$.

For $$n=3$$, $$u_3$$ has to differ from $$u_{3-2}=0$$ and $$u_{3-3}=0$$, then $$u_3=1$$.

For $$n=4$$, $$u_4$$ has to differ from $$u_{4-2}=1$$ and $$u_{4-3}=0$$, then $$u_4=2$$.

