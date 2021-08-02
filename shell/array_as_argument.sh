#! /bin/bash


## [](https://stackoverflow.com/questions/16461656/how-to-pass-array-as-an-argument-to-a-function-in-bash)


## pass the array by name
function method1() {
    name=$1[@]
    b=$2
    a=("${!name}")

    for i in "${a[@]}" ; do
        echo "$i"
    done
    echo "b: $b"
}

## pass its elements (i.e. the expanded array)
function method2() {
    a=("$@")
    ((last_idx=${#a[@]} - 1))
    b=${a[last_idx]}
    unset a[last_idx]

    for i in "${a[@]}" ; do
        echo "$i"
    done
    echo "b: $b"
}

x=("one two" "LAST")
b='even more'


echo "======= Method 1 : pass array by name  ========"
method1 x "$b"
echo "======= Method 2 : pass array elements ========"
method2 "${x[@]}" "$b"
