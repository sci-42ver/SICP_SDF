// Maybe related with 'can one tree with "cycle" become Threaded binary tree' but no related links...
// https://stackoverflow.com/q/79155452/21294350
// https://stackoverflow.com/a/7383418/21294350
#include <cstdio>
#include <iostream>
#include <queue>
#include <cmath>

#define null NULL
#define int32 int

using namespace std;

/**
 *	Binary tree node class
 **/

template <class T>
class Node
{

  public:

    /*	Public Attributes	*/

    Node* left;
    Node* right;
    T value;

};

/**
 *	This exception is thrown when the flattener & cycle detector algorithm encounters a cycle
 **/

class CycleException
{

  public:

    /*	Public Constructors	*/

    CycleException () {}
    virtual ~CycleException () {}

};

/**
 *	Biny tree flattener and cycle detector class.
 **/

template <class T>
class Flattener
{

  public:

    /*	Public Constructors	*/

    Flattener () :
      root (null),
      parent (null),
      current (null),
      top (null),
      bottom (null),
      turtle (null)
  {}

    virtual ~Flattener () {}

    /*	Public Methods	*/

    /**
     *	This function flattens an alleged binary tree, throwing a new CycleException when encountering a cycle. Returns the root of the flattened tree.
     **/

    Node<T>* flatten (Node<T>* pRoot)
    {
      init(pRoot);
      //	Loop while there are left subtrees to process
      while( findNodeWithLeftSubtree() ){
        //	We need to find the topmost and rightmost node of the subtree
        findSubtree();
        //	Move the entire subtree above the current node
        moveSubtree();
      }
      //	There are no more left subtrees to process, we are finished, the tree does not contain cycles
      return root;
    }

  protected:

    /*	Protected Methods	*/

    void init (Node<T>* pRoot)
    {
      //	Keep track of the root node so the tree is not lost
      root = pRoot;
      //	Keep track of the parent of the current node since it is needed for insertions
      parent = null;
      //	Keep track of the current node, obviously it is needed
      current = root;
    }

    bool findNodeWithLeftSubtree ()
    {
      //	Find a node with a left subtree using Floyd's cycle detection algorithm

      // added:
      // When parent is not null, parent==current means
      // 1. current is parent's child
      // 2. parent is current's rightmost child.
      // So both imply Cycle.
      turtle = parent;
      bool hare_walk_2_steps = true;
      // 0. Here we can assume current->left == null, if not then we will move left subtree above the current. Then keep this process.
      // 1. if current->right == null, then it should be visited last when inorder. So again "move left subtree" and check that subtree.
      // 2. if parent is root and current is added subtree top, the ancestor relation implies fine to check cycle for them although they may have no hare-turtle relation.
      // 2.a Then when hare walks 2 steps, 
      // hare and turtle are similar to starting from root.
      // Assume root,root1,root10,root101,root1011 where 0,1 means left,right.
      // Then after first iteration in flatten, root10 part is added above root1.
      // (turtle,hare)=(root1,root10) is checked when findSubtree
      // (turtle,hare)=(root10,root1011) is checked here at the 2nd while iteration.
      // Then the rest hare-turtle relation is implied by while loop logic.
      // 3. Similar to findSubtree but here we add current->left == null
      // Then we additionally skip one condition current->left != null and current->right != null
      // That case current
      // 4. The original version may have (null,0), (0,2), (1,4) sequence for (turtle,hare).

      // comments for Modified version:
      // 0. if all 2 steps work fine, then (1,2)...
      // 0.0 if hare walks only 1 step, then either leaf (can't have cycle) or with left subtree.
      // Then (turtle,hare) starting from parent can be checked similar to the above "root,root1,root10,root101,root1011".
      // 1. If no cycle, then when all left subtrees are moved, we will must reach the end leaf.
      // 2. If cycle, 
      // 3. Each time, current has 4 cases:
      // LR (means have both left and right branches): move left subtree
      // Lr: same as LR
      // lr: finish
      // lR: walk one step.
      // Here lR matters.
      // So if only 1 step is walked for turtle, then we either finish (have transformed into one totally "right slanted" tree) or change the structure and retry.
      // 
      while( current->left == null and current->right != null ){
        if( hare_walk_2_steps and current == turtle ){
          throw new CycleException();
        }
        parent = current;
        current = current->right;
        // modified to ensure no left subtree is omitted to move.
        if( current->left == null and current->right != null ){
          parent = current;
          current = current->right;
          hare_walk_2_steps=true;
        }else {
          hare_walk_2_steps=false;
        }
        if( turtle != null ){
          turtle = turtle->right;
        }else{
          // implies parent=null, so current=root->right->right
          // modified.
          if (hare_walk_2_steps) {
            turtle = root->right;
          }else {
            turtle = root;
          }
        }
      }
      return current->left != null;
    }

    void findSubtree ()
    {
      //	Find the topmost node
      top = current->left;
      // added:
      // either current has one parent or not
      // Former: then let hare and turtle start from there with 1,2 steps
      // Latter: checking whether adjacent are same. If same then cycle, otherwise no cycle locally.
      if( current == top ){
        throw new CycleException();
      }

      //	The topmost and rightmost nodes are the same
      if( top->right == null ){
        bottom = top;
        return;
      }
      //	The rightmost node is buried in the right subtree of topmost node. Find it using Floyd's cycle detection algorithm applied to right childs.
      bottom = top->right;
      turtle = top;
      // If bottom->right=null, either leaf after 2 steps or only with 1 step.
      // For the latter so we won't check bottom == turtle
      // For the former, leaf can't be equal to subtree.
      while( bottom->right != null ){
        if( bottom == turtle ){
          throw new CycleException();
        }
        bottom = bottom->right;
        if( bottom->right != null ){
          bottom = bottom->right;
        }
        turtle = turtle->right;
      }
    }

    void moveSubtree ()
    {
      //	Update root; if the current node is the root then the top is the new root

      // Added: Here top is the top of the left subtree of current.
      // Since top will be added above current, i.e. root. So root is changed.
      if( root == current ){
        root = top;
      }
      //	Add subtree below parent

      // Added: current is not root.
      if( parent != null ){
        parent->right = top;
      }
      //	Add current below subtree
      bottom->right = current;
      //	Remove subtree from current
      current->left = null;
      //	Update current; step up to process the top
      current = top;
    }

    Node<T>* root;
    Node<T>* parent;
    Node<T>* current;
    Node<T>* top;
    Node<T>* bottom;
    Node<T>* turtle;

  private:

    Flattener (Flattener&);
    Flattener& operator = (Flattener&);

};

  template <class T>
void traverseFlat (Node<T>* current)
{
  while( current != null ){
    cout << dec << current->value << " @ 0x" << hex << reinterpret_cast<int32>(current) << endl;
    current = current->right;
  }
}

/*
   adding order where 0 means left:
   root -> root0 -> root1 -> root00 -> root01 -> root10 -> root11 ...
   */
  template <class T>
Node<T>* makeCompleteBinaryTree (int32 maxNodes)
{
  Node<T>* root = new Node<T>();
  queue<Node<T>*> q;
  q.push(root);
  int32 nodes = 1;
  while( nodes < maxNodes ){
    Node<T>* node = q.front();
    q.pop();
    node->left = new Node<T>();
    q.push(node->left);
    nodes++;
    if( nodes < maxNodes ){
      node->right = new Node<T>();
      q.push(node->right);
      nodes++;
    }
  }
  return root;
}

  template <class T>
void inorderLabel (Node<T>* root)
{
  int32 label = 0;
  inorderLabel(root, label);
}

  template <class T>
void inorderLabel (Node<T>* root, int32& label)
{
  if( root == null ){
    return;
  }
  inorderLabel(root->left, label);
  root->value = label++;
  inorderLabel(root->right, label);
}

  template <class T>
void add_cycle (Node<T>* root, int32 maxNodes, int32 add_depth)
{
  // added to construct one cycle
  Node<T>* node = root;
  int32 nodes = 1;
  // just one rough calculation for test temporarily.
  while( nodes < std::log(maxNodes) / std::log(2) ){
    // node=node->left;
    // if (nodes == add_depth) {
    //   node->left=root;
    // }
    // nodes++;

    // see md. This will loop...
    node=node->right;
    if (nodes == add_depth) {
      node->right=root;
    }
    nodes++;
  }
}

  template <class T>
Node<T>* TestTree1 ()
{
  Node<T>* root = new Node<T>();
  root->left = new Node<T>();
  root->right = new Node<T>();
  root->left->right = new Node<T>();
  root->left->right->left = new Node<T>();
  root->left->right->right = new Node<T>();
  root->left->right->right->left = new Node<T>();
  root->left->right->right->right = new Node<T>();

  root->right->left = new Node<T>();
  root->right->right = new Node<T>();
  return root;
}

int32 main (int32 argc, char* argv[])
{
  if(argc||argv){}

  typedef Node<int32> Node;

  //	Make binary tree and label it in-order
  // Node* root = makeCompleteBinaryTree<int32>(1 << 24);
  // inorderLabel(root);
  // add_cycle ( root, 1 << 24, 4);

  Node* root = TestTree1<int32>();
  inorderLabel(root);
  root->right->right=root;

  //	Try to flatten it
  try{
    Flattener<int32> F;
    root = F.flatten(root);
  }catch(CycleException*){
    cout << "Oh noes, cycle detected!" << endl;
    return 0;
  }

  //	Traverse its flattened form
  //	traverseFlat(root);

}
