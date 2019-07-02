
# Channel Directions {.en}

# 通道方向 {.zh}

::: {.en}
When using channels as function parameters, you can
specify if a channel is meant to only send or receive
values. This specificity increases the type-safety of
the program.
:::

::: {.zh}

当使用通道作为函数的参数时，你可以指定这个通道是不是 只用来发送或者接收值。这个特性提升了程序的类型安全性。

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

这个 `ping` 函数只接受发送值的通道。尝试在此通道上接收数据将会得到一个编译时错误。

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

`pong` 函数接受一个用于接收数据的通道（`pings`）和一个用于发送的通道（`pongs`）。

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

```bash
$ go run channel-directions.go
passed message
```
