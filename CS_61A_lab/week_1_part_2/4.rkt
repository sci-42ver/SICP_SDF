;;; I have one naive idea by allocating one new list where we will check whether the term to add has been added. 
;;; But the time complexity will be O(1+2+...+n)=O(n^2).

;;; https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week1 uses `member?` which may have the same complexity as the above.