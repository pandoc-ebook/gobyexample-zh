
# Closing Channels {.en}

# 关闭通道 {.zh}

::: {.en}
_Closing_ a channel indicates that no more values
will be sent on it. This can be useful to communicate
completion to the channel's receivers.
:::

::: {.zh}

关闭 一个通道意味着不能再向这个通道发送值了。这个特性可以 用来给这个通道的接收方传达工作已经完成的信息。

:::

```go
package main
import "fmt"
```

::: {.en}
In this example we'll use a `jobs` channel to
communicate work to be done from the `main()` goroutine
to a worker goroutine. When we have no more jobs for
the worker we'll `close` the `jobs` channel.
:::

::: {.zh}

在这个例子中，我们将使用一个 `jobs` 通道来传递 `main()` 中 Go 协程任务执行的结束信息到一个工作 Go 协程中。当我们没有多余的 任务给这个工作 Go 协程时，我们将 `close` 这个 `jobs` 通道。

:::

```go
func main() {
	jobs := make(chan int, 5)
	done := make(chan bool)
```

::: {.en}
Here's the worker goroutine. It repeatedly receives
from `jobs` with `j, more := <-jobs`. In this
special 2-value form of receive, the `more` value
will be `false` if `jobs` has been `close`d and all
values in the channel have already been received.
We use this to notify on `done` when we've worked
all our jobs.
:::

::: {.zh}

这是工作 Go 协程。使用 `j, more := <- jobs` 循环的从 `jobs` 接收数据。在接收的这个特殊的二值形式的值中， 如果 `jobs` 已经关闭了，并且通道中所有的值都已经接收 完毕，那么 `more` 的值将是 `false`。当我们完成所有 的任务时，将使用这个特性通过 `done` 通道去进行通知。

:::

```go
	go func() {
		for {
			j, more := <-jobs
			if more {
				fmt.Println("received job", j)
			} else {
				fmt.Println("received all jobs")
				done <- true
				return
			}
		}
	}()
```

::: {.en}
This sends 3 jobs to the worker over the `jobs`
channel, then closes it.
:::

::: {.zh}

这里使用 `jobs` 发送 3 个任务到工作函数中，然后 关闭 `jobs`。

:::

```go
	for j := 1; j <= 3; j++ {
		jobs <- j
		fmt.Println("sent job", j)
	}
	close(jobs)
	fmt.Println("sent all jobs")
```

::: {.en}
We await the worker using the
[synchronization](channel-synchronization) approach
we saw earlier.
:::

::: {.zh}

我们使用前面学到的通道同步 方法等待任务结束。

:::

```go
	<-done
}
```

```bash
$ go run closing-channels.go 
sent job 1
received job 1
sent job 2
received job 2
sent job 3
received job 3
sent all jobs
received all jobs
```

::: {.en}
The idea of closed channels leads naturally to our next
example: `range` over channels.
:::

::: {.zh}

通过关闭通道的学习，也让下面学习通道遍历水到渠成。

:::
