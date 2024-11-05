Think about one example (just random...)
```
root
  /\
 1  2
  \  /\
  4 5 root
  /\
  6 7
    /\
   8  9
```

- `init(pRoot);`
  root->root
  parent = null;
  current = root;
- `findNodeWithLeftSubtree()`
  turtle=null
- `findSubtree`
  top->1
  bottom=4
  turtle = 1;
  - bottom == turtle
    i.e. from root step 1 for turtle and hare.
  - bottom=9 ~~(leaf so not further)~~
  - turtle=4
- `moveSubtree`
  TODO why `root == current, parent != null`
  root=1
  - `bottom->right = current;` i.e. threaded
  - TODO why `bottom->right = current;` not root
  current=1
```
 1*  
  \ 
  4* 
  /\
  6 7*
    /\
   8  9*
       \
       root
         \
          2
         / \
        5   root
```
- `findNodeWithLeftSubtree()`
  turtle=null (reset)
  parent=1
  current=4
  parent=4
  current=7
  turtle=1
- `findSubtree`
  top=8
  bottom=8
  - TODO why `top->right == null`
- `moveSubtree`
  current=8
```
 1*  
  \ 
  4* 
  /\
  6 8*
     \
      7*
       \
        9*
        \
       root
         \
          2
         / \
        5   root
```
- `findNodeWithLeftSubtree`
  turtle=4
  parent=8
  current=7
  parent=7
  current=9
  turtle=8
  - TODO why check 8 with 9 which are 2 bracnes of 7 in original version.
  (next iteration)
  parent=9
  current=root
  parent=root
  current=2
  <!-- turtle=7
  parent=2
  current=root
  parent=root
  current=2
  turtle=9
  ...
  turtle=2 -->
...
```
 1*  
  \ 
  4* 
  /\
  6 8* ; 6 is skipped...
     \
      7*
       \
        9*
        \
       root
         \
          5
           \
            2
             \
             root
```

```
 ...                        n0p
  \                           \
  n0            ---->         s0
  / \                         /\
 s0 S1                       .....
 /\                             /\
.....                         ... s0'
   / \                           /  \
 ...  s0'                      ...   n0
     /                                \
    ...                                S1

# TR is
 ...
  \
  n0
``` 