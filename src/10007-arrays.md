
# Arrays {.en}


# 数组 {.zh}


::: {.en}
In Go, an _array_ is a numbered sequence of elements of a
specific length.
:::

::: {.zh}

在Go中，__ array__是特定长度的元素的编号序列。

:::


```go
package main
import "fmt"
func main() {
```


::: {.en}
Here we create an array `a` that will hold exactly
5 `int`s. The type of elements and length are both
part of the array's type. By default an array is
zero-valued, which for `int`s means `0`s.
:::

::: {.zh}

在这里，我们创建一个数组`a`，它将完全包含5`int`s。元素的类型和长度都是数组类型的一部分。默认情况下，数组是零值，对于`int`s表示'0'。

:::


```go
	var a [5]int
	fmt.Println("emp:", a)
```


::: {.en}
We can set a value at an index using the
`array[index] = value` syntax, and get a value with
`array[index]`.
:::

::: {.zh}

我们可以使用`array [index] = value`语法在索引处设置一个值，并使用`array [index]`获取一个值。

:::


```go
	a[4] = 100
	fmt.Println("set:", a)
	fmt.Println("get:", a[4])
```


::: {.en}
The builtin `len` returns the length of an array.
:::

::: {.zh}

内置的`len`返回数组的长度。

:::


```go
	fmt.Println("len:", len(a))
```


::: {.en}
Use this syntax to declare and initialize an array
in one line.
:::

::: {.zh}

使用此语法在一行中声明和初始化数组。

:::


```go
	b := [5]int{1, 2, 3, 4, 5}
	fmt.Println("dcl:", b)
```


::: {.en}
Array types are one-dimensional, but you can
compose types to build multi-dimensional data
structures.
:::

::: {.zh}

数组类型是一维的，但您可以组合类型来构建多维数据结构。

:::


```go
	var twoD [2][3]int
	for i := 0; i < 2; i++ {
		for j := 0; j < 3; j++ {
			twoD[i][j] = i + j
		}
	}
	fmt.Println("2d: ", twoD)
}
```


::: {.en}
Note that arrays appear in the form `[v1 v2 v3 ...]`
when printed with `fmt.Println`.
:::

::: {.zh}

请注意，当使用`fmt.Println`打印时，数组以“[v1 v2 v3 ...]`”的形式出现。

:::


```bash
$ go run arrays.go
emp: [0 0 0 0 0]
set: [0 0 0 0 100]
get: 100
len: 5
dcl: [1 2 3 4 5]
2d:  [[0 1 2] [1 2 3]]
```


::: {.en}
You'll see _slices_ much more often than arrays in
typical Go. We'll look at slices next.
:::

::: {.zh}

你会看到_slices_比阵列不典型的Go更常见。我们接下来会看片。

:::


