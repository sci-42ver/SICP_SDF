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

      print("g result:", (g(*arguments),), *(g(*arguments),))
      if type(g(*arguments)) is tuple:
        # g_result=*g(*arguments) # not allowed by syntax ... I won't dig into python syntax.
        # if len(g_result)!=f_arity:
        #   print("f receives the wrong Arg number")
        # else:
        print("g tuple result", *g(*arguments), g(*arguments))
        return f(*g(*arguments))
      else:
        return f(*(g(*arguments),))
    except:
      pass
  return compose_composition


assert compose(lambda x: x+2, lambda x: x*x)(2) == 2*2+2
# this test is expected to throw error.
print("compose test_2", compose(lambda x: x+2, lambda x: x*x)(2, 2))
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
print("test_4", parallel_combine(list, lambda x: x+2, lambda x, y: x*x)(2))
print("test_5", parallel_combine(list, lambda x: x+2, lambda x: x*x)(2, 2))

# test from text-examples.scm
# list doesn't accpet multiple arguments.
assert parallel_combine(lambda *arguments: list(arguments), lambda x, y, z: (
    x, y, z), lambda x, y, z: (z, y, x))("a", "b", "c") == ['a', 'b', 'c', 'c', 'b', 'a']
assert parallel_combine(lambda *arguments: list(arguments), lambda x, y, z: [
                        "foo", x, y, z], lambda x, y, z: ["bar", x, y, z])("a", "b", "c") == [["foo", 'a', 'b', 'c'], ["bar", 'a', 'b', 'c']]
