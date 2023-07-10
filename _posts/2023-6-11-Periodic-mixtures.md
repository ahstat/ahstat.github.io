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
<td align="center">$$\text{type}$$</td>
<td>$$~~~~~~~~~~~f_{\sigma}(x)~~~~~~~~~~~$$</td>
<td>$$~~~~~~~~~~~g_{\sigma}(x)~~~~~~~~~~~$$</td>
<td>$$~~~~~~~~~~~\mathcal{F}f_{\sigma}(\xi)~~~~~~~~~~~$$</td>
<td>$$~~~~~~~~~~~\mathcal{F}g_{\sigma}(\xi)~~~~~~~~~~~$$</td>
</tr>
<tr>
<td align="center">Linear</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/f/linear.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle \sigma^{-1} \left( 1- \frac{|x|}{\sigma} \right) \mathbf{1}_{|x| \leq \sigma}}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/g/linear.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle - \text{sign}(x) \frac{1}{\sigma^2} \mathbf{1}_{|x| \leq \sigma}}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱf/linear.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle \text{sinc}^2(\sigma \xi)}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱg/linear.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle 2\pi i \xi \text{sinc}^2(\sigma \xi)}$$</span></td>
</tr>
<tr>
<td align="center">Exponential</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/f/exponential.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle \frac{1}{2\sigma} e^{-\frac{|x|}{\sigma}}}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/g/exponential.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle - \text{sign}(x) \frac{1}{2 \sigma^2} e^{-\frac{|x|}{\sigma}}}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱf/exponential.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle \frac{1}{1 + \left( 2 \pi \sigma \xi \right)^2}}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱg/exponential.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle 2\pi i \xi \frac{1}{1 + \left( 2 \pi \sigma \xi \right)^2}}$$</span></td>
</tr>
<tr>
<td align="center">Polynomial</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/f/polynomial.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle \sigma^{-1} \pi^{-1} \frac{1}{1 + \left( x/\sigma \right) ^2}}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/g/polynomial.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle -2 \sigma^{-3} \pi^{-1} \frac{1}{\left( 1 + \left( x/\sigma \right)^2 \right)^2} x}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱf/polynomial.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle e^{-2\pi \sigma |\xi|}}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱg/polynomial.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle 2\pi i \xi e^{-2\pi \sigma |\xi|}}$$</span></td>
</tr>
<tr>
<td align="center">Gaussian</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/f/gaussian.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle \left( 2 \pi \right)^{-1/2} \sigma^{-1} e^{-\frac{x^2}{2\sigma^2}}}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/g/gaussian.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle - \left( 2 \pi \right)^{-1/2} \sigma^{-3} e^{-\frac{x^2}{2\sigma^2}} x}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱf/gaussian.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle e^{-\frac{(2 \pi \sigma \xi)^2}{2}}}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱg/gaussian.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle 2\pi i \xi e^{-\frac{(2 \pi \sigma \xi)^2}{2}}}$$</span></td>
</tr>
<tr>
<td align="center">Sinc</td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/f/sinc.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle \pi^{-1} x^{-1} \sin (x / \sigma)}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/g/sinc.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle \frac{x \cos \left(  x / \sigma \right) - \sigma \sin \left( x / \sigma \right)}{\sigma \pi x^{2} }}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱf/sinc.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle \mathbf{1}_{\xi \in \left[ -\frac{1}{2 \pi \sigma}, \frac{1}{2 \pi \sigma} \right]}}$$</span></td>
<td align="center"><img src="../images/2023-6-11-Periodic-mixtures/ℱg/sinc.png" alt="todo"/><span style="display:block; margin-top:-30px;">$${\scriptstyle 2 \pi i \xi \mathbf{1}_{\xi \in \left[ -\frac{1}{2 \pi \sigma}, \frac{1}{2 \pi \sigma} \right]}}$$</span></td>
</tr>
</tbody>
</table>







