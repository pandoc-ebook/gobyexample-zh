
# Regular Expressions {.en}


# 常用表达 {.zh}


::: {.en}
Go offers built-in support for [regular expressions](http://en.wikipedia.org/wiki/Regular_expression).
Here are some examples of  common regexp-related tasks
in Go.
:::

::: {.zh}

Go为[正则表达式]提供内置支持（http://en.wikipedia.org/wiki/Regular_expression）。这是Go中常见的正则表达式相关任务的一些示例。

:::


```go
package main
import "bytes"
import "fmt"
import "regexp"
func main() {
```


::: {.en}
This tests whether a pattern matches a string.
:::

::: {.zh}

这将测试模式是否与字符串匹配。

:::


```go
	match, _ := regexp.MatchString("p([a-z]+)ch", "peach")
	fmt.Println(match)
```


::: {.en}
Above we used a string pattern directly, but for
other regexp tasks you'll need to `Compile` an
optimized `Regexp` struct.
:::

::: {.zh}

上面我们直接使用了一个字符串模式，但是对于其他正则表达式任务，你需要`编译'优化的`Regexp`结构。

:::


```go
	r, _ := regexp.Compile("p([a-z]+)ch")
```


::: {.en}
Many methods are available on these structs. Here's
a match test like we saw earlier.
:::

::: {.zh}

这些结构有许多方法可供使用。这是我们之前看到的匹配测试。

:::


```go
	fmt.Println(r.MatchString("peach"))
```


::: {.en}
This finds the match for the regexp.
:::

::: {.zh}

这会找到正则表达式的匹配项。

:::


```go
	fmt.Println(r.FindString("peach punch"))
```


::: {.en}
This also finds the first match but returns the
start and end indexes for the match instead of the
matching text.
:::

::: {.zh}

这也会找到第一个匹配但返回匹配的开始和结束索引而不是匹配文本。

:::


```go
	fmt.Println(r.FindStringIndex("peach punch"))
```


::: {.en}
The `Submatch` variants include information about
both the whole-pattern matches and the submatches
within those matches. For example this will return
information for both `p([a-z]+)ch` and `([a-z]+)`.
:::

::: {.zh}

“Submatch”变体包括有关整个模式匹配的信息以及这些匹配中的子匹配。例如，这将返回'p（[a-z] +）ch`和`（[a-z] +）`的信息。

:::


```go
	fmt.Println(r.FindStringSubmatch("peach punch"))
```


::: {.en}
Similarly this will return information about the
indexes of matches and submatches.
:::

::: {.zh}

同样，这将返回有关匹配和子匹配的索引的信息。

:::


```go
	fmt.Println(r.FindStringSubmatchIndex("peach punch"))
```


::: {.en}
The `All` variants of these functions apply to all
matches in the input, not just the first. For
example to find all matches for a regexp.
:::

::: {.zh}

这些函数的“All”变体适用于输入中的所有匹配，而不仅仅是第一个。例如，查找正则表达式的所有匹配项。

:::


```go
	fmt.Println(r.FindAllString("peach punch pinch", -1))
```


::: {.en}
These `All` variants are available for the other
functions we saw above as well.
:::

::: {.zh}

这些“All”变体也适用于我们上面看到的其他功能。

:::


```go
	fmt.Println(r.FindAllStringSubmatchIndex(
		"peach punch pinch", -1))
```


::: {.en}
Providing a non-negative integer as the second
argument to these functions will limit the number
of matches.
:::

::: {.zh}

提供非负整数作为这些函数的第二个参数将限制匹配的数量。

:::


```go
	fmt.Println(r.FindAllString("peach punch pinch", 2))
```


::: {.en}
Our examples above had string arguments and used
names like `MatchString`. We can also provide
`[]byte` arguments and drop `String` from the
function name.
:::

::: {.zh}

我们上面的例子有字符串参数和用过的名字，比如`MatchString`。我们还可以提供`[] byte`参数并从函数名称中删除`String`。

:::


```go
	fmt.Println(r.Match([]byte("peach")))
```


::: {.en}
When creating constants with regular expressions
you can use the `MustCompile` variation of
`Compile`. A plain `Compile` won't work for
constants because it has 2 return values.
:::

::: {.zh}

使用正则表达式创建常量时，可以使用`Compile`的`MustCompile`变体。普通的“编译”对于常量不起作用，因为它有2个返回值。

:::


```go
	r = regexp.MustCompile("p([a-z]+)ch")
	fmt.Println(r)
```


::: {.en}
The `regexp` package can also be used to replace
subsets of strings with other values.
:::

::: {.zh}

`regexp`包也可用于替换其他值的字符串子集。

:::


```go
	fmt.Println(r.ReplaceAllString("a peach", "<fruit>"))
```


::: {.en}
The `Func` variant allows you to transform matched
text with a given function.
:::

::: {.zh}

`Func`变体允许您使用给定函数转换matchedtext。

:::


```go
	in := []byte("a peach")
	out := r.ReplaceAllFunc(in, bytes.ToUpper)
	fmt.Println(string(out))
}
```


```sh
$ go run regular-expressions.go 
true
true
peach
[0 5]
[peach ea]
[0 5 1 3]
[peach punch pinch]
[[0 5 1 3] [6 11 7 9] [12 17 13 15]]
[peach punch]
true
p([a-z]+)ch
a <fruit>
a PEACH
```


::: {.en}
For a complete reference on Go regular expressions check
the [`regexp`](http://golang.org/pkg/regexp/) package docs.
:::

::: {.zh}

有关Go正则表达式的完整参考，请查看[`regexp`]（http://golang.org/pkg/regexp/）包文档。

:::


