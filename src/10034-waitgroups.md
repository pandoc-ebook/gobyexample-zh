
# WaitGroups {.en}


# WaitGroups {.zh}


::: {.en}
To wait for multiple goroutines to finish, we can
use a *wait group*.
:::

::: {.zh}

要等待多个goroutine完成，我们可以使用* waitgroup *。

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

这是我们将在每个goroutine中运行的函数。请注意，WaitGroup必须通过指针传递给函数。

:::


```go
func worker(id int, wg *sync.WaitGroup) {
	fmt.Printf("Worker %d startingn", id)
```


::: {.en}
Sleep to simulate an expensive task.
:::

::: {.zh}

睡觉来模拟一项昂贵的任务。

:::


```go
	time.Sleep(time.Second)
	fmt.Printf("Worker %d donen", id)
```


::: {.en}
Notify the WaitGroup that this worker is done.
:::

::: {.zh}

通知WaitGroup此工作人员已完成。

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

此WaitGroup用于等待此处启动的所有ggoroutine完成。

:::


```go
	var wg sync.WaitGroup
```


::: {.en}
Launch several goroutines and increment the WaitGroup
counter for each.
:::

::: {.zh}

启动几个goroutine并为每个增加WaitGroupcounter。

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

阻止，直到WaitGroup计数器返回0;所有工作人员都通知他们已完成。

:::


```go
	wg.Wait()
}
```


```sh
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

每次调用时，工人启动和完成的顺序可能不同。

:::


