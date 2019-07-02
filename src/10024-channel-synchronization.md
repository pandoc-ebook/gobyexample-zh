
# Channel Synchronization {.en}

# 通道同步 {.zh}

::: {.en}
We can use channels to synchronize execution
across goroutines. Here's an example of using a
blocking receive to wait for a goroutine to finish.
When waiting for multiple goroutines to finish,
you may prefer to use a [WaitGroup](waitgroups).
:::

::: {.zh}

我们可以使用通道来同步 Go 协程间的执行状态。这里是一个 使用阻塞的接受方式来等待一个 Go 协程的运行结束。当需要等待多个 Go 协程完成时，您可能更喜欢使用 [WaitGroup](waitgroups)。

:::

```go
package main
import "fmt"
import "time"
```

::: {.en}
This is the function we'll run in a goroutine. The
`done` channel will be used to notify another
goroutine that this function's work is done.
:::

::: {.zh}

这是我们将在 goroutine 中运行的功能。 `done` 通道将用于通知另一个 Go 协程该函数的工作已完成。

:::

```go
func worker(done chan bool) {
	fmt.Print("working...")
	time.Sleep(time.Second)
	fmt.Println("done")
```

::: {.en}
Send a value to notify that we're done.
:::

::: {.zh}

发送一个值以通知我们已完成。

:::

```go
	done <- true
}
func main() {
```

::: {.en}
Start a worker goroutine, giving it the channel to
notify on.
:::

::: {.zh}

运行一个 worker Go 协程，并给予用于通知的通道。

:::

```go
	done := make(chan bool, 1)
	go worker(done)
```

::: {.en}
Block until we receive a notification from the
worker on the channel.
:::

::: {.zh}

程序将在接收到通道中 `worker` 发出的通知前一直阻塞。

:::

```go
	<-done
}
```

```bash
$ go run channel-synchronization.go      
working...done                  
```

::: {.en}
If you removed the `<- done` line from this program, the
program would exit before the `worker` even
started.
:::

::: {.zh}

如果你把 `<- done` 这行代码从程序中移除，程序甚至会在 `worker` 还没开始运行时就结束了。

:::
