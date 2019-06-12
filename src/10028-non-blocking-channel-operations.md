
# Non-Blocking Channel Operations {.en}


# 非阻塞频道操作 {.zh}


::: {.en}
Basic sends and receives on channels are blocking.
However, we can use `select` with a `default` clause to
implement _non-blocking_ sends, receives, and even
non-blocking multi-way `select`s.
:::

::: {.zh}

通道上的基本发送和接收是阻塞的。但是，我们可以使用带有`default`子句的`select`来实现_non-blocking_发送，接收和偶数阻塞多路`select`s。

:::


```go
package main
import "fmt"
func main() {
	messages := make(chan string)
	signals := make(chan bool)
```


::: {.en}
Here's a non-blocking receive. If a value is
available on `messages` then `select` will take
the `<-messages` `case` with that value. If not
it will immediately take the `default` case.
:::

::: {.zh}

这是一个非阻塞接收。如果`messages`上有一个值，则`select`将使用该值获取`<-messages``case`。如果notit将立即采用`default`情况。

:::


```go
	select {
	case msg := <-messages:
		fmt.Println("received message", msg)
	default:
		fmt.Println("no message received")
	}
```


::: {.en}
A non-blocking send works similarly. Here `msg`
cannot be sent to the `messages` channel, because
the channel has no buffer and there is no receiver.
Therefore the `default` case is selected.
:::

::: {.zh}

非阻塞发送的工作方式类似。这里`msg`不能发送到`messages`通道，因为通道没有缓冲区而且没有接收器。因此选择了`default` case。

:::


```go
	msg := "hi"
	select {
	case messages <- msg:
		fmt.Println("sent message", msg)
	default:
		fmt.Println("no message sent")
	}
```


::: {.en}
We can use multiple `case`s above the `default`
clause to implement a multi-way non-blocking
select. Here we attempt non-blocking receives
on both `messages` and `signals`.
:::

::: {.zh}

我们可以使用`default`clause上面的多个`case`s来实现多路非阻塞选择。在这里，我们尝试非阻塞接收“消息”和“信号”。

:::


```go
	select {
	case msg := <-messages:
		fmt.Println("received message", msg)
	case sig := <-signals:
		fmt.Println("received signal", sig)
	default:
		fmt.Println("no activity")
	}
}
```


```sh
$ go run non-blocking-channel-operations.go 
no message received
no message sent
no activity
```


