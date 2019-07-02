
# Goroutines {.en}

# 协程 {.zh}

::: {.en}
A _goroutine_ is a lightweight thread of execution.
:::

::: {.zh}

*GO 协程*（goroutine）是一个轻量级的执行线程。

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

假设我们有一个函数调用 `f(s)`。一般会这样同步（synchronously）调用。

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

要在 goroutine 中调用此函数，请使用 `go f(s)`。这个新的 Go 协程 将会并发（concurrently）执行这个函数。

:::

```go
	go f("goroutine")
```

::: {.en}
You can also start a goroutine for an anonymous
function call.
:::

::: {.zh}

你也可以为匿名函数启动一个 Go 协程。

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

现在这两个 Go 协程在独立的 Go 协程中异步 (asynchronously) 运行，所以 程序直接运行到这一行。这里的 Scanln 代码需要我们 在程序退出前按下任意键结束。

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

当我们运行这个程序时，将首先看到阻塞式调用的输出，然后是 两个 Go 协程的交替输出。这种交替的情况表示 Go 运行时是以 并发的方式运行协程的。

:::

```bash
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

接下来我们将学习在并发的 Go 程序中的 Go 协程的辅助 特性：通道 (channels)。

:::
