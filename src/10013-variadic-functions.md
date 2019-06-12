
# Variadic Functions {.en}


# 变异函数 {.zh}


::: {.en}
[_Variadic functions_](http://en.wikipedia.org/wiki/Variadic_function)
can be called with any number of trailing arguments.
For example, `fmt.Println` is a common variadic
function.
:::

::: {.zh}

可以使用任意数量的尾随参数调用[_Variadic functions_]（http://en.wikipedia.org/wiki/Variadic_function）。例如，`fmt.Println`是一种常见的变量函数。

:::


```go
package main
import "fmt"
```


::: {.en}
Here's a function that will take an arbitrary number
of `int`s as arguments.
:::

::: {.zh}

这是一个函数，它将任意数量的`int`s作为参数。

:::


```go
func sum(nums ...int) {
	fmt.Print(nums, " ")
	total := 0
	for _, num := range nums {
		total += num
	}
	fmt.Println(total)
}
func main() {
```


::: {.en}
Variadic functions can be called in the usual way
with individual arguments.
:::

::: {.zh}

可以通过单独的参数以通常的方式调用变量函数。

:::


```go
	sum(1, 2)
	sum(1, 2, 3)
```


::: {.en}
If you already have multiple args in a slice,
apply them to a variadic function using
`func(slice...)` like this.
:::

::: {.zh}

如果切片中已经有多个args，请使用`func（slice ...）`将它们应用于可变参数函数。

:::


```go
	nums := []int{1, 2, 3, 4}
	sum(nums...)
}
```


```sh
$ go run variadic-functions.go 
[1 2] 3
[1 2 3] 6
[1 2 3 4] 10
```


::: {.en}
Another key aspect of functions in Go is their ability
to form closures, which we'll look at next.
:::

::: {.zh}

Go中函数的另一个关键方面是它们形成闭包的能力，我们将在下面看一下。

:::


