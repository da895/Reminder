# python upgrade



### [Install Python 3 on Ubuntu From Source Code](https://www.makeuseof.com/install-python-ubuntu/)

1. `sudo apt update`

2. `sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget`
3. `mkdir python && cd python`
4. `wget  https://www.python.org/ftp/python/3.9.14/Python-3.9.14.tgz`
5. `tar -xvf Python-3.9.14.tgz`
6. `cd Python-3.9.14.tgz`
7. `./configure --enable-optimizations`
8. `sudo make install`

### Create a python3 symlink pointing the latest python version

1. create symlink

`ln -sf /usr/bin/python3.9 /usr/bin/python3`

2. install the matching pip version

```
wget https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3.9 get-pip.py \
    && rm get-pip.py
```

3. validate the install

   ```
   
   $ which python3
   /usr/local/bin/python3
   
   $ python3 --version
   Python 3.9.2
   
   $ pip -V
   pip 18.1 from /usr/local/... (python 3.9)
   ```

### [Creation of virtual environments -- venv](https://docs.python.org/3/library/venv.html)

```
python3 -m venv <DIR>
source <DIR>/bin/activate
```

