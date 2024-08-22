# https://www.programiz.com/python-programming/operator-overloading
import math
import numbers


class Point:
  def __init__(self, x=0, y=0):
    self.x = x
    self.y = y

  def __str__(self):
    return "({0},{1})".format(self.x, self.y)

  def __add_common_types__(self, other):
    x = self.x + other.x
    y = self.y + other.y
    return Point(x, y)

  # > Can you overload simple operators, like + and *?
  # Here I only give one demo of +

  # https://stackoverflow.com/a/42071939/21294350
  def __add__(self, other):
    if isinstance(other, self.__class__):
      return self.__add_common_types__(other)
    else:
      # https://stackoverflow.com/a/4187266/21294350
      if isinstance(other, numbers.Number):
        return Point(self.x+other, self.y+other)
      else:
        # https://docs.python.org/3/library/exceptions.html
        raise TypeError

  def __radd__(self, other):
    return self.__add__(other)

  def __eq__(self, other):
    if isinstance(other, self.__class__):
      return self.x == other.x and self.y == other.y
    else:
      raise TypeError


p1 = Point(1, 2)
p2 = Point(2, 3)

assert p1+p2 == Point(3, 5)
assert p1+2 == Point(3, 4)
assert 2+p1 == Point(3, 4)

# > What is hard and what is easy?
# the former is too general while the latter is more specific.


def sin(num):
  return math.cos(num)


# > For example, in python there are “dunder methods” for some operators.
# It seems that we can only change for subclass https://stackoverflow.com/a/65582100/21294350 instead of base https://stackoverflow.com/a/72407897/21294350.
# So we can't easily change 1+2 value but we can do this by modifying `numeric-arithmetic` in code base.

# > Is there a moral to this story?
# language primitives decides the extent of flexibility in some way.
