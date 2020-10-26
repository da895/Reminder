
# Misc for C

<!-- vim-markdown-toc GFM -->

* [Reference](#reference)
* [memory](#memory)
* [Customize Print in C](#customize-print-in-c)
* [Print to console](#print-to-console)
* [**自定义Qt重定向标准输出**](#自定义qt重定向标准输出)

<!-- vim-markdown-toc -->

## Reference
* [Linux中的额动态库和静态库(.a/.la/.so/.o)](https://hokkaitao.github.io/linux-lib)  
* [How to check for DLL dependency?](https://stackoverflow.com/questions/7378959/how-to-check-for-dll-dependency)
* [Creating a shared and static library with the gnu compiler \[gcc\]](https://lsi.vc.ehu.eus/pablogn/docencia/ISO/Act5%20Libs/crealibdin.html)
* [Mingw gcc, "-shared -static" passing together](https://stackoverflow.com/questions/55218519/mingw-gcc-shared-static-passing-together)
* [Is it possible to link a static lib (.a) to a shared object lib (.so)?](https://www.reddit.com/r/linux_programming/comments/sd09kg/is_it_possible_to_link_a_static_lib_a_to_a_shared/?rdt=41488)
* [VSCode配置gcc编译工具](https://blog.csdn.net/wangqingchuan92/article/details/108974662)
* [windows下 CMake+MinGW 搭建C/C++编译环境](https://blog.csdn.net/dcrmg/article/details/103918543)

## memory
* MinGW 环境下无法通过`SetupDiGetClassDevs`获取所有USB设备，原因是"***MinGW 默认使用 ANSI 版本，但可通过定义强制使用 Unicode***"
```
#define UNICODE
#define _UNICODE
#include <windows.h>
#include <setupapi.h>

// 现在 SetupDiGetClassDevs 将使用宽字符版本
HDEVINFO hDevInfo = SetupDiGetClassDevs(
    &GUID_DEVINTERFACE_USB_DEVICE,
    NULL,
    NULL,
    DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
```
* libtool CPP 程序调用C函数相当复杂，两者编译FLAGS也不一样，TODO

## Customize Print in C

```C
#define DEBUG(fmt, ...) printf("[DEBUG] " fmt "\n", ##__VA_ARGS__)
```

```C
#define LOG_DEBUG 1 
#define LOG_INFO 2 
#define LOG_ERROR 4 
#define LOG_FATAL 5

#define LOG(level, ...) \
    do { \
        if (level >= LOG_LEVEL) { \
            fprintf(stderr, "[%s] %s:%d ", __FILE__, __LINE__); \
            fprintf(stderr, ##__VA_ARGS__); \
        } \
    } while (0)

```

## Print to console
```C
void dllPrintf(const char* fmt, ...) {
    va_list args;
    va_start(args, fmt);
    char buffer[512];
    vsnprintf(buffer, sizeof(buffer), fmt, args);
    va_end(args);

    static HANDLE hConsole = INVALID_HANDLE_VALUE;
    if (hConsole == INVALID_HANDLE_VALUE) {
        //AllocConsole();                        
        AttachConsole(ATTACH_PARENT_PROCESS);
        hConsole = GetStdHandle(STD_OUTPUT_HANDLE); 
    }

    DWORD charsWritten;
    WriteConsole(
        hConsole,               // 控制台句柄
        buffer,                 // 缓冲区内容
        strlen(buffer),         // 写入字符数
        &charsWritten,          // 实际写入字符数指针
        NULL                    // 保留参数（必须为 NULL）
    );                          
    //FreeConsole();
}
```



## **自定义Qt重定向标准输出**

纯粹的 GUI 程序默认不显示控制台窗口，因此 `std::cout` 的输出会被系统丢弃或无法查看



通过代码将 `std::cout` 重定向到文件或 Qt 日志系统：

```C
cppCopy Code#include <iostream>
#include <fstream>
#include <QDebug>

void redirectStdout() {
    std::freopen("output.log", "a", stdout);  // 输出到文件
    // 或重定向到 qDebug()
    std::cout.rdbuf(qDebug().stream().rdbuf()); 
}

int main(int argc, char *argv[]) {
    redirectStdout();
    QApplication app(argc, argv);
    std::cout << "Hello from std::cout!";  // 输出到文件或 qDebug()
    return app.exec();
}
```
alternative
```c
void logToFile(const QString &message)
{
    QFile file("application.log");
    if (file.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text)) {
        QTextStream stream(&file);
        stream << QDateTime::currentDateTime().toString() << " - " << message << "\n";
        file.close();
    }
}
```
