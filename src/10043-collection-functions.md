
# Collection Functions {.en}


# 收集功能 {.zh}


::: {.en}
We often need our programs to perform operations on
collections of data, like selecting all items that
satisfy a given predicate or mapping all items to a new
collection with a custom function.
In some languages it's idiomatic to use [generic](http://en.wikipedia.org/wiki/Generic_programming)
data structures and algorithms. Go does not support
generics; in Go it's common to provide collection
functions if and when they are specifically needed for
your program and data types.
Here are some example collection functions for slices
of `strings`. You can use these examples to build your
own functions. Note that in some cases it may be
clearest to just inline the collection-manipulating
code directly, instead of creating and calling a
helper function.
:::

::: {.zh}

我们经常需要我们的程序来执行数据收集操作，例如选择满足给定谓词的所有项目或使用自定义函数将所有项目映射到newcollection。在某些语言中，使用[generic]（http：//en.wikipedia）是惯用的.org / wiki / Generic_programming）数据结构和算法。 Go不支持generics;在Go中，如果你的程序和数据类型特别需要它们，那么提供集合函数是很常见的。这里是一些用于sliceof`chace`的示例集合函数。您可以使用这些示例来构建自己的函数。请注意，在某些情况下，最简单的方法是直接内联集合操作代码，而不是创建和调用ahelper函数。

:::


```go
package main
import "strings"
import "fmt"
```


::: {.en}
Index returns the first index of the target string `t`, or
-1 if no match is found.
:::

::: {.zh}

Index返回目标字符串`t`的第一个索引，如果未找到匹配则返回-1。

:::


```go
func Index(vs []string, t string) int {
	for i, v := range vs {
		if v == t {
			return i
		}
	}
	return -1
}
```


::: {.en}
Include returns `true` if the target string t is in the
slice.
:::

::: {.zh}

如果目标字符串t在theslice中，则包含返回“true”。

:::


```go
func Include(vs []string, t string) bool {
	return Index(vs, t) >= 0
}
```


::: {.en}
Any returns `true` if one of the strings in the slice
satisfies the predicate `f`.
:::

::: {.zh}

如果切片中的一个字符串满足谓词“f”，则任何返回“true”。

:::


```go
func Any(vs []string, f func(string) bool) bool {
	for _, v := range vs {
		if f(v) {
			return true
		}
	}
	return false
}
```


::: {.en}
All returns `true` if all of the strings in the slice
satisfy the predicate `f`.
:::

::: {.zh}

如果slice中的所有字符串都满足谓词`f`，则all返回`true`。

:::


```go
func All(vs []string, f func(string) bool) bool {
	for _, v := range vs {
		if !f(v) {
			return false
		}
	}
	return true
}
```


::: {.en}
Filter returns a new slice containing all strings in the
slice that satisfy the predicate `f`.
:::

::: {.zh}

Filter返回一个新切片，其中包含满足谓词`f`的所有字符串。

:::


```go
func Filter(vs []string, f func(string) bool) []string {
	vsf := make([]string, 0)
	for _, v := range vs {
		if f(v) {
			vsf = append(vsf, v)
		}
	}
	return vsf
}
```


::: {.en}
Map returns a new slice containing the results of applying
the function `f` to each string in the original slice.
:::

::: {.zh}

Map返回一个新切片，其中包含将函数`f`应用于原始切片中每个字符串的结果。

:::


```go
func Map(vs []string, f func(string) string) []string {
	vsm := make([]string, len(vs))
	for i, v := range vs {
		vsm[i] = f(v)
	}
	return vsm
}
func main() {
```


::: {.en}
Here we try out our various collection functions.
:::

::: {.zh}

在这里，我们尝试各种收集功能。

:::


```go
	var strs = []string{"peach", "apple", "pear", "plum"}
	fmt.Println(Index(strs, "pear"))
	fmt.Println(Include(strs, "grape"))
	fmt.Println(Any(strs, func(v string) bool {
		return strings.HasPrefix(v, "p")
	}))
	fmt.Println(All(strs, func(v string) bool {
		return strings.HasPrefix(v, "p")
	}))
	fmt.Println(Filter(strs, func(v string) bool {
		return strings.Contains(v, "e")
	}))
```


::: {.en}
The above examples all used anonymous functions,
but you can also use named functions of the correct
type.
:::

::: {.zh}

以上示例都使用了匿名函数，但您也可以使用correcttype的命名函数。

:::


```go
	fmt.Println(Map(strs, strings.ToUpper))
}
```


```bash
$ go run collection-functions.go 
2
false
true
false
[peach apple pear]
[PEACH APPLE PEAR PLUM]
```


