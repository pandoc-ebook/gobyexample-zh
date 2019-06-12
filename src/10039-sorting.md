
# Sorting {.en}


# 排序 {.zh}


::: {.en}
Go's `sort` package implements sorting for builtins
and user-defined types. We'll look at sorting for
builtins first.
:::

::: {.zh}

Go的`sort`包实现了对builtins和用户定义类型的排序。我们先来看看对于建筑物的分类。

:::


```go
package main
import "fmt"
import "sort"
func main() {
```


::: {.en}
Sort methods are specific to the builtin type;
here's an example for strings. Note that sorting is
in-place, so it changes the given slice and doesn't
return a new one.
:::

::: {.zh}

排序方法特定于内置类型;这是字符串的示例。请注意，排序是在位，因此它会更改给定的切片而不会返回新的切片。

:::


```go
	strs := []string{"c", "a", "b"}
	sort.Strings(strs)
	fmt.Println("Strings:", strs)
```


::: {.en}
An example of sorting `int`s.
:::

::: {.zh}

排序`int`s的一个例子。

:::


```go
	ints := []int{7, 2, 4}
	sort.Ints(ints)
	fmt.Println("Ints:   ", ints)
```


::: {.en}
We can also use `sort` to check if a slice is
already in sorted order.
:::

::: {.zh}

我们也可以使用`sort`来检查切片是否已按排序顺序排列。

:::


```go
	s := sort.IntsAreSorted(ints)
	fmt.Println("Sorted: ", s)
}
```


::: {.en}
Running our program prints the sorted string and int
slices and `true` as the result of our `AreSorted` test.
:::

::: {.zh}

运行我们的程序打印排序的字符串和intslices以及`true`作为我们`AreSorted`测试的结果。

:::


```sh
$ go run sorting.go
Strings: [a b c]
Ints:    [2 4 7]
Sorted:  true
```


