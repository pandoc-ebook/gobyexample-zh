
# Timeouts {.en}


# 超时 {.zh}


::: {.en}
_Timeouts_ are important for programs that connect to
external resources or that otherwise need to bound
execution time. Implementing timeouts in Go is easy and
elegant thanks to channels and `select`.
:::

::: {.zh}

_Timeouts_对于连接到外部资源或需要boundexecution时间的程序非常重要。由于频道和“选择”，在Go中实现超时很容易。

:::


```go
package main
import "time"
import "fmt"
func main() {
```


::: {.en}
For our example, suppose we're executing an external
call that returns its result on a channel `c1`
after 2s.
:::

::: {.zh}

对于我们的示例，假设我们正在执行一个externalcall，它在2s后在通道`c1`上返回其结果。

:::


```go
	c1 := make(chan string, 1)
	go func() {
		time.Sleep(2 * time.Second)
		c1 <- "result 1"
	}()
```


::: {.en}
Here's the `select` implementing a timeout.
`res := <-c1` awaits the result and `<-Time.After`
awaits a value to be sent after the timeout of
1s. Since `select` proceeds with the first
receive that's ready, we'll take the timeout case
if the operation takes more than the allowed 1s.
:::

::: {.zh}

这是实现超时的`select``res：= <-c1`等待结果，`<-Time.After`waits在超时1s后发送的值。由于`select`继续执行已准备好的第一个接收，因此我们将采用超时情况，如果操作超过允许的1。

:::


```go
	select {
	case res := <-c1:
		fmt.Println(res)
	case <-time.After(1 * time.Second):
		fmt.Println("timeout 1")
	}
```


::: {.en}
If we allow a longer timeout of 3s, then the receive
from `c2` will succeed and we'll print the result.
:::

::: {.zh}

如果我们允许更长的3s超时，那么来自`c2`的receive将成功，我们将打印结果。

:::


```go
	c2 := make(chan string, 1)
	go func() {
		time.Sleep(2 * time.Second)
		c2 <- "result 2"
	}()
	select {
	case res := <-c2:
		fmt.Println(res)
	case <-time.After(3 * time.Second):
		fmt.Println("timeout 2")
	}
}
```


::: {.en}
Running this program shows the first operation timing
out and the second succeeding.
:::

::: {.zh}

运行此程序显示第一个操作超时，第二个成功。

:::


```sh
$ go run timeouts.go 
timeout 1
result 2
```


::: {.en}
Using this `select` timeout pattern requires
communicating results over channels. This is a good
idea in general because other important Go features are
based on channels and `select`. We'll look at two
examples of this next: timers and tickers.
:::

::: {.zh}

使用此“select”超时模式需要通过通道传递结果。这是一个很好的例子，因为其他重要的Go功能都基于通道和`select`。我们将看看下一个示例：定时器和代码。

:::


