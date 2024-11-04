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
      turtle = parent;
      while( current->left == null and current->right != null ){
        if( current == turtle ){
          throw new CycleException();
        }
        parent = current;
        current = current->right;
        if( current->right != null ){
          parent = current;
          current = current->right;
        }
        if( turtle != null ){
          turtle = turtle->right;
        }else{
          turtle = root;
        }
      }
      return current->left != null;
    }

    void findSubtree ()
    {
      //	Find the topmost node
      top = current->left;
      //	The topmost and rightmost nodes are the same
      if( top->right == null ){
        bottom = top;
        return;
      }
      //	The rightmost node is buried in the right subtree of topmost node. Find it using Floyd's cycle detection algorithm applied to right childs.
      bottom = top->right;
      turtle = top;
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
      if( root == current ){
        root = top;
      }
      //	Add subtree below parent
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
    node=node->left;
    if (nodes == add_depth) {
      node->left=root;
    }
    nodes++;
  }
}


int32 main (int32 argc, char* argv[])
{
  if(argc||argv){}

  typedef Node<int32> Node;

  //	Make binary tree and label it in-order
  Node* root = makeCompleteBinaryTree<int32>(1 << 24);
  inorderLabel(root);
  add_cycle ( root, 1 << 24, 4);

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