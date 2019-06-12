
# Goroutines {.en}


# 够程 {.zh}


::: {.en}
A _goroutine_ is a lightweight thread of execution.
:::

::: {.zh}

_goroutine_是一个轻量级的执行线程。

:::


```go
package main
import "fmt"
func f(from string) {
	for i := 0; i < 3; i++ {
		fmt.Println(from, ":", i)
	}
}
func main() {
```


::: {.en}
Suppose we have a function call `f(s)`. Here's how
we'd call that in the usual way, running it
synchronously.
:::

::: {.zh}

假设我们有一个函数调用`f（s）`。以下是我们如何以通常的方式调用它，以异步方式运行。

:::


```go
	f("direct")
```


::: {.en}
To invoke this function in a goroutine, use
`go f(s)`. This new goroutine will execute
concurrently with the calling one.
:::

::: {.zh}

要在goroutine中调用此函数，请使用`go f（s）`。这个新的goroutine将与调用的goroutine同时执行。

:::


```go
	go f("goroutine")
```


::: {.en}
You can also start a goroutine for an anonymous
function call.
:::

::: {.zh}

您也可以为匿名函数调用启动goroutine。

:::


```go
	go func(msg string) {
		fmt.Println(msg)
	}("going")
```


::: {.en}
Our two function calls are running asynchronously in
separate goroutines now, so execution falls through
to here. This `Scanln` requires we press a key
before the program exits.
:::

::: {.zh}

我们的两个函数调用现在正在异步运行不同的goroutine，因此执行到此处。这个`Scanln`要求我们在程序退出之前按一个键。

:::


```go
	fmt.Scanln()
	fmt.Println("done")
}
```


::: {.en}
When we run this program, we see the output of the
blocking call first, then the interleaved output of the
two goroutines. This interleaving reflects the
goroutines being run concurrently by the Go runtime.
:::

::: {.zh}

当我们运行这个程序时，我们首先看到阻塞调用的输出，然后是两个goroutines的交错输出。这种交错反映了Go运行时并发运行的语法。

:::


```sh
$ go run goroutines.go
direct : 0
direct : 1
direct : 2
goroutine : 0
going
goroutine : 1
goroutine : 2
<enter>
done
```


::: {.en}
Next we'll look at a complement to goroutines in
concurrent Go programs: channels.
:::

::: {.zh}

接下来我们将看看goroutines不兼容Go程序的补充：频道。

:::


