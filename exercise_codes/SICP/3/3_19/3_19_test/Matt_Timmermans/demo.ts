/**
 * Compile it: https://code.visualstudio.com/docs/typescript/typescript-tutorial
 * 
 * The difference from the compiled result demo.js
 * 1. no type related things like 
  * a. Node | undefined.
  * b. !
  * c. <Node, number>
  * d. as...
 * 2. expand "?."
 */
/**
 * 0. https://www.typescriptlang.org/docs/handbook/variable-declarations.html#block-scoped-variable-capturing
 * getCity = function ()... is similar to env of func in Scheme.
 * 1. > Some readers might do a double-take at this example. The variable x was declared within the if block, and yet we were able to access it from *outside that block*.
 * compare it with
 * > // Error: 'b' doesn't exist here
 */
// define type for future checking and usage https://www.typescriptlang.org/docs/handbook/interfaces.html
interface Node {
  // https://stackoverflow.com/a/23557094/21294350
  left?: Node,
  right?: Node;
}

/*
0. each level n is all nodes with n-1 left walks which can be proved by induction.
i.e. we fine all nodes with left link and do one more left walk. Then do possibly rest right walks.
So at least we traverse all nodes.
0.a. since each former level has one ending cycle during construction.
So if we reach one node in the former levels, then keep walking right, we will reach that cycle.
*/
// true if invalidNode is undefined, i.e. not find one invalidNode.
function checkTree(root: Node): boolean {
  // https://stackoverflow.com/a/44017547/21294350
  // null or undefined will all be false.
  if (!root) {
    return true;
  }

  // LEVEL 1
  if (!validateRightList(root)) {
    return false;
  }
  let levelStart = root;

  // LEVEL N
  // We'll set this to a left child if the tree is invalid
  let invalidNode: Node | undefined;
  let next = findLeftLink(levelStart);
  // If no left, then all levels have been visited.
  while (next) {
    let levelEnd = validateRightList(next.left!);
    if (!levelEnd) {
      invalidNode = next.left;
      break;
    }
    levelStart = next.left!;
    while (next.right != next && (next = findLeftLink(next!.right!))) {
      const s = next.left!;
      const e = validateRightList(s);
      if (!e) {
        invalidNode = s;
        break;
      }
      /*  
       > If the current right child is not the first right child
       Here level means the level of concatenated right list.
      */
      // concatenate next level lists
      levelEnd.right = s;
      levelEnd = e;
    }
    next = invalidNode ? undefined : findLeftLink(levelStart);
  }

  // Validation complete. PREPARE FOR RECOVERY
  let prev: Node | undefined = undefined;
  // https://www.tutorialsteacher.com/typescript/for-loop
  for (let n = root; n != levelStart;) {
    // Will happen when findLeftLink(levelStart) !== levelStart
    next = n.left ? n.left : n.right!;
    n.left = prev;  // note root.left == undefined now
    prev = n;
    n = next;
  }
  /* modified by OP based on n != levelStart */
  // remember the last overwritten left link in the recovery backtracking list
  let savedLeft = levelStart.left;
  levelStart.left = prev;

  // RECOVERY
  recoverRightList(levelStart);
  // stop when levelStart is root.
  // For root (with the ending loop and left links change), we need to 
  // 1. restore that end loop which is done by `recoverRightList(next);` in the level-1 of the construction level list above.
  // 2. "left links from levelStart (i.e. that in `while (levelStart.left)`) to the up-level levelStart" don't include the left link of "up-level levelStart".
  // So do that explicitly.
  while (levelStart.left) {
    let nextLevel: Node | undefined = levelStart;
    // move up to prev level
    next = levelStart.left; // node with left link in prev level
    recoverRightList(next);
    levelStart.left = savedLeft; // fixed
    savedLeft = levelStart;
    levelStart = next;
    // https://stackoverflow.com/a/60669874/21294350
    // avoid "unexpected type conversions".
    // Same for !== https://stackoverflow.com/a/42517860/21294350
    while (levelStart && levelStart.left && levelStart.left.right === levelStart) {
      // recover right link
      // like the root-> root.right in the demo figure.
      levelStart = levelStart.left;
      levelStart.right!.left = savedLeft;
      // To recover those nodes with no left as findLeftLink(levelStart) implies.
      savedLeft = undefined;
    }
    /* 
    0. up to now, all left links from levelStart (i.e. that in `while (levelStart.left)`) to the up-level levelStart have been restored.
    1. The rest is to fix the concatenation right link list at levelStart.
    */

    // split up the level we just left
    // For the 1st iteration, nextLevel is level-bottom, next is the level above that.
    next = findLeftLink(next.right);
    while (nextLevel && next) {
      const n = nextLevel.right;
      if (n == next.left) {
        // restore the concatenation.
        nextLevel.right = undefined;
        next = findLeftLink(next.right);
      }
      nextLevel = n;
    }
    /*
    So levelStart have been restored.
    */
  }
  levelStart.left = savedLeft;

  // all done
  return !invalidNode;
}

/**
 * Find the end of the right-linked-list and link it to itself
 * @returns the end node, or undefined if there is a cycle
 */
function validateRightList(n: Node): Node | undefined {
  let slow = n;
  // https://stackoverflow.com/questions/15260732/does-typescript-support-the-operator-and-whats-it-called
  while (n.right?.right) {
    n = n.right.right;
    // https://stackoverflow.com/a/42274019/21294350
    // > tell the compiler "this expression cannot be null or undefined here ..."
    slow = slow.right!;
    if (slow == n) {
      return undefined; // found a cycle
    }
  }
  // add self cycle.
  /**
   * IGNORE:  TODO Why not always set n.right=n when n.right is null.
   * Fixed in OP modification.
   */
  if (n.right) {
    n = n.right;
  }
  return n;
}

/**
 * Undo validateRightList and return end
 */
function recoverRightList(n: Node): Node {
  while (n.right && n.right !== n) {
    n = n.right;
  }
  n.right = undefined;
  return n;
}

/**
 * Traverse a terminated or validated right-list to find
 * a node with a left child
 */
function findLeftLink(n: Node | undefined): Node | undefined {
  if (!n) {
    return undefined;
  }
  // n.right == n means we have reach the end.
  while (!n.left && n.right && n.right !== n) {
    n = n.right!;
  }
  return n.left ? n : undefined;
}

/**
 * test
 */
function treeToString(root: Node) : string {
  const map = new Map<Node, number>();
  const list: string[] = [];
  function f(n: Node | undefined) {
    if (!n) {
      return;
    }
    if (map.has(n)) {
      list.push(String(map.get(n)));
      return;
    }
    map.set(n, map.size);
    list.push('(');
    f(n.left);
    list.push(',');
    f(n.right);
    list.push(')');
  }
  f(root);
  return list.join('');
}

const testTree = {
  right: {
    left: {
      left: {},
      right: {}
    },
    right: {
      left: {
        left: {},
        right: {}
      },
      right: {}
    }
  }
} as Node;

console.log(`test Tree: ${treeToString(testTree)}`);
console.log(`valid: ${checkTree(testTree)}`);
console.log(`recovered: ${treeToString(testTree)}`);

testTree.right!.right!.left!.right = testTree.right!.left;

console.log(`test Tree: ${treeToString(testTree)}`);
console.log(`valid: ${checkTree(testTree)}`);
console.log(`recovered: ${treeToString(testTree)}`);