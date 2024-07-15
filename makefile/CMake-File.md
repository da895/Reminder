# file文件操作命令


<!-- vim-markdown-toc GitLab -->

* [目录](#目录)
* [Reading：读文件](#reading读文件)
* [Writing：写文件](#writing写文件)
* [Filesystem：文件系统操作](#filesystem文件系统操作)
* [Path Conversion：路径转换](#path-conversion路径转换)
* [Transfer：下载与上传](#transfer下载与上传)
* [Locking：同步锁](#locking同步锁)

<!-- vim-markdown-toc -->


## 目录

    Reading：读文件
    Writing：写文件
    Filesystem：文件系统操作
    Path Conversion：路径转换
    Transfer：下载与上传
    Locking：同步锁

## Reading：读文件

```cmake
   * file(READ <filename> <out-var> [...])
   * file(STRINGS <filename> <out-var> [...])
   * file(<HASH> <filename> <out-var>)
   * file(TIMESTAMP <filename> <out-var> [...])
   * file(GET_RUNTIME_DEPENDENCIES [...])
```

## Writing：写文件

```cmake
   * file({WRITE | APPEND} <filename> <content>...)
   * file({TOUCH | TOUCH_NOCREATE} [<file>...])
   * file(GENERATE OUTPUT <output-file> [...])
```

## Filesystem：文件系统操作

```cmake
   * file({GLOB | GLOB_RECURSE} <out-var> [...] [<globbing-expr>...])
   * file(RENAME <oldname> <newname>)
   * file({REMOVE | REMOVE_RECURSE } [<files>...])
   * file(MAKE_DIRECTORY [<dir>...])
   * file({COPY | INSTALL} <file>... DESTINATION <dir> [...])
   * file(SIZE <filename> <out-var>)
   * file(READ_SYMLINK <linkname> <out-var>)
   * file(CREATE_LINK <original> <linkname> [...])
```

## Path Conversion：路径转换

```cmake
   * file(RELATIVE_PATH <out-var> <directory> <file>)
   * file({TO_CMAKE_PATH | TO_NATIVE_PATH} <path> <out-var>)
```

## Transfer：下载与上传

```cmake
   * file(DOWNLOAD <url> <file> [...])
   * file(UPLOAD <file> <url> [...])
```

## Locking：同步锁

```cmake
   * file(LOCK <path> [...])
```
