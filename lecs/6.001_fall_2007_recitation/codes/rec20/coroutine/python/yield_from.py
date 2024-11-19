# https://lerner.co.il/2020/05/08/making-sense-of-generators-coroutines-and-yield-from-in-python/
"""
0. This blog "So, what have we seen here?" just shows the usage of yield etc.
The basic ideas are just said by point 1 "with *state that remains* across *calls*" where states are both about data and execution as wikipedia says.
1. > Our coroutine hangs around, waiting for us to give it a number to dial.
i.e. another coroutine is the interaction program.
"""
import random


def pl_sentence(sentence):
  output = []
  for one_word in sentence.split():
    if one_word[0] in 'aeiou':
      output.append(one_word + 'way')
    else:
      output.append(one_word[1:] + one_word[0] + 'ay')
  return ' '.join(output)


def pig_latin_translator():
  s = ''
  while True:
    s = yield pl_sentence(s)
    if s is None:
      break
  s


def bad_service_chatbot():
  answers = ["We don't do that",
             "We will get back to you right away",
             "Your call is very important to us",
             "Sorry, my manager is unavailable"]
  yield "Can I help you?"
  s = ''
  while True:
    if s is None:
      break
    s = yield random.choice(answers)


def switchboard():
  choice = yield "Send 1 for Pig Latin, 2 for support"
  if choice == 1:
    """
    0. A bit like symmetric coroutine but is decided by "yield from" sequence instead of arbitrary address as crystalclearsoftware (boost) says.
    1. Also see with Task https://stackoverflow.com/a/27088005/21294350
    2. Returning value is just like passing argument in crystalclearsoftware with base in self.yield_to(consumer, base) etc.
    """
    yield from pig_latin_translator()
    """
    This can't
    > allow that sub-generator to get inputs from the user
    """
    # yield pig_latin_translator() # only run once
    # pig_latin_translator()  # can't use the yield inside it
  elif choice == 2:
    yield from bad_service_chatbot()
  else:
    return


"""
Use `python -i yield_from.py` to load the above library https://www.reddit.com/r/pythontips/comments/12mgonn/python_interactive_mode_beginner_tip/
"""
s = switchboard()
next(s)
s.send(1)
s.send('hello')
s.send(None)

"""
1. Also see this https://stackoverflow.com/a/26109157/21294350 for "transparent" behavior (i.e. )
1.a. > This still does not cover all the corner cases though. What happens if the outer generator is closed?
IGNORE: Maybe passed to the caller of the closed caller.
see `_i.close` context in the reference.
1.b. TBD https://stackoverflow.com/a/51899033/21294350
1.c. writer_wrapper implementation shows the behavior of *passing along*.
2. https://discuss.python.org/t/what-is-yield-from/40197/2 is much lessinformative. 
3. One more realistic example https://stackoverflow.com/a/19302694/21294350
```
g=doStuff()
res=next(g) # return takesTwoSeconds()
res=g.send(res) # pass to result explicitly and get takesTenSeconds(result * 10)
g.send(res)
# Same as callback to construct one calculation sequence.
```
"""
