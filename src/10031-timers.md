
# Timers {.en}


# 计时器 {.zh}


::: {.en}
We often want to execute Go code at some point in the
future, or repeatedly at some interval. Go's built-in
_timer_ and _ticker_ features make both of these tasks
easy. We'll look first at timers and then
at [tickers](tickers).
:::

::: {.zh}

我们经常希望在未来的某个时刻执行Go代码，或者在某个时间间隔重复执行Go代码。 Go的内置_timer_和_ticker_功能使这两项任务变得容易。我们首先会看到计时器，然后是[代码]（代码）。

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

定时器代表未来的单个事件。您将计时器等待多长时间，并提供将在该时间通知的通道。此计时器将等待2秒钟。

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

`<-timer1.C`在定时器的通道`C`上阻塞，直到它发送一个表示timerexpired的值。

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

如果你只是想等，你可以使用`time.Sleep`。计时器可能有用的一个原因是你可以在计时器到期之前取消计时器。这是一个例子。

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

第一个计时器将在我们启动程序后约2秒到期，但第二个计时器应该在它有机会到期之前停止。

:::


```bash
$ go run timers.go
Timer 1 expired
Timer 2 stopped
```


