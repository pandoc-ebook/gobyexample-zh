
# Closures {.en}

# 闭包 {.zh}

::: {.en}
Go supports [_anonymous functions_](http://en.wikipedia.org/wiki/Anonymous_function),
which can form <a href="http://en.wikipedia.org/wiki/Closure_(computer_science)"><em>closures</em></a>.
Anonymous functions are useful when you want to define
a function inline without having to name it.
:::

::: {.zh}

Go 支持 [*匿名函数*](http://en.wikipedia.org/wiki/Anonymous_function)，并能用其构造 [*闭包*](http://en.wikipedia.org/wiki/Closure_%28computer_science%29)。如果要定义一个不需要命名的内联函数，匿名函数非常有用。

:::

```go
package main
import "fmt"
```

::: {.en}
This function `intSeq` returns another function, which
we define anonymously in the body of `intSeq`. The
returned function _closes over_ the variable `i` to
form a closure.
:::

::: {.zh}

这个函数 `intSeq` 返回另一个在 `intSeq` 的主体内定义的匿名函数。这个返回的函数使用闭包的方式隐藏变量 i。

:::

```go
func intSeq() func() int {
	i := 0
	return func() int {
		i++
		return i
	}
}
func main() {
```

::: {.en}
We call `intSeq`, assigning the result (a function)
to `nextInt`. This function value captures its
own `i` value, which will be updated each time
we call `nextInt`.
:::

::: {.zh}

我们调用 `intSeq` 函数，将返回值（一个函数）赋给 `nextInt`。这个函数值包含了自己的 `i` 值，这样每次调用 `nextInt` 时都会更新 i 的值。

:::

```go
	nextInt := intSeq()
```

::: {.en}
See the effect of the closure by calling `nextInt`
a few times.
:::

::: {.zh}

通过几次调用 `nextInt` 来查看闭包的效果。

:::

```go
	fmt.Println(nextInt())
```

::: {.en}
To confirm that the state is unique to that
particular function, create and test a new one.
:::

::: {.zh}

要确认状态对于特定函数是唯一的，我们 重新创建并测试一下。

:::

```go
	newInts := intSeq()
	fmt.Println(newInts())
}
```

```bash
$ go run closures.go
1
2
3
1
```

::: {.en}
The last feature of functions we'll look at for now is
recursion.
:::

::: {.zh}

我们即将要学习的函数的最后一个特性是 递归。

:::
