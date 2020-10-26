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

## Typedef 有助于创建平台无关类型，甚至能隐藏复杂和难以理解的语法。 

不管怎样，使用typedef能为代码带来意想不到的好处，通过本文你可以学习用`typedef`避免欠缺，从而代码更健壮。

typedef声明，简称`typedef`,为现有类型创建一个新的名字。比如人们常常使用`typedef`来编写美观和可读的代码。

所谓美观，意指`typedef`能隐藏笨拙的语法构造以及平台相关的数据类型，从而增强可移植性和以及未来的可维护性。

`typedef`使用最多的地方是创建易于记忆的类型名，用它来归档程序员的意图。类型出现在所声明的变量名字中，位于typedef关键字右边。

* case 1: `typedef int size`;

此声明定义了一个int的同义字，名字为size.注意typedef并不创建新的类型，仅为现有类型添加一个同义字。

你可以在任何需要int的上下文中使用size:

```
void measure(size * psz);
size array[4];
size len = file.genlength();
```

* case 2: typedef还可以掩饰复合类型,如指针和数组。
例如，你不用像下面这样重复定义有81个字符元素的数组:
```
char line[81]; 
char text[81];
```
定义一个`typedef`,每当要用到相同类型和大小的数组时，可以这样：
```
typedef char Line[81];
Line test,secondline;
getline(text);
```
同样，可以象下面这样隐藏指针语法：
```
typedef char * pstr;
int mystrcmp(pstr pstr);
```
这里是我们遇到的**_第一个陷阱_**。标准函数strcmp()有两个const char *类型的参数。因此，它可能会误导人们像下面这样的声明：
```
int mystrcmp(const pstr, const pstr);
```
这是错误的，事实上，const pstr被编译器解释为`char * const`(一个指向char的常量指针)，而不是`const char *`(指向产量char的指针)。
这个问题很容易解决：
```
typedef const char * cpstr;
int mystrcmp(cpstr,cpstr);
```
上面讨论的`typedef`行为有点像`#define`宏，用其实际类型替代同义字。不同点是`typedef`在编译时被解释,因此让编译器来应付超越预处理器能力的文本替换。 
* case 3: `typedef int (*PF) (const char *, const char *); `
这个声明引入了 PF 类型作为函数指针的同义字，该函数有两个 const char * 类型的参数以及一个 int 类型的返回值。如果要使用下列形式的函数声明，那么上述这个 typedef 是不可或缺的：
```
PF Register(PF pf); 
```
Register()的参数是一个PF类型的回调函数，返回某个函数的地址，其署名与先前注册的名字相同。做一次深呼吸。下面我展示一下如果不用 typedef，我们是如何实现这个声明的： 
```
int (*Register (int (*pf)(const char *, const char *))) (const char *, const char *); 
```
很少有程序员理解它是什么意思，更不用说这种费解的代码所带来的出错风险了。显然，这里使用typedef 不是一种特权，而是一种必需。typedef 就像 auto，extern，mutable，static，和 register 一样，是一个存储类关键字。这并不是说typedef会真正影响对象的存储特性；它只是说在语句构成上，typedef 声明看起来象 static，extern 等类型的变量声明。 

下面将带到**_第二个陷阱_**：
```
typedef register int FAST_COUNTER; // 错误编译通不过
```
问题出在你**不能**在声明中有**多个**存储类关键字。因为符号`typedef`已经占据了存储类关键字的位置，在`typedef`声明中不能用`register`（或任何其它存储类关键字）。`typedef`有另外一个重要的用途，那就是定义机器无关的类型，例如，你可以定义一个叫 REAL 的浮点类型，在目标机器上它可以获得最高的精度：
```
typedef long double REAL;
```
在不支持 long double 的机器上，该 typedef 看起来会是下面这样：`typedef double REAL;`

在连 double 都不支持的机器上，该 typedef 看起来会是这样：`typedef float REAL;`

你不用对源代码做任何修改，便可以在每一种平台上编译这个使用 `REAL` 类型的应用程序。唯一要改的是 `typedef` 本身。

在大多数情况下，甚至这个微小的变动完全都可以通过奇妙的条件编译来自动实现。不是吗?

标准库广泛地使用`typedef`来创建这样的平台无关类型：`size_t`，`ptrdiff` 和 `fpos_t` 就是其中的例子。 

此外，象 `std::string` 和 `std::ofstream` 这样的 `typedef` 还隐藏了长长的，难以理解的模板特化语法， 例如：`basic_string`，`allocator>` 和 `basic_ofstream>`。

  - 用途一：定义一种类型的别名，而不只是简单的宏替换，可以用作同时声明指针型的多个对象。
比如：
```
char* pa, pb; // 这多数不符合我们的意图，它只声明了一个指向字符变量的指针，和一个字符变量；
```
以下则可行：
```
typedef char* PCHAR; // 一般用大写
PCHAR pa, pb; // 可行，同时声明了两个指向字符变量的指针
```
虽然：`char *pa, *pb;`也可行，但相对来说没有用typedef的形式直观，尤其在需要大量指针的地方，typedef的方式更省事。

  - 用途二：
用在旧的C代码中（具体多旧没有查），帮助`struct`。以前的代码中，声明`struct`新对象时，必须要带上`struct`，即形式为： `struct 结构名 对象名`。

如：
```
struct tagPOINT1
{
int x;
int y;
};
struct tagPOINT1 p1;
```
而在C++中，则可以直接写：结构名 对象名，即：`tagPOINT1 p1;`

估计某人觉得经常多写一个struct太麻烦了，于是就发明了：
```
typedef struct tagPOINT
{
int x;
int y;
}POINT;

POINT p1; // 这样就比原来的方式少写了一个struct，比较省事，尤其在大量使用的时候
```
或许，在C++中，`typedef`的这种用途二不是很大，但是理解了它，对掌握以前的旧代码还是有帮助的，毕竟我们在项目中有可能会遇到较早些年代遗留下来的代码。

  - 用途三：用`typedef`来定义与平台无关的类型。

比如定义一个叫 `REAL` 的浮点类型，在目标平台一上，让它表示最高精度的类型为：`typedef long double REAL;`

在不支持 `long double` 的平台二上，改为：`typedef double REAL;`

在连 `double`都不支持的平台三上，改为：`typedef float REAL;`

也就是说，当跨平台时，只要改下 `typedef` 本身就行，不用对其他源码做任何修改。

标准库就广泛使用了这个技巧，比如`size_t`。

另外，因为`typedef`是定义了一种类型的新别名，不是简单的字符串替换，所以它比宏来得稳健（虽然用宏有时也可以完成以上的用途）。

  - 用途四： 为复杂的声明定义一个新的简单的别名。
方法是：在原来的声明里逐步用别名替换一部分复杂声明，如此循环，把带变量名的部分留到最后替换，得到的就是原声明的最简化版。

举例：

1. 原声明：`int *(*a[5])(int, char*);`
变量名为a，直接用一个新别名pFun替换a就可以了：
`typedef int *(*pFun)(int, char*);`

原声明的最简化版：`pFun a[5];`

2. 原声明：`void (*b[10]) (void (*)());` 变量名为`b`，先替换右边部分括号里的，`pFunParam`为别名一：
`typedef void (*pFunParam)()`;再替换左边的变量`b`，`pFunx`为别名二：`typedef void (*pFunx)(pFunParam);`
原声明的最简化版：`pFunx b[10];`

3. 原声明：`doube(*)() (*e)[9];`变量名为`e`，先替换左边部分，`pFuny`为别名一：`typedef double(*pFuny)();`再替换右边的变量`e`，`pFunParamy`为别名二`typedef pFuny (*pFunParamy)[9];`原声明的最简化版：`pFunParamy e;`

理解复杂声明可用的**_“右左法则”_**：从变量名看起，先往右，再往左，碰到一个圆括号就调转阅读的方向；括号内分析完就跳出括号，还是按先右后左的顺序，如此循环，直到整个声明分析完。举例：
```
int (*func)(int *p);
```
首先找到变量名`func`，外面有一对圆括号，而且左边是一个*号，这说明func是一个指针；然后跳出这个圆括号，先看右边，又遇到圆括号，这说明(*func)是一个函数，所以func是一个指向这类函数的指针，即函数指针，这类函数具有int*类型的形参，返回值类型是int。
```
int (*func[5])(int *);
```
func右边是一个\[\]运算符，说明func是具有5个元素的数组；func的左边有一个*，说明func的元素是指针（注意这里的*不是修饰func，而是修饰`func[5]`的，原因是`[]`运算符优先级比`*`高，func先跟`[]`结合。跳出这个括号，看右边，又遇到圆括号，说明func数组的元素是函数类型的指针，它指向的函数具有`int*`类型的形参，返回值类型为int。

也可以记住2个模式：
```
type (*)(....)函数指针
type (*)[]数组指针 
```

---------------------------
* 陷阱一：`typedef`是定义了一种类型的新别名，不同于宏，它不是简单的字符串替换。

比如：
先定义：`typedef char* PSTR;`  
然后：`int mystrcmp(const PSTR, const PSTR);`  

`const PSTR`实际上相当于`const char*`吗？不是的，它实际上相当于`char* const`。 

原因在于`const`给予了整个指针本身以常量性，也就是形成了常量指针`char* const`。
简单来说，记住当const和typedef一起出现时，typedef不会是简单的字符串替换就行。

* 陷阱二：`typedef`在语法上是一个存储类的关键字（如auto、extern、mutable、static、register等一样），虽然它并不真正影响对象的存储特性，

如：
`typedef static int INT2; //不可行`
编译将失败，会提示“指定了一个以上的存储类”。

注意`typedef int* p[9]`与`typedef int(*p)[9]`的区别，前者定义一个数组，此数组包含9个int*类型成员，而后者定义一个指向数组的指针，被指向的数组包含9个int类型成员)。
现在是不是觉得要认识它们是易如反掌，工欲善其事，必先利其器！我们对这种表达方式熟悉之后，就可以用`typedef`来简化这种类型声明。
* 用typedef定义类型别名时，如`typedef char* pchar`, 如果用const来修饰，当const在前面， 就是`const pchar`,你会认为它是`const char*`, 那就错了，它的真实含义是`char * const`
