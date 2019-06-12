
# String Formatting {.en}


# 字符串格式 {.zh}


::: {.en}
Go offers excellent support for string formatting in
the `printf` tradition. Here are some examples of
common string formatting tasks.
:::

::: {.zh}

Go为`printf`传统中的字符串格式提供了出色的支持。以下是常见字符串格式化任务的一些示例。

:::


```go
package main
import "fmt"
import "os"
type point struct {
	x, y int
}
func main() {
```


::: {.en}
Go offers several printing "verbs" designed to
format general Go values. For example, this prints
an instance of our `point` struct.
:::

::: {.zh}

Go提供了几个印刷“动词”设计toformat一般Go值。例如，这打印了我们的`point`结构的实例。

:::


```go
	p := point{1, 2}
	fmt.Printf("%vn", p)
```


::: {.en}
If the value is a struct, the `%+v` variant will
include the struct's field names.
:::

::: {.zh}

如果值是结构，则`％+ v`变量将包含结构的字段名称。

:::


```go
	fmt.Printf("%+vn", p)
```


::: {.en}
The `%#v` variant prints a Go syntax representation
of the value, i.e. the source code snippet that
would produce that value.
:::

::: {.zh}

`％＃v`变体打印值的i语法表示。将生成该值的源代码段。

:::


```go
	fmt.Printf("%#vn", p)
```


::: {.en}
To print the type of a value, use `%T`.
:::

::: {.zh}

要打印值的类型，请使用`％T`。

:::


```go
	fmt.Printf("%Tn", p)
```


::: {.en}
Formatting booleans is straight-forward.
:::

::: {.zh}

格式化布尔值是直截了当的。

:::


```go
	fmt.Printf("%tn", true)
```


::: {.en}
There are many options for formatting integers.
Use `%d` for standard, base-10 formatting.
:::

::: {.zh}

格式化整数有很多选项。使用`％d`作为标准的基础10格式。

:::


```go
	fmt.Printf("%dn", 123)
```


::: {.en}
This prints a binary representation.
:::

::: {.zh}

这将打印二进制表示。

:::


```go
	fmt.Printf("%bn", 14)
```


::: {.en}
This prints the character corresponding to the
given integer.
:::

::: {.zh}

这将打印与给定整数对应的字符。

:::


```go
	fmt.Printf("%cn", 33)
```


::: {.en}
`%x` provides hex encoding.
:::

::: {.zh}

`％x`提供十六进制编码。

:::


```go
	fmt.Printf("%xn", 456)
```


::: {.en}
There are also several formatting options for
floats. For basic decimal formatting use `%f`.
:::

::: {.zh}

浮动还有几种格式化选项。对于基本的十进制格式，请使用`％f`。

:::


```go
	fmt.Printf("%fn", 78.9)
```


::: {.en}
`%e` and `%E` format the float in (slightly
different versions of) scientific notation.
:::

::: {.zh}

`％e`和`％E`格式化浮点数（略有不同版本）的科学记数法。

:::


```go
	fmt.Printf("%en", 123400000.0)
	fmt.Printf("%En", 123400000.0)
```


::: {.en}
For basic string printing use `%s`.
:::

::: {.zh}

对于基本字符串打印，请使用`％s`。

:::


```go
	fmt.Printf("%sn", ""string"")
```


::: {.en}
To double-quote strings as in Go source, use `%q`.
:::

::: {.zh}

要像Go源一样双引号字符串，请使用`％q`。

:::


```go
	fmt.Printf("%qn", ""string"")
```


::: {.en}
As with integers seen earlier, `%x` renders
the string in base-16, with two output characters
per byte of input.
:::

::: {.zh}

与前面看到的整数一样，`％x`在base-16中呈现字符串，两个输出字符为输入字节。

:::


```go
	fmt.Printf("%xn", "hex this")
```


::: {.en}
To print a representation of a pointer, use `%p`.
:::

::: {.zh}

要打印指针的表示，请使用`％p`。

:::


```go
	fmt.Printf("%pn", &p)
```


::: {.en}
When formatting numbers you will often want to
control the width and precision of the resulting
figure. To specify the width of an integer, use a
number after the `%` in the verb. By default the
result will be right-justified and padded with
spaces.
:::

::: {.zh}

格式化数字时，您通常需要控制生成图形的宽度和精度。要指定整数的宽度，请在动词中的`％`之后使用数字。默认情况下，结果将是右对齐的并用空格填充。

:::


```go
	fmt.Printf("|%6d|%6d|n", 12, 345)
```


::: {.en}
You can also specify the width of printed floats,
though usually you'll also want to restrict the
decimal precision at the same time with the
width.precision syntax.
:::

::: {.zh}

您也可以指定打印浮动的宽度，但通常您也希望使用width.precision语法同时限制十进制精度。

:::


```go
	fmt.Printf("|%6.2f|%6.2f|n", 1.2, 3.45)
```


::: {.en}
To left-justify, use the `-` flag.
:::

::: {.zh}

要左对齐，请使用`-`标志。

:::


```go
	fmt.Printf("|%-6.2f|%-6.2f|n", 1.2, 3.45)
```


::: {.en}
You may also want to control width when formatting
strings, especially to ensure that they align in
table-like output. For basic right-justified width.
:::

::: {.zh}

您可能还希望在格式化字符串时控制宽度，尤其是确保它们对齐类似于intable的输出。对于基本右对齐宽度。

:::


```go
	fmt.Printf("|%6s|%6s|n", "foo", "b")
```


::: {.en}
To left-justify use the `-` flag as with numbers.
:::

::: {.zh}

左对齐使用`-`标志和数字一样。

:::


```go
	fmt.Printf("|%-6s|%-6s|n", "foo", "b")
```


::: {.en}
So far we've seen `Printf`, which prints the
formatted string to `os.Stdout`. `Sprintf` formats
and returns a string without printing it anywhere.
:::

::: {.zh}

到目前为止，我们已经看过`Printf`，它将格式化的字符串打印到`os.Stdout`。 `Sprintf`格式并返回一个字符串而不在任何地方打印它。

:::


```go
	s := fmt.Sprintf("a %s", "string")
	fmt.Println(s)
```


::: {.en}
You can format+print to `io.Writers` other than
`os.Stdout` using `Fprintf`.
:::

::: {.zh}

您可以使用`Fprintf`格式化+打印到`o.S.out`以外的`io.Writers`。

:::


```go
	fmt.Fprintf(os.Stderr, "an %sn", "error")
}
```


```sh
$ go run string-formatting.go
{1 2}
{x:1 y:2}
main.point{x:1, y:2}
main.point
true
123
1110
!
1c8
78.900000
1.234000e+08
1.234000E+08
"string"
""string""
6865782074686973
0x42135100
|    12|   345|
|  1.20|  3.45|
|1.20  |3.45  |
|   foo|     b|
|foo   |b     |
a string
an error
```


