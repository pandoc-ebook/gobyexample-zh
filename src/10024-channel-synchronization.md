
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

我们可以使用通道来同步执行goroutine。下面是使用ablocking receive等待goroutine完成的示例。当等待多个goroutine完成时，您可能更喜欢使用[WaitGroup]（waitgroups）。

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

这是我们将在goroutine中运行的功能。 ``done`频道将用于通知anothergoroutine该功能的工作已完成。

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

启动一个工作人员goroutine，给它通道tonotify。

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

阻止，直到我们收到来自工作人员的频道通知。

:::


```go
	<-done
}
```


```sh
$ go run channel-synchronization.go      
working...done                  
```


::: {.en}
If you removed the `<- done` line from this program, the
program would exit before the `worker` even
started.
:::

::: {.zh}

如果你从这个程序中删除了`< -  done`行，程序将在`worker`开始之前退出。

:::


