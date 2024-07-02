Recently when learning SICP, I read [this code][1] which is the reference of [sicp-solutions][2] which is the reference of [schemewiki][3].

It has one equation in [this code part][4]:
$$
f(k,3)=\lfloor \frac{k}{10}\rfloor\cdot\lfloor \frac{k}{5}\rfloor-\lfloor \frac{k}{10}\rfloor^2+\lfloor \frac{k}{5}\rfloor+1
$$

I thought this equation can be easily derived using Arithmetic Progression (See the figure with green nodes in the above sicp-solutions for how this equation is derived):
$$
\begin{align*}
  f(k,3)&=\frac{[f(k,2)+f(k-10\cdot\lfloor \frac{k}{10}\rfloor,2)]\cdot(\lfloor \frac{k}{10}\rfloor+1)}{2}\\
  &=\frac{[(\lfloor \frac{k}{5}\rfloor+1)+(\lfloor \frac{k-10\cdot\lfloor \frac{k}{10}\rfloor}{5}\rfloor+1)]\cdot(\lfloor \frac{k}{10}\rfloor+1)}{2}
\end{align*}
$$

I have used codes to check the above 2nd equation. It should be equal to the 1st equation.

The difficult part is $\lfloor \frac{k}{10}\rfloor\cdot\lfloor \frac{k-10\cdot\lfloor \frac{k}{10}\rfloor}{5}\rfloor$. I don't know how to simplify such a *deep nested* floor equation.

---

Following peterwhy's hints. We let $k=10m+t$ and $q=\lfloor \frac{k-10\cdot\lfloor \frac{k}{10}\rfloor}{5}\rfloor$
Then we need to prove 
$$
\begin{align*}
&&2(\lfloor \frac{k}{10}\rfloor\cdot\lfloor \frac{k}{5}\rfloor-\lfloor \frac{k}{10}\rfloor^2+\lfloor \frac{k}{5}\rfloor+1)&=2+q+\lfloor \frac{k}{10}\rfloor\cdot\lfloor \frac{k}{5}\rfloor+(2+q)\lfloor \frac{k}{10}\rfloor+\lfloor \frac{k}{5}\rfloor\\
\Rightarrow&&\lfloor \frac{k}{10}\rfloor\cdot\lfloor \frac{k}{5}\rfloor-2\lfloor \frac{k}{10}\rfloor^2+\lfloor \frac{k}{5}\rfloor&=q+(2+q)\lfloor \frac{k}{10}\rfloor
\end{align*}
$$
1. $k\bmod 10<5\Rightarrow q=0$. Then we need to prove
  $$
  \begin{align*}
    m\cdot 2m-2m^2+2m=2m
  \end{align*}
  $$
  This trivially holds.
2. $k\bmod 10>=5\Rightarrow q=1$. Similar to the above
  $$
  \begin{align*}
    m\cdot (2m+1)-2m^2+2m+1&=1+(2+1)m
  \end{align*}
  $$
  This trivially holds again.

  [1]: https://github.com/sarabander/p2pu-sicp/blob/master/1.2/Ex1.14.scm
  [2]: https://sicp-solutions.net/post/sicp-solution-exercise-1-14/
  [3]: http://community.schemewiki.org/?sicp-ex-1.14
  [4]: https://github.com/sarabander/p2pu-sicp/blob/fbc49b67dac717da1487629fb2d7a7d86dfdbe32/1.2/Ex1.14.scm#L59-L63