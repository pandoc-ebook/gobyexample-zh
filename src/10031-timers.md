
# Timers {.en}

# 定时器 {.zh}

::: {.en}
We often want to execute Go code at some point in the
future, or repeatedly at some interval. Go's built-in
_timer_ and _ticker_ features make both of these tasks
easy. We'll look first at timers and then
at [tickers](tickers).
:::

::: {.zh}

我们常常需要在后面一个时刻运行 Go 代码，或者在某段时间 间隔内重复运行。Go 的内置 定时器 和 打点器 特性让这 些很容易实现。我们将先学习定时器，然后再学习打点器。

:::

```go
package main
import "time"
import "fmt"
func main() {
```

::: {.en}
Timers represent a single event in the future. You
tell the timer how long you want to wait, and it
provides a channel that will be notified at that
time. This timer will wait 2 seconds.
:::

::: {.zh}

定时器表示在未来某一时刻的独立事件。你告诉定时器 需要等待的时间，然后它将提供一个用于通知的通道。 这里的定时器将等待 2 秒。

:::

```go
	timer1 := time.NewTimer(2 * time.Second)
```

::: {.en}
The `<-timer1.C` blocks on the timer's channel `C`
until it sends a value indicating that the timer
expired.
:::

::: {.zh}

`<-timer1.C` 在定时器的通道 `C` 上阻塞，直到它发送一个表示 定时器失效 的值。

:::

```go
	<-timer1.C
	fmt.Println("Timer 1 expired")
```

::: {.en}
If you just wanted to wait, you could have used
`time.Sleep`. One reason a timer may be useful is
that you can cancel the timer before it expires.
Here's an example of that.
:::

::: {.zh}

如果你需要的仅仅是单纯的等待，你需要使用 `time.Sleep`。 定时器是有用原因之一就是你可以在定时器失效之前，取消这个 定时器。这是一个例子

:::

```go
	timer2 := time.NewTimer(time.Second)
	go func() {
		<-timer2.C
		fmt.Println("Timer 2 expired")
	}()
	stop2 := timer2.Stop()
	if stop2 {
		fmt.Println("Timer 2 stopped")
	}
}
```

::: {.en}
The first timer will expire ~2s after we start the
program, but the second should be stopped before it has
a chance to expire.
:::

::: {.zh}

第一个定时器将在程序开始后约 2s 失效，但是第二个在它 没失效之前就停止了。

:::

```bash
$ go run timers.go
Timer 1 expired
Timer 2 stopped
```
