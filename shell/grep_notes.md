
# Grep 
Grep -- Global Regular Expression Print. 全局正则表达式， 是Linux系统中一种强大的文本搜索工具。  

1. 格式  
   `grep [options] ` 
2. 常用参数  
   ```
   -r   :  recursively, Read all files under each directory
   -d n :  忽略子目录n
   -n   :  显示匹配行及行号
   -w   :  全字匹配
   -o   :  只显示文件匹配到的部分
   -c   ： 只输出匹配行的计数
   -i   :  不区分大小写
   -h   :  查询多文件时不显示文件名
   -l   :  只输出包含匹配字符的文件名
   -L   ： 列出不匹配的文件名
   -s   :  不显示不存在或无匹配文本的错误信息
   -A n :  显示匹配行及匹配行后n行
   -B n :  显示匹配行及匹配行前n行
   -C n :  显示匹配的上下文各n行
   -v   :  显示所有未匹配行
   ```  
3. Pattern常用参数  
   ```
   \            : escape the meta-characters
   ^            : Beginning of one line
   $            : End of one line
   [ ]          : Character Classes
   [^ ]         : any character NOT in the list
   \w           : a synonym for [_[:alnum:]]
   \W           : a synonym for [^_[:alnum:]]
   \<           : the empty string at the beginning of a word
   \>           : the empty string at the end of a word
   \b           : the empty string at the edge of a word
   [[:alnum:]]  : the character class of numbers and letters in the current locale. In the C locale and ASCII character set encoding, this is the same as [0-9A-Za-z]
   [[:upper:]]  : [A-Z]
   [[:lower:]]  : [a-z]
   [[:digit:]]  : [0-9]
   [[:space:]]  : space or tab
   [[:alpha:]]  : [a-zA-Z]
   ?            : at most once
   *            : zero or more times
   +            : one or  more times
   {n}          : exactly n times
   {n,}         : n or more times
   {,m}         : at most m times
   {n,m}        : at least n times, but not more than m times
   ```  
4. Examples  
   * `grep 'test' d*`  
      显示所有以d开头的文件中包含test的行  
   * `grep 'test' aa bb cc`  
      显示在aa bb cc文件中包含test的行  
   * `grep '[a-z]\{5\}' aa`  
      在aa文件中查找包含5个连续小写字符的行
   * `grep 'w\(es\)t.*\1' aa`  
      如果west被匹配，则es被存储在标记为1的内存中，然后继续搜索任意个字符(.*),这些字符后面紧跟着另外一个es(\1), 找到就显示该行。如果用egrep或grep -E, 就不用“\”进行转义,直接写`w(es)t.*\1`就可以了。  
    * `grep -n "48" data.doc`  
      显示所有匹配48的行和行号
    * `grep -c "48" data.doc`  
      显示data.doc中含有48字符的行数
    * `grep -vn "48" data.doc`  
      显示所有不包含48的行
    * `grep -E "[1-9]+"`  
      使用扩展正则表达式  
    * `grep "pattern" file_name --color=auto`  
      标记匹配颜色  
    * 只输出文件中匹配到的部分-__o__选项  
      ```
      echo this is a test line. | grep -o -E "[a-z]+\."
      line.
      或者  
      echo this is a test line. | egrep -o "[a-z]+\."
      line.
      ```  
    * 在grep搜索结果中包括或者排除指定文件  
      ```
      #只在目录中所有的.php和.html文件中递归搜索字符"main()"  
      grep "main()" . -r --include *.{php,html}  

      #在搜索结果中排除所有README文件  
      grep "main()" . -r --exclude "README"  

      #在搜索结果中排除filelist文件列表里的文件  
      grep "main()" . -r --exclude-from filelist  
      ```  
    * 同时匹配ABC和123  
      `grep -E '(ABC.*123|123.*ABC)'`
    * 匹配ABC或者123  
      `grep -E '(ABC|123)'` 或 `egrep 'ABC|123'`  
    