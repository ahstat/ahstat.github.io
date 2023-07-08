---
layout: post
title: Periodic mixtures
published: true
---
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

Period mixtures (draft)



f

<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td align="right">type</td>
<td>$$~~~~~~~~~~~f_{\sigma}(x)~~~~~~~~~~~$$</td>
<td>$$~~~~~~~~~~~g_{\sigma}(x)~~~~~~~~~~~$$</td>
<td>$$~~~~~~~~~~~\mathcal{F}f_{\sigma}(\xi)~~~~~~~~~~~$$</td>
<td>$$~~~~~~~~~~~\mathcal{F}g_{\sigma}(\xi)~~~~~~~~~~~$$</td>
</tr>
<tr>
<td align="right">$$\text{Linear}$$</td>
<td align="center">$${\scriptstyle \sigma^{-1} \left( 1- \frac{|x|}{\sigma} \right) \mathbf{1}_{|x| \leq \sigma}}$$<img src="../images/2023-6-11-Periodic-mixtures/f/linear.png" alt="todo"/></td>
<td align="center">$${\scriptstyle - \text{sign}(x) \frac{1}{\sigma^2} \mathbf{1}_{|x| \leq \sigma}}$$<img src="../images/2023-6-11-Periodic-mixtures/g/linear.png" alt="todo"/></td>
<td align="center">$${\scriptstyle \text{sinc}^2(\sigma \xi)}$$<img src="../images/2023-6-11-Periodic-mixtures/ℱf/linear.png" alt="todo"/></td>
<td align="center">$${\scriptstyle 2\pi i \xi \text{sinc}^2(\sigma \xi)}$$ <img src="../images/2023-6-11-Periodic-mixtures/ℱg/linear.png" alt="todo"/></td>
</tr>
<tr>
<td align="right">$$\text{Exponential}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/f/exponential.png" alt="todo"/><br/>$${\scriptstyle \frac{1}{2\sigma} e^{-\frac{|x|}{\sigma}}}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/g/exponential.png" alt="todo"/><br/>$${\scriptstyle - \text{sign}(x) \frac{1}{2 \sigma^2} e^{-\frac{|x|}{\sigma}}}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱf/exponential.png" alt="todo"/><br/>$${\scriptstyle \frac{1}{1 + \left( 2 \pi \sigma \xi \right)^2}}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱg/exponential.png" alt="todo"/><br/>$${\scriptstyle 2\pi i \xi \frac{1}{1 + \left( 2 \pi \sigma \xi \right)^2}}$$</td>
</tr>
<tr>
<td align="right">$$\text{Polynomial}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/f/polynomial.png" alt="todo"/><br/>$${\scriptstyle \sigma^{-1} \pi^{-1} \frac{1}{1 + \left( x/\sigma \right) ^2}}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/g/polynomial.png" alt="todo"/><br/>$${\scriptstyle -2 \sigma^{-3} \pi^{-1} \frac{1}{\left( 1 + \left( x/\sigma \right)^2 \right)^2} x}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱf/polynomial.png" alt="todo"/><br/>$${\scriptstyle e^{-2\pi \sigma |\xi|}}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱg/polynomial.png" alt="todo"/><br/>$${\scriptstyle 2\pi i \xi e^{-2\pi \sigma |\xi|}}$$</td>
</tr>
<tr>
<td align="right">$$\text{Gaussian}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/f/gaussian.png" alt="todo"/><br/>$${\scriptstyle \left( 2 \pi \right)^{-1/2} \sigma^{-1} e^{-\frac{x^2}{2\sigma^2}}}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/g/gaussian.png" alt="todo"/><br/>$${\scriptstyle - \left( 2 \pi \right)^{-1/2} \sigma^{-3} e^{-\frac{x^2}{2\sigma^2}} x}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱf/gaussian.png" alt="todo"/><br/>$${\scriptstyle e^{-\frac{(2 \pi \sigma \xi)^2}{2}}}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱg/gaussian.png" alt="todo"/><br/>$${\scriptstyle 2\pi i \xi e^{-\frac{(2 \pi \sigma \xi)^2}{2}}}$$</td>
</tr>
<tr>
<td align="right">$$\text{Sinc}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/f/sinc.png" alt="todo"/><br/>$${\scriptstyle \pi^{-1} x^{-1} \sin (x / \sigma)}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/g/sinc.png" alt="todo"/><br/>$${\scriptstyle \frac{x \cos \left(  x / \sigma \right) - \sigma \sin \left( x / \sigma \right)}{\sigma \pi x^{2} }}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱf/sinc.png" alt="todo"/><br/>$${\scriptstyle \mathbf{1}_{\xi \in \left[ -\frac{1}{2 \pi \sigma}, \frac{1}{2 \pi \sigma} \right]}}$$</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱg/sinc.png" alt="todo"/><br/>$${\scriptstyle 2 \pi i \xi \mathbf{1}_{\xi \in \left[ -\frac{1}{2 \pi \sigma}, \frac{1}{2 \pi \sigma} \right]}}$$</td>
</tr>
</tbody>
</table>







