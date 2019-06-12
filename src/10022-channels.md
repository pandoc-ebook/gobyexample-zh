
# Channels {.en}


# 通道 {.zh}


::: {.en}
_Channels_ are the pipes that connect concurrent
goroutines. You can send values into channels from one
goroutine and receive those values into another
goroutine.
:::

::: {.zh}

_Channels_是连接并发goroutine的管道。您可以将值从onegoroutine发送到通道，并将这些值接收到另一个goroutine中。

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

使用`make（chan val-type）`创建一个新的通道。通过它们传达的值输入通道。

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

_使用`channel <-`syntax将值发送到通道。在这里，我们将“ping”`发送到我们上面的`messages`channel，来自一个新的goroutine。

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

`<-channel`语法_receives_来自通道的值。在这里，我们将收到上面发送的“ping”消息并打印出来。

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

当我们运行程序时，“ping”消息成功地从一个goroutine传递到另一个viaour通道。

:::


```sh
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

默认情况下，发送和接收阻塞，直到这些接收器和接收器都准备就绪。这个属性允许我们在程序结束时等待“ping”消息，而不必使用任何其他同步。

:::


