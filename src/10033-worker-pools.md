
# Worker Pools {.en}

# 工作池 {.zh}

::: {.en}
In this example we'll look at how to implement
a _worker pool_ using goroutines and channels.
:::

::: {.zh}

在这个例子中，我们将看看如何使用 Go 协程 和 通道 实现 工作池。

:::

```go
package main
import "fmt"
import "time"
```

::: {.en}
Here's the worker, of which we'll run several
concurrent instances. These workers will receive
work on the `jobs` channel and send the corresponding
results on `results`. We'll sleep a second per job to
simulate an expensive task.
:::

::: {.zh}

这是我们将要在多个并发实例中支持的任务。这些执行者 将从 jobs 通道接收任务，并且通过 results 发送对应 的结果。我们将让每个任务间隔 1s 来模拟一个耗时的任务。

:::

```go
func worker(id int, jobs <-chan int, results chan<- int) {
	for j := range jobs {
		fmt.Println("worker", id, "started  job", j)
		time.Sleep(time.Second)
		fmt.Println("worker", id, "finished job", j)
		results <- j * 2
	}
}
func main() {
```

::: {.en}
In order to use our pool of workers we need to send
them work and collect their results. We make 2
channels for this.
:::

::: {.zh}

为了使用我们的工人池，需要发送他们的工作并收集他们的结果。为此我们需要 2 个通道。

:::

```go
	jobs := make(chan int, 100)
	results := make(chan int, 100)
```

::: {.en}
This starts up 3 workers, initially blocked
because there are no jobs yet.
:::

::: {.zh}

这里启动了 3 个 worker，初始是阻塞的，因为 还没有传递任务。

:::

```go
	for w := 1; w <= 3; w++ {
		go worker(w, jobs, results)
	}
```

::: {.en}
Here we send 5 `jobs` and then `close` that
channel to indicate that's all the work we have.
:::

::: {.zh}

在这里，我们发送 5 个`jobs` 然后 `close` 这些通道来表示这些就是我们所有的任务了。

:::

```go
	for j := 1; j <= 5; j++ {
		jobs <- j
	}
	close(jobs)
```

::: {.en}
Finally we collect all the results of the work.
This also ensures that the worker goroutines have
finished. An alternative way to wait for multiple
goroutines is to use a [WaitGroup](waitgroups).
:::

::: {.zh}

最后，我们收集所有任务的返回值。这也确保了执行任务的 Go 协程已经完成。等待多个 Go 协程的另一种方法是使用 [WaitGroup](waitgroups)。

:::

```go
	for a := 1; a <= 5; a++ {
		<-results
	}
}
```

::: {.en}
Our running program shows the 5 jobs being executed by
various workers. The program only takes about 2 seconds
despite doing about 5 seconds of total work because
there are 3 workers operating concurrently.
:::

::: {.zh}

运行程序显示了 5 个任务被多个 worker 执行。该程序只需要大约 2 秒就可以完成原本需要 5 秒的工作，因为有 3 个 worker 并行执行。

:::

```bash
$ time go run worker-pools.go 
worker 1 started  job 1
worker 2 started  job 2
worker 3 started  job 3
worker 1 finished job 1
worker 1 started  job 4
worker 2 finished job 2
worker 2 started  job 5
worker 3 finished job 3
worker 1 finished job 4
worker 2 finished job 5
real	0m2.358s
```
