
# Closing Channels {.en}


# 关闭频道 {.zh}


::: {.en}
_Closing_ a channel indicates that no more values
will be sent on it. This can be useful to communicate
completion to the channel's receivers.
:::

::: {.zh}

_Closing_一个频道表示不再发送任何值。这对于与通道的接收器进行通信完成非常有用。

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

在这个例子中，我们将使用`jobs`通道来完成从`main（）`goroutine到worker goroutine的工作。当我们没有工人的工作时，我们将“关闭”“工作”渠道。

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

这是工人goroutine。它反复从`j，more：= <-jobs`接收`jobs`。在这种特殊的2值接收形式中，如果`jobs`已经'close`d并且已经收到了通道中的所有值，那么`more`值将是'false`。我们用它来通知`done` when we'我们完成了所有的工作。

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

这会通过`jobs`channel向工作人员发送3个作业，然后关闭它。

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

我们等待工作人员使用之前看到的[同步]（通道同步）方法。

:::


```go
	<-done
}
```


```sh
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

封闭渠道的想法自然导致了我们的例子：通过渠道的“范围”。

:::


