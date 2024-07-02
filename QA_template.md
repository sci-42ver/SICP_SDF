I am reading SICP. I first read CS 61AS Unit 0 as the preparation. Then I read SICP book and related lecture notes (I will also read SDF as MIT 6.5151 (6.905) requires).

CS 61AS [says in 0.1][1]
> Why is and a special form? Because it evaluates its arguments and *stops as soon as it can*, returning false *as soon as any argument evaluates to false*.

Thanks. With more info, I understood your method. More detailedly, following "the substitution method", 
$$
\begin{align*}
  D(n)&=2(2(\ldots(2D(1)+1+\delta_{(n>>\lfloor\log n-1\rfloor)\equiv_2 1})+\ldots)\\
      &=2^{\lfloor\log n\rfloor}D(1)+\overbrace{2^{\lfloor\log n\rfloor}-1}^{\text{accumulate 1 in }D(n)}+\overbrace{n-2^{\lfloor\log n\rfloor}}^{\text{accumulate }\delta}\\
      &=2^{\lfloor\log n\rfloor}-1+n.
\end{align*}
$$

---

Q: The accuracy of Newton’s method when favorable cases

When learning SICP, it says in [section 1.3.4 footnote 62][1]:
> Newton's method does not always converge to an answer, but it can be shown that *in favorable cases* each iteration *doubles the number-of-digits accuracy* of the approximation to the solution. In such cases, Newton's method will converge much more rapidly than the half-interval method.

But as [libretexts][2] says in


  [1]: https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-12.html#footnote_Temp_118
  [2]: https://math.libretexts.org/Bookshelves/Calculus/CLP-1_Differential_Calculus_(Feldman_Rechnitzer_and_Yeager)/06%3A_Appendix/6.03%3A_C-_Root_Finding/6.3.02%3A_C.2_The_Error_Behaviour_of_Newton's_Method