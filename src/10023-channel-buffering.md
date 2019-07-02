
# Channel Buffering {.en}

# 通道缓冲 {.zh}

::: {.en}
By default channels are _unbuffered_, meaning that they
will only accept sends (`chan <-`) if there is a
corresponding receive (`<- chan`) ready to receive the
sent value. _Buffered channels_ accept a limited
number of  values without a corresponding receiver for
those values.
:::

::: {.zh}

默认情况下，通道是无缓冲的，这意味着只有在对应的接收（`<-chan`）通道准备好接收时，才允许进行发送（`chan <-`）。 *可缓存通道*允许在没有对应接收方的情况下，缓存限定数量的值。

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

在这里，我们 `make` 了一个最多允许缓冲 2 个字符串值的通道。

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

因为这个通道是有缓冲区的，即使没有一个对应的并发接收 方，我们仍然可以发送这些值。

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
}
```

```bash
$ go run channel-buffering.go 
buffered
channel
```
