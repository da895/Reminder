#! /bin/bash

 sed -i '/^$/d' dir.tmp
 sed -i 's/^ \(.*\)/\1/g' dir.tmp
 sort -u dir.tmp -o dir.tmp
 sed -i ':a;N;$!ba;s/\n/ /g' dir.tmp
# tr -d '\n' < dir.tmp > dir1.tmp
