
# Functions {.en}


# 功能 {.zh}


::: {.en}
_Functions_ are central in Go. We'll learn about
functions with a few different examples.
:::

::: {.zh}

_Functions_是Go的核心。我们将通过几个不同的例子来了解函数。

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

这是一个函数，它将两个`int`s和returnstheir sum作为`int`。

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

Go需要明确的回报，即它不会自动返回lastexpression的值。

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

当您有多个相同类型的连续参数时，可以省略类似名称参数的类型名称，直到声明该类型的最终参数。

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

使用`name（args）`调用函数就像你期望的那样。

:::


```go
	res := plus(1, 2)
	fmt.Println("1+2 =", res)
	res = plusPlus(1, 2, 3)
	fmt.Println("1+2+3 =", res)
}
```


```sh
$ go run functions.go 
1+2 = 3
1+2+3 = 6
```


::: {.en}
There are several other features to Go functions. One is
multiple return values, which we'll look at next.
:::

::: {.zh}

Go功能还有其他一些功能。一个是多个返回值，我们将在下面看一下。

:::


