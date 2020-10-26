cmake函数: get_filename_component

```
# get component of filename
#       DIRECTORY
#       NAME ABSOULTE
#       NAME_WE ABSOULTE
#       NAME_WLE ABSOULTE
#       EXT  ABSOULTE
#       LAST_EXT ABSOULTE
#
#       ABSOLUTE
#       ABSOLUTE BASE_DIR
#
#       REALPATH
#       REALPATH BASE_DIR
#
#       PROGRAM
#       PROGRAM ARGS
```


目录


<!-- vim-markdown-toc GitLab -->

* [get_filename_component:获取完整文件名的特定部分](#get_filename_component获取完整文件名的特定部分)
* [get_filename_component(<var> <FileName> <mode> [BASE_DIR <dir>] [CACHE])  指定路径与文件名进行拼接](#get_filename_componentvar-filename-mode-base_dir-dir-cache-指定路径与文件名进行拼接)
* [get_filename_component(<var> <FileNae> PROGRAM [PROGRAM_ARGS <arg_var>] [CACHE]) 获取应用程序的名称和参数](#get_filename_componentvar-filenae-program-program_args-arg_var-cache-获取应用程序的名称和参数)

<!-- vim-markdown-toc -->

```
get_filename_component(<var> <Filename> <mode> [CACHE])
get_filename_component(<var> <FileName> <mode> [BASE_DIR <dir>] [CACHE])
get_filename_component(<var> <FileNae> PROGRAM [PROGRAM_ARGS <arg_var>] [CACHE])
```    

## get_filename_component:获取完整文件名的特定部分
get_filename_component(<var> <Filename> <mode> [CACHE]) 字符串解析处理
    可取值范围：
  * DICECTORY：没有文件名的目录，路径返回时带有正斜杠，并且没有尾部斜杠。
  * NAME：不带名录的文件名
  * EXT：文件名的最长扩展名
  * NAME_WE：不带目录或最长扩展名的文件名
  * LAST_EXT：文件名的最后扩展名
  * NAME_WLE：文件目录或最后扩展名的文件名
  * PATH：DIRECTORY的就别名（cmake <= 2.8.11）
        

```
SET(filename /tmp/cmake.dat.log.tmp)
get_filename_component(d ${filename} DIRECTORY)
get_filename_component(n ${filename} NAME ABSOLUTE)
get_filename_component(nw ${filename} NAME_WE ABSOLUTE)
get_filename_component(nwl ${filename} NAME_WLE ABSOLUTE)
get_filename_component(e ${filename} EXT ABSOLUTE)
get_filename_component(le ${filename} LAST_EXT ABSOLUTE)

message("${filename} DIRECTOYR:${d}")
message("${filename} NAME:${n}")
message("${filename} NAME_WE:${nw}")
message("${filename} NAME_WLE:${nwl}")
message("${filename} EXT:${e}")
message("${filename} LAST_EXT:${le}")

# output
/tmp/cmake.data.log.tmp DIRECTOYR:/tmp
/tmp/cmake.data.log.tmp NAME:cmake.dat.log.tmp
/tmp/cmake.data.log.tmp NAME_WE:cmake
/tmp/cmake.data.log.tmp NAME_WLE:cmake.dat.log
/tmp/cmake.data.log.tmp EXT:.dat.log.tmp

/tmp/cmake.data.log.tmp LAST_EXT:.tmp
```

## get_filename_component(<var> <FileName> <mode> [BASE_DIR <dir>] [CACHE])  指定路径与文件名进行拼接
​    可取值范围为
​        ABSOLUTE：文件的完整路径
​        

```
get_filename_component(absolute_file_name "cmake.dat" ABSOLUTE)
message("CMAKE_CURRENT_SOURCE_DIR: ${CMAKE_CURRENT_SOURCE_DIR}")
message("absolute_file_name: ${absolute_file_name}")

set(base_dir "/tmp/")
get_filename_component(absolute_file_name "cmake.dat" ABSOLUTE BASE_DIR ${base_dir})
message("absolute_file_name: ${absolute_file_name}")

# output
CMAKE_CURRENT_SOURCE_DIR: /home/fl/tmp/test_cmake
absolute_file_name: /home/fl/tmp/test_cmake/cmake.dat

absolute_file_name: /tmp/cmake.dat
```

REALPATH：如果为链接文件，则显示完整路径

```
get_filename_component(relative_file_name "srs_tree" REALPATH)
message("CMAKE_CURRENT_SOURCE_DIR: ${CMAKE_CURRENT_SOURCE_DIR}")
message("relative_file_name: ${relative_file_name}")

set(base_dir "/test_source/")
get_filename_component(relative_file_name "test_tree" REALPATH BASE_DIR ${base_dir})
message("relative_file_name: ${relative_file_name}")

# output
CMAKE_CURRENT_SOURCE_DIR: /home/fl/tmp/av_io
relative_file_name: /home/fl/test_tree

    relative_file_name: /test_source/srs_tree
```

## get_filename_component(<var> <FileNae> PROGRAM [PROGRAM_ARGS <arg_var>] [CACHE]) 获取应用程序的名称和参数

```
get_filename_component(program "ls -l -h" PROGRAM PROGRAM_ARGS args)
message("program: ${program}")
message("args: ${args}")

# output 系统可识别程序
program: /usr/bin/ls
args:  -l -h

get_filename_component(program "lm -l -h" PROGRAM PROGRAM_ARGS args)
message("program: ${program}")
message("args: ${args}")

# output 不可识别程序
program: 
args: 
```
