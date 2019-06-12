
# Command-Line Flags {.en}


# 命令行标志 {.zh}


::: {.en}
[_Command-line flags_](http://en.wikipedia.org/wiki/Command-line_interface#Command-line_option)
are a common way to specify options for command-line
programs. For example, in `wc -l` the `-l` is a
command-line flag.
:::

::: {.zh}

[_Command-line flags_]（http://en.wikipedia.org/wiki/Command-line_interface#Command-line_option）是指定命令行程序选项的常用方法。例如，在`wc -l`中，`-l`是acommand-line标志。

:::


```go
package main
```


::: {.en}
Go provides a `flag` package supporting basic
command-line flag parsing. We'll use this package to
implement our example command-line program.
:::

::: {.zh}

Go提供了一个支持basiccommand-line标志解析的`flag`包。我们将使用此包来实现我们的示例命令行程序。

:::


```go
import "flag"
import "fmt"
func main() {
```


::: {.en}
Basic flag declarations are available for string,
integer, and boolean options. Here we declare a
string flag `word` with a default value `"foo"`
and a short description. This `flag.String` function
returns a string pointer (not a string value);
we'll see how to use this pointer below.
:::

::: {.zh}

基本标志声明可用于字符串，整数和布尔选项。这里我们声明astring标志`word`，默认值为“foo”和简短描述。这个`flag.String`函数返回一个字符串指针（不是字符串值）;我们将看到如何在下面使用这个指针。

:::


```go
	wordPtr := flag.String("word", "foo", "a string")
```


::: {.en}
This declares `numb` and `fork` flags, using a
similar approach to the `word` flag.
:::

::: {.zh}

这声明了`numb`和`fork`标志，使用与`word`标志类似的方法。

:::


```go
	numbPtr := flag.Int("numb", 42, "an int")
	boolPtr := flag.Bool("fork", false, "a bool")
```


::: {.en}
It's also possible to declare an option that uses an
existing var declared elsewhere in the program.
Note that we need to pass in a pointer to the flag
declaration function.
:::

::: {.zh}

也可以声明一个使用在程序中其他地方声明的现有var的选项。注意我们需要传入一个指向flagdeclaration函数的指针。

:::


```go
	var svar string
	flag.StringVar(&svar, "svar", "bar", "a string var")
```


::: {.en}
Once all flags are declared, call `flag.Parse()`
to execute the command-line parsing.
:::

::: {.zh}

声明所有标志后，调用`flag.Parse（）`来执行命令行解析。

:::


```go
	flag.Parse()
```


::: {.en}
Here we'll just dump out the parsed options and
any trailing positional arguments. Note that we
need to dereference the pointers with e.g. `*wordPtr`
to get the actual option values.
:::

::: {.zh}

在这里，我们只会转出已解析的选项和任何尾随位置参数。请注意，我们需要取消引用指针，例如`* wordPtr`获取实际选项值。

:::


```go
	fmt.Println("word:", *wordPtr)
	fmt.Println("numb:", *numbPtr)
	fmt.Println("fork:", *boolPtr)
	fmt.Println("svar:", svar)
	fmt.Println("tail:", flag.Args())
}
```


::: {.en}
To experiment with the command-line flags program it's
best to first compile it and then run the resulting
binary directly.
:::

::: {.zh}

要试验命令行标志程序，首先要编译它然后直接运行结果二进制文件。

:::


```bash
$ go build command-line-flags.go
```


::: {.en}
Try out the built program by first giving it values for
all flags.
:::

::: {.zh}

通过首先给它值forall标志来尝试构建的程序。

:::


```bash
$ ./command-line-flags -word=opt -numb=7 -fork -svar=flag
word: opt
numb: 7
fork: true
svar: flag
tail: []
```


::: {.en}
Note that if you omit flags they automatically take
their default values.
:::

::: {.zh}

请注意，如果省略标记，它们会自动获取默认值。

:::


```bash
$ ./command-line-flags -word=opt
word: opt
numb: 42
fork: false
svar: bar
tail: []
```


::: {.en}
Trailing positional arguments can be provided after
any flags.
:::

::: {.zh}

可以在后面的标志中提供尾随位置参数。

:::


```bash
$ ./command-line-flags -word=opt a1 a2 a3
word: opt
...
tail: [a1 a2 a3]
```


::: {.en}
Note that the `flag` package requires all flags to
appear before positional arguments (otherwise the flags
will be interpreted as positional arguments).
:::

::: {.zh}

请注意，`flag`包需要在位置参数之前出现所有标志（否则标志将被解释为位置参数）。

:::


```bash
$ ./command-line-flags -word=opt a1 a2 a3 -numb=7
word: opt
numb: 42
fork: false
svar: bar
tail: [a1 a2 a3 -numb=7]
```


::: {.en}
Use `-h` or `--help` flags to get automatically
generated help text for the command-line program.
:::

::: {.zh}

使用`-h`或`--help`标志来获取命令行程序的自动生成的帮助文本。

:::


```bash
$ ./command-line-flags -h
Usage of ./command-line-flags:
  -fork=false: a bool
  -numb=42: an int
  -svar="bar": a string var
  -word="foo": a string
```


::: {.en}
If you provide a flag that wasn't specified to the
`flag` package, the program will print an error message
and show the help text again.
:::

::: {.zh}

如果您提供未指定给`flag`包的标志，程序将打印错误消息并再次显示帮助文本。

:::


```bash
$ ./command-line-flags -wat
flag provided but not defined: -wat
Usage of ./command-line-flags:
...
```


::: {.en}
Next we'll look at environment variables, another common
way to parameterize programs.
:::

::: {.zh}

接下来我们将看一下环境变量，这是另一个参数化程序的常用方法。

:::


