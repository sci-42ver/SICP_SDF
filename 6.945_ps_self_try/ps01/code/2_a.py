"""
2.1 has 
compose
parallel-combine
spread-combine
discard-argument
curry-argument
permute-arguments

I choose the first 3 to implement.

Here I didn't implement `restrict-arity` but just ensure that we receive the correct number of args.
"""
# https://www.geeksforgeeks.org/how-to-pass-multiple-arguments-to-function/
import inspect


def calculateTotalSum(*arguments):
  # https://www.geeksforgeeks.org/g-fact-41-multiple-return-values-in-python/
  return [number * number for number in arguments]


calculateTotalSum(5, 4, 3, 2, 1)

"""
Here I only give the demo based on function-combinators.scm.
"""
# https://www.geeksforgeeks.org/how-to-find-the-number-of-arguments-in-a-python-function/


def compose(f, g):
  g_arity = len(inspect.signature(g).parameters)

  def compose_composition(*arguments):
    # https://stackoverflow.com/a/18994347/21294350
    try:
      if len(arguments) != g_arity:
        print("compose Arg number error")
      # print("g return:",g(*arguments))

      # https://stackoverflow.com/a/691274/21294350
      # very inconvenient.
      # g_result=g(*arguments)
      # if type(g_result) is list:
      #   print("g_result",g_result)
      #   return f(*g_result)
      # else:
      #   return f(*[g_result])

      # print("g result:", (g(*arguments),), *(g(*arguments),))
      if type(g(*arguments)) is tuple:
        # g_result=*g(*arguments) # not allowed by syntax ... I won't dig into python syntax.
        # if len(g_result)!=f_arity:
        #   print("f receives the wrong Arg number")
        # else:
        # print("g tuple result", *g(*arguments), g(*arguments))
        return f(*g(*arguments))
      else:
        return f(*(g(*arguments),))
    except:
      pass
  return compose_composition


assert compose(lambda x: x+2, lambda x: x*x)(2) == 2*2+2
# this test is expected to throw error.
print("compose test_2 began")
print(compose(lambda x: x+2, lambda x: x*x)(2, 2))
print("compose test_2 finished")
# compose(lambda x:x, lambda x,y:(x,y))(2,3)==(2,3) # should throw error due to f arity is wrong.
assert compose(lambda x, y: x+y, lambda x, y: (x, y))(2, 3) == 5

# test from text-examples.scm
assert compose(lambda x: ["foo", x], lambda x: [
               "bar", x])(2) == ["foo", ["bar", 2]]
assert compose(lambda x, y: ["foo", x, y], lambda x: (
               ["bar", x], ["baz", x]))(2) == ["foo", ["bar", 2], ["baz", 2]]


def parallel_apply(f, g):
  g_arity = len(inspect.signature(g).parameters)
  f_arity = len(inspect.signature(f).parameters)
  if g_arity != f_arity:
    print("f and g Arg number error")

  def the_composition(*arguments):
    try:
      if len(arguments) != g_arity:
        print("parallel_apply the_composition Arg number error")
      f_result = f(*arguments)
      g_result = g(*arguments)
      if type(f_result) is not tuple:
        f_result = (f_result,)
      if type(g_result) is not tuple:
        g_result = (g_result,)
      # correspond to `append` in "function-combinators.scm". `values` is implied in tuple.
      return f_result+g_result
    except:
      pass
  return the_composition


def parallel_combine(h, f, g):
  # https://stackoverflow.com/a/691274/21294350 * here is like values in Scheme.
  # Here we need to "return". notice the syntax difference from Scheme.
  return compose(h, parallel_apply(f, g))


# print(parallel_apply(lambda x:x+2, lambda x:x*x)(2))
assert parallel_combine(lambda x, y: x*y, lambda x: x +
                        2, lambda x: x*x)(2) == 16
print("error test began")
print("test_4")
print(parallel_combine(list, lambda x: x+2, lambda x, y: x*x)(2))
print("test_5")
print(parallel_combine(list, lambda x: x+2, lambda x: x*x)(2, 2))
print("error test finished")

"""
1. test from text-examples.scm
2. list doesn't accpet multiple arguments.
3. Here "compose Arg number error" is due to we don't set arity of "the_composition".
"""
assert parallel_combine(lambda *arguments: list(arguments), lambda x, y, z: (
    x, y, z), lambda x, y, z: (z, y, x))('a', 'b', 'c') == ['a', 'b', 'c', 'c', 'b', 'a']
assert parallel_combine(lambda *arguments: list(arguments), lambda x, y, z: [
                        "foo", x, y, z], lambda x, y, z: ["bar", x, y, z])('a', 'b', 'c') == [["foo", 'a', 'b', 'c'], ["bar", 'a', 'b', 'c']]


def spread_apply(f, g):
  g_arity = len(inspect.signature(g).parameters)
  f_arity = len(inspect.signature(f).parameters)

  def the_composition(*arguments):
    try:
      if len(arguments) != g_arity+f_arity:
        print("spread_apply the_composition Arg number error")
      f_result = f(*(arguments[0:f_arity]))
      g_result = g(*(arguments[f_arity:]))
      if type(f_result) is not tuple:
        f_result = (f_result,)
      if type(g_result) is not tuple:
        g_result = (g_result,)
      # correspond to `append` in "function-combinators.scm". `values` is implied in tuple.
      return f_result+g_result
    except:
      pass
  return the_composition


def spread_combine(h, f, g):
  # https://stackoverflow.com/a/691274/21294350 * here is like values in Scheme.
  # Here we need to "return". notice the syntax difference from Scheme.
  return compose(h, spread_apply(f, g))


assert spread_combine(lambda *arguments: list(arguments), lambda x, y: (
    x, y), lambda x, y, z: (z, y, x))('a', 'b', 'c', 'd', 'e') == ['a', 'b', 'e', 'd', 'c']
assert spread_combine(lambda *arguments: list(arguments), lambda x, y: [
    "foo", x, y], lambda x, y, z: ["bar", x, y, z])('a', 'b', 'c', 'd', 'e') == [["foo", 'a', 'b'], ["bar", 'c', 'd', 'e']]
