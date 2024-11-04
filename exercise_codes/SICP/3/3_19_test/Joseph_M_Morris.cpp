// https://stackoverflow.com/a/791378/21294350 how is visit implemented?
// https://yuyuan.org/MorrisAlgorithm/ same problem as the 1st
// https://en.wikipedia.org/wiki/Threaded_binary_tree#Relation_to_parent_pointers only show parent func.

// IMHO all the above 3 are worse than https://www.geeksforgeeks.org/convert-binary-tree-threaded-binary-tree-2/#.
// i.e. convert-binary-tree-to-threaded.cpp
void Joseph_M_Morris(struct node * T)
{
  /* U1. [Initialize.] */
  P = T;
  R = 0;

  while (P) { /* U2. [Done?] */
    while (1) {
      /* U3. [Look left.] */
      Q = P->L;
      if (Q == 0) {
        // visit(P, preorder);
        break; /* goto U6; */
      }

      /* U4. [Search for thread.] */
      while (Q != R && Q->R != 0)
        Q = Q->R;
      assert(Q == R || Q->R == 0);

      /* U5. [Insert or remove thread.] */
      if (Q != R) {
        // G->C case
        Q->R = P;
      } else {
        Q->R = 0;
        break;
      }

      /* U8. [Preorder visit.] */
      // visit(P, preorder);

      /* U9. [Go to left.] */
      P = P->L;
      /* goto U3 */
    }

    /* U6. [Inorder visit.] */
    // visit(P, inorder);

    /* U7. [Go to right or up.] */
    R = P;
    P = P->R;
    /* goto U2 */
  }
}
