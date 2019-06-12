
# String Functions {.en}


# 字符串函数 {.zh}


::: {.en}
The standard library's `strings` package provides many
useful string-related functions. Here are some examples
to give you a sense of the package.
:::

::: {.zh}

标准库的`strings`包提供了许多有用的字符串相关函数。以下是一些示例，让您了解包装。

:::


```go
package main
import s "strings"
import "fmt"
```


::: {.en}
We alias `fmt.Println` to a shorter name as we'll use
it a lot below.
:::

::: {.zh}

我们将`fmt.Println`别名为一个较短的名称，因为我们将在下面使用很多。

:::


```go
var p = fmt.Println
func main() {
```


::: {.en}
Here's a sample of the functions available in
`strings`. Since these are functions from the
package, not methods on the string object itself,
we need pass the string in question as the first
argument to the function. You can find more
functions in the [`strings`](http://golang.org/pkg/strings/)
package docs.
:::

::: {.zh}

这是strings中可用函数的示例。由于这些是来自包的函数，而不是字符串对象本身的方法，我们需要将有问题的字符串作为函数的第一个参数传递。您可以在[`strings`]（http://golang.org/pkg/strings/）包文档中找到更多功能。

:::


```go
	p("Contains:  ", s.Contains("test", "es"))
	p("Count:     ", s.Count("test", "t"))
	p("HasPrefix: ", s.HasPrefix("test", "te"))
	p("HasSuffix: ", s.HasSuffix("test", "st"))
	p("Index:     ", s.Index("test", "e"))
	p("Join:      ", s.Join([]string{"a", "b"}, "-"))
	p("Repeat:    ", s.Repeat("a", 5))
	p("Replace:   ", s.Replace("foo", "o", "0", -1))
	p("Replace:   ", s.Replace("foo", "o", "0", 1))
	p("Split:     ", s.Split("a-b-c-d-e", "-"))
	p("ToLower:   ", s.ToLower("TEST"))
	p("ToUpper:   ", s.ToUpper("test"))
	p()
```


::: {.en}
Not part of `strings`, but worth mentioning here, are
the mechanisms for getting the length of a string in
bytes and getting a byte by index.
:::

::: {.zh}

不是`strings`的一部分，但值得一提的是，以字节为单位获取字符串长度并按索引获取字节的机制。

:::


```go
	p("Len: ", len("hello"))
	p("Char:", "hello"[1])
}
```


::: {.en}
Note that `len` and indexing above work at the byte level.
Go uses UTF-8 encoded strings, so this is often useful
as-is. If you're working with potentially multi-byte
characters you'll want to use encoding-aware operations.
See [strings, bytes, runes and characters in Go](https://blog.golang.org/strings)
for more information.
:::

::: {.zh}

请注意，`len`和索引在字节级别上工作.Go使用UTF-8编码的字符串，因此通常使用fulas-is。如果您正在使用可能的多字节字符，则需要使用编码感知操作。有关详细信息，请参阅Go中的[字符串，字节，符文和字符]（https://blog.golang.org/strings）。

:::


```bash
$ go run string-functions.go
Contains:   true
Count:      2
HasPrefix:  true
HasSuffix:  true
Index:      1
Join:       a-b
Repeat:     aaaaa
Replace:    f00
Replace:    f0o
Split:      [a b c d e]
ToLower:    test
ToUpper:    TEST
Len:  5
Char: 101
```


