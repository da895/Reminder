# [C语言typedef的用法](https://www.cnblogs.com/afarmer/archive/2011/05/05/2038201.html)  


## 基本概念剖析 

case 1: `int * (*a[5])(int, char *);`  
case 2: `void (*b[10])(void(*)());`  
case 3: `double(*)() (*pa)[9];`  

### 1. C语言中函数声明和数组声明  

* 函数声明  
一般情况是这样的: `int fun(int,double);`  
函数指针声明是这样的: `int (*pt)(int,double);`, 可以这样使用  
`pf = &fun;`    //赋值  
`(*pf)(5,8.9);` //函数调用  
C语言提供如下简写方式:  
`pf=fun;`       //赋值  
`pf(5,8.9);`    //函数调用  
* 数组声明  
一般是这样的: `int a[5];`  
数组指针声明是这样的: `int (*pa)[5];`,可以这样使用  
`pa = &a;`          //赋值  
`int i = (*pa)[2];` //将a[2]赋值给i;  

### 2. 案例分析  
case 1: `int * (*a[5])(int, char *);`  
首先看到标识符a, “[]”优先级大于“*”，a与“[5]”先结合。 所以a是一个数组，这个数组有5个元素，每个元素都是一个指针， 指针指向“(int,char*)”, 对, 指向一个函数，函数参数是“int,char*”,返回值是"int *".  
case 2: `void (*b[10])(void(*)());`  
b是一个数组，这个数组有10个元素，每一个元素都是一个指针，指针指向一个函数，函数参数是“void(*)()”, 返回值是“void”  
注意: "void (*)()" 又是一个指针，指向一个函数，函数参数为空，返回值是void.  
case 3: `double(*)() (*pa)[9];`  
pa是一个指针，指针指向一个数组，这个数组有9个元素，每一个元素都是“double(*)()”[也即是一个指针，指向一个函数，函数参数为空，返回值是double]  

__TYPEDEF拍上用场__  
case 1: `int * (*a[5])(int, char *);`  
`typedef int* (*PF)(int,char*);`  //PF是一个类型别名  
`PF a[5];`  
很多初学者只知道`typedef char* pchar`; 但是对于typedef的其他用法不太了解。Stephen Blaha对typedef用法做过一个总结: “建立一个类型别名的方法很简单，在传统的变量声明表达式里用类型名替代变量名，然后把关键字typedef加在该语句的开头。”  

case 2: `void (*b[10])(void(*)());`  
`typedef void (*pfv)();`
`typedef void (*pf_taking_pfv)(pfv);`
`pf_taking_pfv b[10];`  


case 3: `double(*)() (*pa)[9];`  
`typedef double(*PF)();`
`typedef PF (*PA)[9];`
`PA pa;`

### const 和 volatile 在类型声明中的位置  
顾名思义， volatile修饰的量就是很容易变化，不稳定的量，她可能被其他线程、操作线程、硬件等等在未知的时间改变，所以它被存储在内从中，每次取用它的时候都只能在内存中去读取，它不能被编译器优化放在内部寄存器中。  
类型声明中const用类修饰一个变量，我们一般这样使用:  

* const在前面

```
const int;          //int 是 const
const char*;        //char 是 const
char* const;        //* 是 const
const char* const; //char和*都是const
```  
对于初学者， const char * 和char * const 是容易混淆的。这需要时间的历练让你习惯。上面的声明有一个对等的写法: 

* const在后面

```
int const;          //int 是 const
char* const;        //char 是 const
char* const;        //* 是 const
char const * const; //char和*都是const
```  

const在后面有两个好处: 

* const所修饰的类型正好是在它前面的那一个;  
* 用typedef定义类型别名时，如`typedef char* pchar`, 如果用const来修饰，当const在前面， 就是`const pchar`,你会认为它是`const char*`, 那就错了，它的真实含义是`char * const`