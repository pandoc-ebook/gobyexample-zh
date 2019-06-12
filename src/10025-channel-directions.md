
# Channel Directions {.en}


# 频道指示 {.zh}


::: {.en}
When using channels as function parameters, you can
specify if a channel is meant to only send or receive
values. This specificity increases the type-safety of
the program.
:::

::: {.zh}

使用通道作为功能参数时，您可以指定通道是仅用于发送还是接收值。这种特异性增加了程序的类型安全性。

:::


```go
package main
import "fmt"
```


::: {.en}
This `ping` function only accepts a channel for sending
values. It would be a compile-time error to try to
receive on this channel.
:::

::: {.zh}

这个`ping`函数只接受发送值的通道。尝试在此频道上接收将是编译时错误。

:::


```go
func ping(pings chan<- string, msg string) {
	pings <- msg
}
```


::: {.en}
The `pong` function accepts one channel for receives
(`pings`) and a second for sends (`pongs`).
:::

::: {.zh}

`pong`函数接受一个用于接收的通道（`ping`）和一个用于发送的通道（`pongs`）。

:::


```go
func pong(pings <-chan string, pongs chan<- string) {
	msg := <-pings
	pongs <- msg
}
func main() {
	pings := make(chan string, 1)
	pongs := make(chan string, 1)
	ping(pings, "passed message")
	pong(pings, pongs)
	fmt.Println(<-pongs)
}
```


```sh
$ go run channel-directions.go
passed message
```


