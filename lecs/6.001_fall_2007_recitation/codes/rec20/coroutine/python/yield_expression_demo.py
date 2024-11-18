def myfunc():
  x = ''
  while True:
    print(f'Yielding x ({x}) and waiting…')
    """
    https://peps.python.org/pep-0342/#new-syntax-yield-expressions
    1st call when next, i.e. None value is thrown away.
    > a yield expression whose value is *thrown away*
    > Calling send(None) is exactly equivalent to calling a generator’s next() method.
    2nd call
    > sends a value that becomes the result of the current yield-expression

    Other interfaces like throw() etc are skipped, since I am not to learn Python.
    """
    x = yield x
    if x is None:
      print("break")
      break
    print(f'Got x {x}. Doubling.')
    x = x * 2


g = myfunc()
"""
since yield run inside the body
"""
# <generator object myfunc at 0x718eca145150>

# > Because generator-iterators begin execution at the top of the generator’s function body
# > ... before you can communicate with a coroutine you must first call next() or send(None) to advance its execution to the first yield expression.
next(g)
g.send(10)
g.send(123)
g.send(None)
