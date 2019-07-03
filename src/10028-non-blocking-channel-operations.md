
# Non-Blocking Channel Operations {.en}

# 非阻塞通道操作 {.zh}

::: {.en}
Basic sends and receives on channels are blocking.
However, we can use `select` with a `default` clause to
implement _non-blocking_ sends, receives, and even
non-blocking multi-way `select`s.
:::

::: {.zh}

常规的通过通道发送和接收数据是阻塞的。然而，我们可以 使用带一个 default 子句的 select 来实现非阻塞 的 发送、接收，甚至是非阻塞的多路 select。

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

这里是一个非阻塞接收的例子。如果在 `messages` 中 存在，然后 `select` 将这个值带入 `<-messages case` 中。如果不是，就直接到 default 分支中。

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

非阻塞发送的工作方式类似。这里 `msg` 不能发送到 `messages` 通道，因为通道没有缓冲区而且没有接收器。因此选择了 `default` 分支。

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

我们可以使用 `default` 子句 上面的多个 `case` 来实现多路非阻塞选择。在这里，我们尝试非阻塞的接收 `messages` 和 `signals`。

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

```bash
$ go run non-blocking-channel-operations.go 
no message received
no message sent
no activity
```
