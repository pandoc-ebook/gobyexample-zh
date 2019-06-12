
# Slices {.en}


# 片 {.zh}


::: {.en}
_Slices_ are a key data type in Go, giving a more
powerful interface to sequences than arrays.
:::

::: {.zh}

_Slices_是Go中的关键数据类型，为序列提供了比数组更强大的接口。

:::


```go
package main
import "fmt"
func main() {
```


::: {.en}
Unlike arrays, slices are typed only by the
elements they contain (not the number of elements).
To create an empty slice with non-zero length, use
the builtin `make`. Here we make a slice of
`string`s of length `3` (initially zero-valued).
:::

::: {.zh}

与数组不同，切片仅由它们包含的元素（不是元素数）键入。要创建长度非零的空切片，请使用内置的`make`。在这里，我们制作了一段长度为“3”的string（最初为零值）。

:::


```go
	s := make([]string, 3)
	fmt.Println("emp:", s)
```


::: {.en}
We can set and get just like with arrays.
:::

::: {.zh}

我们可以像数组一样设置和获取。

:::


```go
	s[0] = "a"
	s[1] = "b"
	s[2] = "c"
	fmt.Println("set:", s)
	fmt.Println("get:", s[2])
```


::: {.en}
`len` returns the length of the slice as expected.
:::

::: {.zh}

`len`按预期返回切片的长度。

:::


```go
	fmt.Println("len:", len(s))
```


::: {.en}
In addition to these basic operations, slices
support several more that make them richer than
arrays. One is the builtin `append`, which
returns a slice containing one or more new values.
Note that we need to accept a return value from
`append` as we may get a new slice value.
:::

::: {.zh}

除了这些基本操作之外，还支持几个使它们比阵列更丰富的切片。一个是内置`append`，它返回一个包含一个或多个新值的切片。注意我们需要接受来自`append'的返回值，因为我们可能得到一个新的切片值。

:::


```go
	s = append(s, "d")
	s = append(s, "e", "f")
	fmt.Println("apd:", s)
```


::: {.en}
Slices can also be `copy`'d. Here we create an
empty slice `c` of the same length as `s` and copy
into `c` from `s`.
:::

::: {.zh}

切片也可以“复制”。在这里，我们创建一个与`s`长度相同的空切片`c`，并从`s`复制到`c`。

:::


```go
	c := make([]string, len(s))
	copy(c, s)
	fmt.Println("cpy:", c)
```


::: {.en}
Slices support a "slice" operator with the syntax
`slice[low:high]`. For example, this gets a slice
of the elements `s[2]`, `s[3]`, and `s[4]`.
:::

::: {.zh}

切片支持“切片”运算符，其语法符号为“低：高”。例如，这得到了元素`s [2]`，`s [3]`和`s [4]`的切片。

:::


```go
	l := s[2:5]
	fmt.Println("sl1:", l)
```


::: {.en}
This slices up to (but excluding) `s[5]`.
:::

::: {.zh}

这切成了（但不包括）`s [5]`。

:::


```go
	l = s[:5]
	fmt.Println("sl2:", l)
```


::: {.en}
And this slices up from (and including) `s[2]`.
:::

::: {.zh}

这包括（包括）`s [2]`。

:::


```go
	l = s[2:]
	fmt.Println("sl3:", l)
```


::: {.en}
We can declare and initialize a variable for slice
in a single line as well.
:::

::: {.zh}

我们也可以在一行中声明和初始化slice的变量。

:::


```go
	t := []string{"g", "h", "i"}
	fmt.Println("dcl:", t)
```


::: {.en}
Slices can be composed into multi-dimensional data
structures. The length of the inner slices can
vary, unlike with multi-dimensional arrays.
:::

::: {.zh}

切片可以组成多维数据结构。与多维数组不同，内部切片的长度是可变的。

:::


```go
	twoD := make([][]int, 3)
	for i := 0; i < 3; i++ {
		innerLen := i + 1
		twoD[i] = make([]int, innerLen)
		for j := 0; j < innerLen; j++ {
			twoD[i][j] = i + j
		}
	}
	fmt.Println("2d: ", twoD)
}
```


::: {.en}
Note that while slices are different types than arrays,
they are rendered similarly by `fmt.Println`.
:::

::: {.zh}

请注意，虽然切片的类型与数组不同，但它们的类似地由`fmt.Println`呈现。

:::


```sh
$ go run slices.go
emp: [  ]
set: [a b c]
get: c
len: 3
apd: [a b c d e f]
cpy: [a b c d e f]
sl1: [c d e]
sl2: [a b c d e]
sl3: [c d e f]
dcl: [g h i]
2d:  [[0] [1 2] [2 3 4]]
```


::: {.en}
Check out this [great blog post](http://blog.golang.org/2011/01/go-slices-usage-and-internals.html)
by the Go team for more details on the design and
implementation of slices in Go.
Now that we've seen arrays and slices we'll look at
Go's other key builtin data structure: maps.
:::

::: {.zh}

查看Go团队的这篇[精彩博客文章]（http://blog.golang.org/2011/01/go-slices-usage-and-internals.html），了解有关Go中切片设计和实现的更多详细信息现在我们已经看过数组和切片，我们将看看Go的其他关键内置数据结构：地图。

:::


