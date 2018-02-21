---
layout: post
title: Langton's ant extended to Voronoi tessellations
published: true
---
<center><img src="../images/2016-12-11-Langton-Voronoi/intro.png" alt="Bounded evolution of the ant"/></center>
Langton's ant is a cellular automaton driven by a simple set of rules and running on a square lattice. It is one of the most simple system leading to an emergent behavior. In this post, the system is extended to run on any Voronoi tessellation of the plane. Simulations show interesting walks for some partitions of the plane, including chaotic structures, highway patterns and even bounded evolutions.




**Remind of classic Langton's ant**

Langton's ant runs on a square lattice. Initially, all cells are white and we place an ant on a square. At each step, the ant moves according to the following rules:

* If the cell is white or blue: Turn to the right, color current cell in red, and move forward;

* If the cell is red: Turn to the left, color current cell in blue, and move forward.

That's all! 
Here is the evolution of the ant from an initial configuration to step one:

<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_0_0.png" alt="step 0 of the classic Langton's ant" width="24%"/>
<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_0_1.png" alt="step 0 of the classic Langton's ant" width="24%"/>
<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_0_2.png" alt="step 0 of the classic Langton's ant" width="24%"/>
<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_1_0.png" alt="step 1 of the classic Langton's ant" width="24%"/>

And from step one to step two:

<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_1_0.png" alt="step 1 of the classic Langton's ant" width="24%"/>
<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_1_1.png" alt="step 1 of the classic Langton's ant" width="24%"/>
<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_1_2.png" alt="step 1 of the classic Langton's ant" width="24%"/>
<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_2_0.png" alt="step 2 of the classic Langton's ant" width="24%"/>

The ant goes round until reaching a red cell at step 4. At that step, the ant turns to the left:

<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_1_0.png" alt="step 1 of the classic Langton's ant" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_2_0.png" alt="step 2 of the classic Langton's ant" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_3_0.png" alt="step 2 of the classic Langton's ant" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_4_0.png" alt="step 2 of the classic Langton's ant" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/with_ant/iter_5_0.png" alt="step 2 of the classic Langton's ant" width="19%"/>

During the ten first steps, the ant draws a simple pattern: 

<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_1.png" alt="step 1 of the classic Langton's ant" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_2.png" alt="step 2 of the classic Langton's ant" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_3.png" alt="step 3 of the classic Langton's ant" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_4.png" alt="step 4 of the classic Langton's ant" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_5.png" alt="step 5 of the classic Langton's ant" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_6.png" alt="step 6 of the classic Langton's ant" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_7.png" alt="step 7 of the classic Langton's ant" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_8.png" alt="step 8 of the classic Langton's ant" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_9.png" alt="step 9 of the classic Langton's ant" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_10.png" alt="step 10 of the classic Langton's ant" width="9%"/>

The ant continues to draw symmetric or almost symmetric patterns during the first hundred steps. After step 500, the ant begins to adopt a chaotic behavior. The following pictures represent steps 10, 50, 100, 500 and 1000:

<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_10_smaller.png" alt="step 10 of the classic Langton's ant" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_50.png" alt="step 50 of the classic Langton's ant" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_100.png" alt="step 100 of the classic Langton's ant" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_500.png" alt="step 500 of the classic Langton's ant" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_1000.png" alt="step 1000 of the classic Langton's ant" width="19%"/>

This chaotic behavior continues during ten thousand steps. After that, the ant starts building a regular pattern of 104 steps called "highway" and walking to infinity. The following pictures represent steps 1000, 5000, 10000 and 11565:

<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_1000_smaller.png" alt="step 1000 of the classic Langton's ant" width="24%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_5000.png" alt="step 5000 of the classic Langton's ant" width="24%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_10000.png" alt="step 10000 of the classic Langton's ant" width="24%"/>
<img src="../images/2016-12-11-Langton-Voronoi/classic/iter_11566.png" alt="step 11565 of the classic Langton's ant" width="24%"/>

**Extension to Voronoi tesselations**

Given a finite set of points of the plane, we apply a <a href="https://en.wikipedia.org/wiki/Voronoi_diagram" target="_blank">Voronoi teselation</a> with Euclidian distance. We obtain a partition of this plane into convex polygonal cells.

Each cell can have a more than four edges, which means more possible directions. We define the following ones: backward (B), starboard (S), right (R), forward (F), left (L), and port (P). When the cell is a pentagon or an octagon, we obtain respectively:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="../images/2016-12-11-Langton-Voronoi/ink/5.svg" alt="Rule explanations on a pentagon" width="35%"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="../images/2016-12-11-Langton-Voronoi/ink/8.svg" alt="Rule explanations on an octagon" width="35%"/>

Here is the definition for a general polygon. Given previous cell and current cell, we obtain the direction of the ant (red arrow) and of the last edge crossed (bold edge). Relative to this direction, we number edges from 1 to E (where E is the number of edges of the current cell). B is edge 1; S is edge 2; R is the median edge minus one; F is only defined for even polygons and is the median edge; L is the median edge plus one; P is the last edge. 



For example, each cell of the classic Langton's ant is driven by alterning "going right" (R) and "going left" (L). We summarize this scheme using the word RL. Note that in this case, since each cell has four edges, the rules SP, RL, SR and SL are all identical.




**Nine trajectories for each rule**

For each simulation of a trajectory, we sample 5000 points in a unit square from uniform distribution; Obtain a Voronoi tessellation from them; Define an initial configuration of the ant; And compute evolution during 1000 steps (or until reaching a border of the area).

We plot 9 pictures for each rule SP, RL, SR and SL. Each picture represents the state after the evolution. Those pictures help to understand the different kind of behavior of the ant.

*Evolution with SP rule*

The ant circles forward and draws snake patterns. Cells where the ant has traveled are all in blue, except for the initial cell and for the last cells.

<img src="../images/2016-12-11-Langton-Voronoi/SP/5000_seed_10_1000.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SP/5000_seed_11_1000.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SP/5000_seed_23_1000.png" alt="1000 iterations with SP rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/SP/5000_seed_67_1000.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SP/5000_seed_57_1000.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SP/5000_seed_70_390.png" alt="1000 iterations with SP rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/SP/5000_seed_94_1000.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SP/5000_seed_88_1000.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SP/5000_seed_80_1000.png" alt="1000 iterations with SP rule" width="32%"/>

*Evolution with RL rule*

The ant initially makes circles and builds complex patterns (in red), before to backtrack a large part of the trajectory (in blue). This is caused by the symmetry between direction R and L, and can be shown through the large areas in red and blue.

<img src="../images/2016-12-11-Langton-Voronoi/RL/5000_seed_11_1000.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/RL/5000_seed_12_1000.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/RL/5000_seed_23_1000.png" alt="1000 iterations with RL rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/RL/5000_seed_66_1000.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/RL/5000_seed_100_1000.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/RL/5000_seed_67_1000.png" alt="1000 iterations with RL rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/RL/5000_seed_69_1000.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/RL/5000_seed_72_1000.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/RL/5000_seed_81_1000.png" alt="1000 iterations with RL rule" width="32%"/>

*Evolution with SR rule*

The ant really wants to turn to starboard, but makes a lot of chaotic circles, generally in an increasing area.

<img src="../images/2016-12-11-Langton-Voronoi/SR/5000_seed_7_1000.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SR/5000_seed_14_1000.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SR/5000_seed_27_1000.png" alt="1000 iterations with SR rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/SR/5000_seed_33_1000.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SR/5000_seed_57_1000.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SR/5000_seed_83_1000.png" alt="1000 iterations with SR rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/SR/5000_seed_84_1000.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SR/5000_seed_38_1000.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SR/5000_seed_96_1000.png" alt="1000 iterations with SR rule" width="32%"/>

*Evolution with SL rule*

The rule is asymmetric but keeps balance between moving to the left and to the right. Pictures show chaotic trajectories.

<img src="../images/2016-12-11-Langton-Voronoi/SL/5000_seed_1_1000.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SL/5000_seed_2_1000.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SL/5000_seed_3_1000.png" alt="1000 iterations with SL rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/SL/5000_seed_10_1000.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SL/5000_seed_14_1000.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SL/5000_seed_23_1000.png" alt="1000 iterations with SL rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/SL/5000_seed_72_1000.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SL/5000_seed_94_1000.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/SL/5000_seed_95_1000.png" alt="1000 iterations with SL rule" width="32%"/>

**Nine trajectories for each rule with translated tesselations**

To simulate regular tilings, we sample a limited number of points in a unit square, translate these points in all directions, and obtain a Voronoi tessellation from them. Then we proceed as in the last section. Trajectories exhibit three kinds of behavior: chaotic structures, highway patterns and bounded evolutions.

*Evolution with SP rule and a translated tesselation*

<img src="../images/2016-12-11-Langton-Voronoi/translated_SP/11_seed_1.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SP/11_seed_8.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SP/11_seed_12.png" alt="1000 iterations with SP rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/translated_SP/11_seed_25.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SP/12_seed_4.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SP/11_seed_38.png" alt="1000 iterations with SP rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/translated_SP/11_seed_74.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SP/11_seed_76.png" alt="1000 iterations with SP rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SP/11_seed_81.png" alt="1000 iterations with SP rule" width="32%"/>

*Evolution with RL rule and a translated tesselation*

<img src="../images/2016-12-11-Langton-Voronoi/translated_RL/11_seed_1.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_RL/11_seed_2.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_RL/11_seed_3.png" alt="1000 iterations with RL rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/translated_RL/11_seed_4.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_RL/11_seed_99.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_RL/11_seed_5.png" alt="1000 iterations with RL rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/translated_RL/11_seed_91.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_RL/11_seed_85.png" alt="1000 iterations with RL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_RL/11_seed_72.png" alt="1000 iterations with RL rule" width="32%"/>

*Evolution with SR rule and a translated tesselation*

<img src="../images/2016-12-11-Langton-Voronoi/translated_SR/11_seed_4.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SR/11_seed_19.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SR/11_seed_20.png" alt="1000 iterations with SR rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/translated_SR/11_seed_66.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SR/11_seed_54.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SR/11_seed_88.png" alt="1000 iterations with SR rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/translated_SR/11_seed_93.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SR/11_seed_67.png" alt="1000 iterations with SR rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SR/11_seed_73.png" alt="1000 iterations with SR rule" width="32%"/>

*Evolution with SL rule and a translated tesselation*

<img src="../images/2016-12-11-Langton-Voronoi/translated_SL/11_seed_2.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SL/11_seed_24.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SL/11_seed_41.png" alt="1000 iterations with SL rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/translated_SL/11_seed_39.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SL/11_seed_36.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SL/11_seed_49.png" alt="1000 iterations with SL rule" width="32%"/>

<img src="../images/2016-12-11-Langton-Voronoi/translated_SL/11_seed_96.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SL/11_seed_89.png" alt="1000 iterations with SL rule" width="32%"/>
<img src="../images/2016-12-11-Langton-Voronoi/translated_SL/11_seed_98.png" alt="1000 iterations with SL rule" width="32%"/>

**A bounded trajectory with a period of 48 steps**

After computing trajectories for a lot of tilings, we observe that some evolutions are bounded. 

The following example is the smallest bounded trajectory obtained until now with the rule SP. It has a period of 48 steps, so it is called "SP48". It can be reduced to a graph with 20 vertices, 30 edges and 12 faces... Maybe a dodecahedron?
Here are the 50 first steps from 1 to 50 (there are some small edges):

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_1.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_2.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_3.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_4.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_5.png" alt="Bounded with SP" width="19%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_6.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_7.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_8.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_9.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_10.png" alt="Bounded with SP" width="19%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_11.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_12.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_13.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_14.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_15.png" alt="Bounded with SP" width="19%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_16.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_17.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_18.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_19.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_20.png" alt="Bounded with SP" width="19%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_21.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_22.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_23.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_24.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_25.png" alt="Bounded with SP" width="19%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_26.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_27.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_28.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_29.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_30.png" alt="Bounded with SP" width="19%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_31.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_32.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_33.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_34.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_35.png" alt="Bounded with SP" width="19%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_36.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_37.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_38.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_39.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_40.png" alt="Bounded with SP" width="19%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_41.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_42.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_43.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_44.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_45.png" alt="Bounded with SP" width="19%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_46.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_47.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_48.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_49.png" alt="Bounded with SP" width="19%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_smaller/234_50.png" alt="Bounded with SP" width="19%"/>

I like the previous version of SP48 because some figures appear such as a turtle, a pelican and a dog (can you see them?). However, some edges are small to check. Here is a clear version of SP48.

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/1.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/2.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/3.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/4.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/5.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/6.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/7.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/8.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/9.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/10.png" alt="Bounded with SP" width="9%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/11.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/12.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/13.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/14.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/15.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/16.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/17.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/18.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/19.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/20.png" alt="Bounded with SP" width="9%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/21.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/22.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/23.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/24.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/25.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/26.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/27.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/28.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/29.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/30.png" alt="Bounded with SP" width="9%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/31.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/32.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/33.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/34.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/35.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/36.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/37.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/38.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/39.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/40.png" alt="Bounded with SP" width="9%"/>

<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/41.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/42.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/43.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/44.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/45.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/46.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/47.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/48.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/49.png" alt="Bounded with SP" width="9%"/>
<img src="../images/2016-12-11-Langton-Voronoi/bounded_SP_48_circled/50.png" alt="Bounded with SP" width="9%"/>

Some questions arise from this example: Can we get a number of steps lower than 48 for this rule? Can we get a bounded trajectory for all rules?

**Front cover images**

Front set of pictures shows a bounded trajectory describing a ring, computed with rule SP and plotted at steps 1, 10, 20, ..., 90, 100, 200, ..., 500.

**References**
- I discovered Langton's ant from <a href="https://www.youtube.com/watch?v=qZRYGxF6D3w" target="_blank">this nice video of David Louapre (in French)</a>
- Experience hexagonal Langton's ant online in <a href="https://brtmr.de/2015/10/05/hexadecimal-langtons-ant-2.html" target="_blank">this post of Bastian Reitemeier</a>. I took the same notations to name the directions.
- Code and outputs are available <a href="https://github.com/ahstat/langton-voronoi" target="_blank">on my github</a>
- <a href="https://en.wikipedia.org/wiki/Langton%27s_ant" target="_blank">Wikipedia page</a> describing Langton's ant and some extensions.