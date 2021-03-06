#!/bin/bash

DIR=`cd $(dirname $0);pwd`
SRC="$DIR/src"
TMP="$DIR/tmp"
REVISION="$DIR/REVISION.txt"
DIFF="$DIR/diff"
TRANS=$DIR/tools/trans

function mkDir() {
	test -d $1 || mkdir $1
}

mkDir $TMP
mkDir $DIFF

cd tmp
test -d gobyexample || git clone https://github.com/mmcgrana/gobyexample
cd gobyexample && git pull

REV=`git rev-parse --short HEAD`
if [ -d $SRC ];then
	[ ! -f $REVISION ] && echo "$REVISION lost. Please re init" && exit 1
	OLDREV=`cat $REVISION`
	echo "already init."
	echo -e "see $DIFF/$REV-$OLDREV.diff\n\n"
	git diff HEAD $OLDREV  -- . ':!public' > $DIFF/$REV-$OLDREV.diff
	exit 
else
	mkDir $SRC
	echo $REV > $REVISION
fi

n=10000

function checkType() {
	echo "$1" |grep "^#" &>/dev/null && echo "comment" && return 0
	echo "$1" |grep -E "//\ " &>/dev/null && echo "comment" && return 0
	echo "code" && return 0
}

function writeComment() {
	fortrans=`echo "$comment" |sed 's/\\\n//g'`
	zhcomment=`$TRANS -brief :zh "$fortrans"`
	echo -e "::: {.en}$comment\n:::\n\n::: {.zh}\n" >> $markdown
	echo -e "$zhcomment" >> $markdown
	echo -e "\n:::\n\n" >> $markdown
}

function writeCode() {
	echo -e "\`\`\`$lang$code\n\`\`\`\n\n" >> $markdown
}

function parse() {
	lang=$1
	s="$TMP/gobyexample/examples/$2/$2.$lang"
	markdown=$3
	comment=""
	code=""
	first=`head -n 1 $s`
	current=`checkType "$first"`

	# IFS see https://stackoverflow.com/questions/7314044/use-bash-to-read-line-by-line-and-keep-space
	IFS=''
	while read c;do
		[ "$c"x == ""x ] && continue
		if [ $current == "comment" ];then
			if [ `checkType "$c"` == "comment" ];then
				comment="$comment\n`echo \"$c\" |sed -r 's#^(\ |\t)*//\ ##g'|sed -r 's/^# //g'`"
			else
				current="code"
				writeComment
				comment=""
				code="$code\n$c"
			fi
		elif [ $current == "code" ];then
			if [ `checkType "$c"` == "code" ];then
				code="$code\n$c"
			else
				current="comment"
				writeCode
				code=""
				comment="$comment\n`echo \"$c\" |sed -r 's#^(\ |\t)*//\ ##g'|sed -r 's/^# //g'`"
			fi
		fi
	done < $s
	[ "$comment"x != ""x ] && writeComment
	[ "$code"x != ""x ] && writeCode
}

if [ "$1"x == "-d"x ];then
	parse go $2 "$SRC/debug.md"
	parse sh $2 "$SRC/debug.md"
	exit 0
fi

while read line;do
	GODIR=`echo $line |tr -d "'"|tr ' /' '-' |tr '[A-Z]' '[a-z]' |sed -r 's/-+/-/g'`
	md="$SRC/$n-$GODIR.md"
	echo -e "\n# $line {.en}\n" > $md
	zhline=`$TRANS -b :zh "$line"`
	echo -e "\n# $zhline {.zh}\n\n" >> $md
	echo "init $GODIR"
	parse go $GODIR $md
	parse sh $GODIR $md
	((n=n+1))
done < examples.txt