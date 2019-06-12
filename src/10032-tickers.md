
# Tickers {.en}


# 行情 {.zh}


::: {.en}
[Timers](timers) are for when you want to do
something once in the future - _tickers_ are for when
you want to do something repeatedly at regular
intervals. Here's an example of a ticker that ticks
periodically until we stop it.
:::

::: {.zh}

[计时器]（计时器）适用于您希望将来使用一次的时间 -  _tickers_适用于您希望在常规间隔内重复执行某些操作的时间。这是一个定时器的例子，直到我们停止它为止。

:::


```go
package main
import "time"
import "fmt"
func main() {
```


::: {.en}
Tickers use a similar mechanism to timers: a
channel that is sent values. Here we'll use the
`range` builtin on the channel to iterate over
the values as they arrive every 500ms.
:::

::: {.zh}

代码使用类似的机制来计算时间：发送值的通道。在这里，我们将使用通道上内置的`range`来迭代每500ms到达的值。

:::


```go
	ticker := time.NewTicker(500 * time.Millisecond)
	go func() {
		for t := range ticker.C {
			fmt.Println("Tick at", t)
		}
	}()
```


::: {.en}
Tickers can be stopped like timers. Once a ticker
is stopped it won't receive any more values on its
channel. We'll stop ours after 1600ms.
:::

::: {.zh}

代码可以像定时器一样停止。一旦tickeris停止，它将不再在其频道上接收任何值。我们将在1600ms后停止我们的行动。

:::


```go
	time.Sleep(1600 * time.Millisecond)
	ticker.Stop()
	fmt.Println("Ticker stopped")
}
```


::: {.en}
When we run this program the ticker should tick 3 times
before we stop it.
:::

::: {.zh}

当我们运行这个程序时，股票代码应该在我们停止之前勾选3次。

:::


```sh
$ go run tickers.go
Tick at 2012-09-23 11:29:56.487625 -0700 PDT
Tick at 2012-09-23 11:29:56.988063 -0700 PDT
Tick at 2012-09-23 11:29:57.488076 -0700 PDT
Ticker stopped
```


