
# Channel Buffering {.en}


# 频道缓冲 {.zh}


::: {.en}
By default channels are _unbuffered_, meaning that they
will only accept sends (`chan <-`) if there is a
corresponding receive (`<- chan`) ready to receive the
sent value. _Buffered channels_ accept a limited
number of  values without a corresponding receiver for
those values.
:::

::: {.zh}

默认情况下，通道是_unbuffered_，这意味着如果有相应的接收（`< -  chan`）准备接收到该值，它们将只接受发送（`chan <-`）。 _Buffered channels_接受有限数量的值，而没有相应的接收器的值。

:::


```go
package main
import "fmt"
func main() {
```


::: {.en}
Here we `make` a channel of strings buffering up to
2 values.
:::

::: {.zh}

在这里，我们`make`是一个缓冲2个值的字符串通道。

:::


```go
	messages := make(chan string, 2)
```


::: {.en}
Because this channel is buffered, we can send these
values into the channel without a corresponding
concurrent receive.
:::

::: {.zh}

由于此通道是缓冲的，因此我们可以将这些值发送到通道而无需相应的并发接收。

:::


```go
	messages <- "buffered"
	messages <- "channel"
```


::: {.en}
Later we can receive these two values as usual.
:::

::: {.zh}

稍后我们可以照常接收这两个值。

:::


```go
	fmt.Println(<-messages)
	fmt.Println(<-messages)
}
```


```bash
$ go run channel-buffering.go 
buffered
channel
```


