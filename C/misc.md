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
