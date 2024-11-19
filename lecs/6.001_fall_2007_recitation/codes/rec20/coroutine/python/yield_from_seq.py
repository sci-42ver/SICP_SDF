def base_generator():
  x = yield 1
  y = yield 2
  z = yield 3
  print([x, y, z])


def intermediate_generator():
  yield from base_generator()


def generator():
  yield from intermediate_generator()
  yield from intermediate_generator()


g = generator()
# https://peps.python.org/pep-0342/
print(next(g))  # i.e. send(None)
print(g.send(4))
print(g.send(5))
# > As with the next() method, the send() method returns the next value yielded by the generator-iterator
print(g.send(6))
# https://stackoverflow.com/questions/715758/coroutine-vs-continuation-vs-generator/79197544#comment139662528_7252061
# Here we are in "auxiliary function" intermediate_generator.
# And also the 2nd intermediate_generator() can be tracked, so not semi-coroutine
