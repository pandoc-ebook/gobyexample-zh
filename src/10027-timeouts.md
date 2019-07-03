
# Timeouts {.en}

# 超时处理 {.zh}

::: {.en}
_Timeouts_ are important for programs that connect to
external resources or that otherwise need to bound
execution time. Implementing timeouts in Go is easy and
elegant thanks to channels and `select`.
:::

::: {.zh}

超时处理对于连接到外部资源或需要限制执行时间的程序非常重要。通过通道和通道选择器，在 Go 中实现超时很容易。

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

对于我们的示例，假设我们正在执行一个外部调用，它在 2s 后在通道 `c1` 上返回其结果。

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

这是通道选择器实现超时的例子。`res := <-c1` 等待结果，`<-Time.After` 等待超时 时间 1 秒后发送的值。由于 select 默认处理第一个 已准备好的接收操作，如果这个操作超过了允许的 1 秒 的话，将会执行超时 case。

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

如果我们允许更长的 3s 超时，将会成功的从 c2 接收到值，并且打印出结果。

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

```bash
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

使用这个 select 超时方式，需要使用通道传递结果。这对于 一般情况是个好的方式，因为其他重要的 Go 特性是基于通道和 select 的。接下来我们就要看到两个例子：timer 和 ticker。

:::
