# https://lerner.co.il/2020/05/08/making-sense-of-generators-coroutines-and-yield-from-in-python/
def my_coroutine_body():
  x = ''
  while True:
    print(f'Yielding x ({x}) and waiting…')
    # Do some funky stuff
    x = yield x
    # Do some more funky stuff
    if x is None:
      break
    print(f'Got x {x}. Doubling.')
    x = x * 2


def make_coroutine(routine):
  yield from routine()


my_coro = make_coroutine(my_coroutine_body)
next(my_coro)

x = 1
while True:
  # The coroutine does some funky stuff to x, and returns a new value.
  # send to routine which then sends to the left x in `x = yield x` in my_coroutine_body.
  if x < 2**10:
    x = my_coro.send(x)
  else:
    my_coro.send(None)
  print(x)
# in coroutine B
# Yielding x () and waiting…
# Got x 1. Doubling.
# Yielding x (2) and waiting…
# back to coroutine A
# 2
# again into coroutine B
# Got x 2. Doubling.
# ...
