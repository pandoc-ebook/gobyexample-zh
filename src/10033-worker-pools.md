
# Worker Pools {.en}


# 工人池 {.zh}


::: {.en}
In this example we'll look at how to implement
a _worker pool_ using goroutines and channels.
:::

::: {.zh}

在这个例子中，我们将看看如何使用goroutines和channels实现_worker pool_。

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

这是工作者，我们将运行几个并发实例。这些工作人员将在“工作”频道上接收工作，并在“结果”上发送相应的结果。我们每个工作都会睡一秒钟来模拟一项昂贵的任务。

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

为了使用我们的工人群，我们需要发送他们的工作并收集他们的结果。我们为此制作了2个频道。

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

这启动了3名工人，最初因为还没有工作而被封锁。

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

在这里，我们发送5个`jobs`然后'close` thatchannel来表示我们所有的工作。

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

最后，我们收集了工作的所有结果。这也确保了工人goroutines已经完成。等待multiplegoroutines的另一种方法是使用[WaitGroup]（waitgroups）。

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

我们的运行程序显示了各种工作人员正在执行的5个工作。该计划只需要大约2秒就可以完成大约5秒钟的工作，因为有3名工人兼职。

:::


```sh
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


