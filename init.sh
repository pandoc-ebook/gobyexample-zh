#!/bin/bash
test -d src && echo "already init" && exit 1 || mkdir src
test -d tmp || mkdir tmp
cd tmp
test -d gobyexample || git clone https://github.com/mmcgrana/gobyexample
cd gobyexample

REVISION=`git rev-parse HEAD`
echo $REVISION > ../../REVISION.txt

n=10000

function parse() {
	echo "::: {.en}" >> $md
	s="examples/$DIR/$DIR.$2"
	grep "$1 " $s |sed -r "s|[ ]*$1 ||g">> $md
	echo -e ":::\n\n" >> $md
	
	echo -e "::: {.zh}\n\n:::\n\n" >> $md
	
	echo "\`\`\`$2" >> $md
	grep -v "$1 " $s >> $md
	echo -e "\`\`\`\n\n" >> $md	
}

while read line;do
	DIR=`echo $line |tr -d "'"|tr ' /' '-' |tr '[A-Z]' '[a-z]' |sed -r 's/-+/-/g'`
	md="../../src/$n-$DIR.md"
	echo -e "\n# $line {.en}\n\n" > $md
	echo -e "\n# $line {.zh}\n\n" >> $md
	
	parse "//" go
	parse "#" sh
	((n=n+1))
done < examples.txt