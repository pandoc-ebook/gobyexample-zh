
# Channels {.en}

# 通道 {.zh}

::: {.en}
_Channels_ are the pipes that connect concurrent
goroutines. You can send values into channels from one
goroutine and receive those values into another
goroutine.
:::

::: {.zh}

通道 (Channels) 是连接多个 Go 协程的管道。你可以从一个 Go 协程 将值发送到通道，然后在别的 Go 协程中接收。

:::

```go
package main
import "fmt"
func main() {
```

::: {.en}
Create a new channel with `make(chan val-type)`.
Channels are typed by the values they convey.
:::

::: {.zh}

使用 `make(chan val-type)` 创建一个新的通道。通道类型就是他们需要传递值的类型。

:::

```go
	messages := make(chan string)
```

::: {.en}
_Send_ a value into a channel using the `channel <-`
syntax. Here we send `"ping"`  to the `messages`
channel we made above, from a new goroutine.
:::

::: {.zh}

使用 `channel <-` 语法 发送（send） 一个新的值到通道中。这里 我们在一个新的 Go 协程中发送 "ping" 到上面创建的 messages 通道中。

:::

```go
	go func() { messages <- "ping" }()
```

::: {.en}
The `<-channel` syntax _receives_ a value from the
channel. Here we'll receive the `"ping"` message
we sent above and print it out.
:::

::: {.zh}

`<-channel`语法接收来自通道的值。在这里，我们将收到上面发送的 `ping` 消息并打印出来。

:::

```go
	msg := <-messages
	fmt.Println(msg)
}
```

::: {.en}
When we run the program the `"ping"` message is
successfully passed from one goroutine to another via 
our channel.
:::

::: {.zh}

我们运行程序时，通过通道，消息 `ping` 成功地从一个 Go 协程传到 另一个中。

:::

```bash
$ go run channels.go 
ping
```

::: {.en}
By default sends and receives block until both the
sender and receiver are ready. This property allowed
us to wait at the end of our program for the `"ping"`
message without having to use any other synchronization.
:::

::: {.zh}

默认情况下，发送和接收是阻塞的，直到发送方和接收方都准备就绪。这个特性允许我们在程序结束时等待 `ping` 消息，而不必使用任何其他同步操作。

:::
