
# Variadic Functions {.en}

# 变参函数 {.zh}

::: {.en}
[_Variadic functions_](http://en.wikipedia.org/wiki/Variadic_function)
can be called with any number of trailing arguments.
For example, `fmt.Println` is a common variadic
function.
:::

::: {.zh}
[可变参数函数](http://en.wikipedia.org/wiki/Variadic_function) 可以在调用时使用任意数量的参数。
例如，`fmt.Println` 是一种常见的变参函数。

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

这个函数接受任意数量的 `int` 作为参数。

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

变参函数使用常规的调用方式，传入独立的参数。

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

如果你有一个含有多个值的 slice，想把它们作为参数 使用，可以这样调用 `func(slice...)`。

:::

```go
	nums := []int{1, 2, 3, 4}
	sum(nums...)
}
```

```bash
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

Go 函数的另一个关键的方面是闭包结构，这是接下来我们将要学习的。

:::
