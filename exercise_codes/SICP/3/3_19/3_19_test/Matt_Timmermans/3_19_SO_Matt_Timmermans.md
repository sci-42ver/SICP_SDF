```
  root
   \  
    0
   / \
  1   2
 /\   /\
3  4  5 6
     /\
    7  8

becomes (here we do Level 1 part):
(rsl means self-loop by making right ptr pointing to itself)

  root
   \  
    0
   / \
  1   2
 /\   /\
3  4  5 6(rsl)
     /\
    7  8

Then we do Level n for n=1, but root has no left child. So do nothing.
Then Level n for n=2. Only one node (node 0) is needed to be process.
then (rp1 means right ptr points to 1)

  root
   \  
    0
   / \---------\
  1             2
 /\             /\
/  \           /  \
3  4(rsl)      5    6(rp1)
             /\
            7  8

Then Level n for n=3. Left first, so node 1.
then

  root
   \  
    0
   / \-------------\
  1                 2
 / \---\           /\
/       \         /  \
3(rsl)  4(rp3)   5    6(rp1)
                /\
               7  8

Then node 2.
then

  root
   \  
    0
   / \-------------\
  1                 2
 / \---\           /\
/       \         /  \
3(rp5)  4(rp3)   5    6(rp1)
                /\
               7  8(rsl)

Then node 3,4(all skipped),5.

  root
   \  
    0
   / \-------------\
  1                 2
 / \---\           /\
/       \         /  \
3(rp5)  4(rp3)   5    6(rp1)
                / \---\
               7(rsl)  8(rp7)

Then node 6(skipped),7,8(all skipped).
```