---
layout: post
title: Trigger snake
published: true
---

*Trigger snake* is a snake game introducing new features making it fast, lively and challenging. You can <a href="https://github.com/ahstat/trigger-snake/raw/master/release/trigger-snake_win8.zip">download it here (Windows 8)</a>, or compile <a href="https://github.com/ahstat/trigger-snake">C++/Qt4 sources yourself</a>. Graphical statistics are available in-game and highlight player's behavior, for example by showing preference to some regions or directions.

<center><img src="../images/2014-10-11-Trigger-snake/snake_intro.png" alt="introduction picture of the game"/></center>



Snake is a game concept where player controls a line which increases in size when eating scoring elements. Usually, the line represents a snake and scoring elements are apples. Player loses game when snake hits its own tail. Many versions exist of this classic game, for example Nokia developed a popular version in 1997.

Concept is great, however two drawbacks are recurrent in most versions:
<ul>
<li>
Most of apples do not reward player for quickness. Consequently, a player is not encouraged to consider the torus topology of the board.
</li>
<li>
Gameplay becomes repetitive when the snake has reached a large length. In that case, player must zigzag for a long time, which has nothing fun;
</li>
</ul>

In *trigger snake*, the game is kept as simple as possible without introducing fancy gameplay elements. We only add a few features to make the game fast and challenging: Reward for speed, and score limit.

**Reward for speed.**
There is a reward for speed. The apple appears fresh and green, yielding potentially 100 points. Then, apple begins to fade away, and score slowly decreases. After a while, apple eventually turn into a gray shape making only 1 point. This behavior encourages player to take the shortest path on the torus.
<center><img src="../images/2014-10-11-Trigger-snake/fade_apple.png" alt="apple fading with time"/>
</center>
<center><em>Apple fading away, from 100 points to 1 point</em></center>

**Score limit.**
The game stops after reaching a score of 3000. This usually prevents the snake to have an unreasonable length. We offer bonus for this performance, based on two components: How much time it took? How many apples have been eaten? If the game was quick enough, final score can attain 15000 or 16000.

<center><img src="../images/2014-10-11-Trigger-snake/end2.png" alt="end of game after winning"/>
</center>
*End of the game after winning*

**In-game pictures.**
Here are two screenshots of the game.

<center><img src="../images/2014-10-11-Trigger-snake/ingame.png" alt="in game picture"/>
</center>
*Screenshot of game during a play*

<center><img src="../images/2014-10-11-Trigger-snake/lose.png" alt="losing picture"/>
</center>
*Screenshot of game after losing*

**Statistic components.**

<center><img src="../images/2014-10-11-Trigger-snake/end_d.png" alt="snake's density"/>
</center>

<center><img src="../images/2014-10-11-Trigger-snake/end_e.png" alt="edges' density"/>
</center>

<center><img src="../images/2014-10-11-Trigger-snake/end_ne.png" alt="non-oriented edges' density"/>
</center>

<center><img src="../images/2014-10-11-Trigger-snake/end_a.png" alt="apple's density"/>
</center>


**Sources**

About programmation and sources






The game can be <a href="https://github.com/ahstat/trigger-snake/blob/master/release/trigger-snake_win8.zip">downloaded here for Windows</a>. If you are interested in the source code, follow <a href="https://github.com/ahstat/trigger-snake">this github link</a>. The game was made with C++/Qt4, so you can compile code to run it with Linux.

