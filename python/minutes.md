Minutes for Python
==================


<!-- vim-markdown-toc GFM -->

* [Tutorial from python.org](#tutorial-from-pythonorg)
* [Doc from python.org](#doc-from-pythonorg)
* [view all properties of class or object](#view-all-properties-of-class-or-object)
* [python data structures](#python-data-structures)
  * [list](#list)
  * [Tuples](#tuples)
  * [Sets](#sets)
  * [Dictionaries](#dictionaries)
  * [Looping techniques](#looping-techniques)

<!-- vim-markdown-toc -->

## [Tutorial from python.org](https://docs.python.org/3/tutorial/)

## [Doc from python.org](https://www.python.org/doc/)

## view all properties of class or object

1. dir() and help()

    ```python
    import os
    dir(os)
    help(os)
    ```

    redirective to log
    ```python
    import sys
    import hid
    out = sys.stdout
    sys.stdout = open(r'./log.txt','w')
    help(hid)
    sys.stdout.close()
    sys.stdout = out
    ```
## [python data structures](https://docs.python.org/3/tutorial/datastructures.html)

### list

methods:
    
```python
list.append(x)
list.extend(x)
list.insert(i,x)
list.remove(x)
list.pop([i])
list.clear()
list.index(x[x,start[,end]])
list.count(x)
list.sort
list.reverse()
list.copy()
```
ex:

```python
stack = [4,5,6]
stack.append(6)
stack.pop()
```
    
### Tuples

ex:
```pyhon
t = 12345,54321, 'hello world'
```

### Sets

A set is an unorderd collection with no duplicate elements.
Curly braces or the `set()` function can be used to create sets

ex:
```python
basket =  {'apple', 'orange', 'pear', 'apple'}
```

### Dictionaries

ex:
```python
tel = {'jack': 4098, 'tom':333}
```

### Looping techniques

* `items()` used for looping through a dictionary

```python
>>> knights = {'gallahad': 'the pure', 'robin': 'the brave'}
>>> for k, v in knights.items():
...     print(k, v)
...
gallahad the pure
robin the brave
```

* `enumerate()` used for looping through a sequence

```python
>>> for i, v in enumerate(['tic', 'tac', 'toe']):
...     print(i, v)
...
0 tic
1 tac
2 toe
```

* `zip()` used for looping over two or more sequences at the same time

```python
>>> questions = ['name', 'quest', 'favorite color']
>>> answers = ['lancelot', 'the holy grail', 'blue']
>>> for q, a in zip(questions, answers):
...     print('What is your {0}?  It is {1}.'.format(q, a))
...
What is your name?  It is lancelot.
What is your quest?  It is the holy grail.
What is your favorite color?  It is blue.
```

* `reversed()` used for looping over a sequence in reverse

```python
>>> for i in reversed(range(1, 10, 2)):
...     print(i)
...
9
7
5
3
1
```

* `sort()` used to looping over a sequece in sorted order

```python
 >>> basket = ['apple', 'orange', 'apple', 'pear', 'orange', 'banana']
 >>> for i in sorted(basket):
 ...     print(i)
 ...
 apple
 apple
 banana
 orange
 orange
 pear
```

* `set()` used to eliminates duplicate elements on a sequence

```python
 >>> basket = ['apple', 'orange', 'apple', 'pear', 'orange', 'banana']
 >>> for f in sorted(set(basket)):
 ...     print(f)
 ...
 apple
 banana
 orange
 pear
```

* filter a list

```python
 >>> import math
 >>> raw_data = [56.2, float('NaN'), 51.7, 55.3, 52.5, float('NaN'), 47.8]
 >>> filtered_data = []
 >>> for value in raw_data:
 ...     if not math.isnan(value):
 ...         filtered_data.append(value)
 ...
 >>> filtered_data
 [56.2, 51.7, 55.3, 52.5, 47.8]
```
