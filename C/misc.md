
# Misc for C

<!-- vim-markdown-toc GFM -->

* [Reference](#reference)
* [Customize Print in C](#customize-print-in-c)
* [Print to console](#print-to-console)
* [ucOS doxygen guide](https://micro-os-plus.github.io/develop/doxygen-style-guide/)

<!-- vim-markdown-toc -->

## Reference
* [How to check for DLL dependency?](https://stackoverflow.com/questions/7378959/how-to-check-for-dll-dependency)
* [Creating a shared and static library with the gnu compiler \[gcc\]](https://lsi.vc.ehu.eus/pablogn/docencia/ISO/Act5%20Libs/crealibdin.html)
* [Mingw gcc, "-shared -static" passing together](https://stackoverflow.com/questions/55218519/mingw-gcc-shared-static-passing-together)
* [Is it possible to link a static lib (.a) to a shared object lib (.so)?](https://www.reddit.com/r/linux_programming/comments/sd09kg/is_it_possible_to_link_a_static_lib_a_to_a_shared/?rdt=41488)
* [VSCode配置gcc编译工具](https://blog.csdn.net/wangqingchuan92/article/details/108974662)
* [windows下 CMake+MinGW 搭建C/C++编译环境](https://blog.csdn.net/dcrmg/article/details/103918543)


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
