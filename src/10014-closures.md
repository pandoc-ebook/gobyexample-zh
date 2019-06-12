
# Closures {.en}


# 关闭 {.zh}


::: {.en}
Go supports [_anonymous functions_](http://en.wikipedia.org/wiki/Anonymous_function),
which can form <a href="http://en.wikipedia.org/wiki/Closure_(computer_science)"><em>closures</em></a>.
Anonymous functions are useful when you want to define
a function inline without having to name it.
:::

::: {.zh}

Go支持[_anonymous functions_]（http://en.wikipedia.org/wiki/Anonymous_function），它可以形成<a href="http://en.wikipedia.org/wiki/Closure_(computer_science)"> <em >闭包</ em> </a>。如果要在不必命名的情况下定义函数内联，匿名函数非常有用。

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

这个函数`intSeq`返回另一个函数，它在`intSeq`的主体中匿名定义。有一个函数_closes over_变量`i`形成一个闭包。

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

我们调用`intSeq`，将结果（函数）赋给`nextInt`。这个函数值捕获它的`i`值，每次调用`nextInt`时都会更新。

:::


```go
	nextInt := intSeq()
```


::: {.en}
See the effect of the closure by calling `nextInt`
a few times.
:::

::: {.zh}

通过几次调用`nextInt`来查看闭包的效果。

:::


```go
	fmt.Println(nextInt())
	fmt.Println(nextInt())
	fmt.Println(nextInt())
```


::: {.en}
To confirm that the state is unique to that
particular function, create and test a new one.
:::

::: {.zh}

要确认状态对于特定功能是唯一的，请创建并测试新的状态。

:::


```go
	newInts := intSeq()
	fmt.Println(newInts())
}
```


```sh
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

我们现在要看的函数的最后一个特性是isrecursion。

:::


