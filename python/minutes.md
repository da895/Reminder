# Minutes for Python


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
