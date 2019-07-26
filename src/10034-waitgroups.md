
# WaitGroups {.en}

# WaitGroups {.zh}

::: {.en}
To wait for multiple goroutines to finish, we can
use a *wait group*.
:::

::: {.zh}

要等待多个 Go 协程完成，我们可以使用 *wait group*。

:::

```go
package main
import (
	"fmt"
	"sync"
	"time"
)
```

::: {.en}
This is the function we'll run in every goroutine.
Note that a WaitGroup must be passed to functions by
pointer.
:::

::: {.zh}

这是我们将在每个 Go 协程中运行的函数。请注意，WaitGroup 必须通过指针传递给函数。

:::

```go
func worker(id int, wg *sync.WaitGroup) {
	fmt.Printf("Worker %d startingn", id)
```

::: {.en}
Sleep to simulate an expensive task.
:::

::: {.zh}
等待 1s 来模拟一个耗时的任务。

:::

```go
	time.Sleep(time.Second)
	fmt.Printf("Worker %d donen", id)
```

::: {.en}
Notify the WaitGroup that this worker is done.
:::

::: {.zh}

通知 WaitGroup 此执行已完成。

:::

```go
	wg.Done()
}
func main() {
```

::: {.en}
This WaitGroup is used to wait for all the
goroutines launched here to finish.
:::

::: {.zh}

此 WaitGroup 用于等待此处启动的所有 Go 协程完成。

:::

```go
	var wg sync.WaitGroup
```

::: {.en}
Launch several goroutines and increment the WaitGroup
counter for each.
:::

::: {.zh}

启动几个 Go 协程并为每个 Go 协程增加 WaitGroup 计数器。

:::

```go
	for i := 1; i <= 5; i++ {
		wg.Add(1)
		go worker(i, &wg)
	}
```

::: {.en}
Block until the WaitGroup counter goes back to 0;
all the workers notified they're done.
:::

::: {.zh}

在 WaitGroup 计数器返回 0 之前阻塞；所有工作人员都通知他们已完成。

:::

```go
	wg.Wait()
}
```

```bash
$ go run waitgroups.go
Worker 5 starting
Worker 3 starting
Worker 4 starting
Worker 1 starting
Worker 2 starting
Worker 4 done
Worker 1 done
Worker 2 done
Worker 5 done
Worker 3 done
```

::: {.en}
The order of workers starting up and finishing
is likely to be different for each invocation.
:::

::: {.zh}

每次调用时，worker 启动和完成的顺序可能不同。

:::
