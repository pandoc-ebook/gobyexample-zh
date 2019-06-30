
# Functions {.en}

# 函数 {.zh}

::: {.en}
_Functions_ are central in Go. We'll learn about
functions with a few different examples.
:::

::: {.zh}

*函数*是 Go 的核心。我们将通过几个不同的例子来了解函数。

:::

```go
package main
import "fmt"
```

::: {.en}
Here's a function that takes two `int`s and returns
their sum as an `int`.
:::

::: {.zh}

这是一个函数，接受两个 `int` 类型参数并且以 `int` 类型返回它们的和。

:::

```go
func plus(a int, b int) int {
```

::: {.en}
Go requires explicit returns, i.e. it won't
automatically return the value of the last
expression.
:::

::: {.zh}

Go 需要明确的返回值，即它不会自动返回最后一个表达式的值。

:::

```go
	return a + b
}
```

::: {.en}
When you have multiple consecutive parameters of
the same type, you may omit the type name for the
like-typed parameters up to the final parameter that
declares the type.
:::

::: {.zh}

当您有连续的多个相同类型的参数时，只需要在最后一个参数末尾声明类型，前面的可以省略类型名称。

:::

```go
func plusPlus(a, b, c int) int {
	return a + b + c
}
func main() {
```

::: {.en}
Call a function just as you'd expect, with
`name(args)`.
:::

::: {.zh}

使用 `name(args)` 调用函数。

:::

```go
	res := plus(1, 2)
	fmt.Println("1+2 =", res)
	res = plusPlus(1, 2, 3)
	fmt.Println("1+2+3 =", res)
}
```

```bash
$ go run functions.go 
1+2 = 3
1+2+3 = 6
```

::: {.en}
There are several other features to Go functions. One is
multiple return values, which we'll look at next.
:::

::: {.zh}

Go 功能还有其他一些功能。一个是多个返回值，接下来我们将学习此功能。

:::
