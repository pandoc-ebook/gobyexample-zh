
# Mutexes {.en}


# 互斥 {.zh}


::: {.en}
In the previous example we saw how to manage simple
counter state using [atomic operations](atomic-counters).
For more complex state we can use a <em>[mutex](http://en.wikipedia.org/wiki/Mutual_exclusion)</em>
to safely access data across multiple goroutines.
:::

::: {.zh}

在前面的例子中，我们看到了如何使用[atomic operations]（原子计数器）管理simplecounter状态。对于更复杂的状态，我们可以使用<em> [mutex]（http://en.wikipedia.org/wiki/Mutual_exclusion ）</ em>以安全地访问多个goroutine中的数据。

:::


```go
package main
import (
	"fmt"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"
)
func main() {
```


::: {.en}
For our example the `state` will be a map.
:::

::: {.zh}

对于我们的例子，`state`将是一张地图。

:::


```go
	var state = make(map[int]int)
```


::: {.en}
This `mutex` will synchronize access to `state`.
:::

::: {.zh}

这个`mutex`将同步访问`state`。

:::


```go
	var mutex = &sync.Mutex{}
```


::: {.en}
We'll keep track of how many read and write
operations we do.
:::

::: {.zh}

我们将跟踪我们执行的读写操作数量。

:::


```go
	var readOps uint64
	var writeOps uint64
```


::: {.en}
Here we start 100 goroutines to execute repeated
reads against the state, once per millisecond in
each goroutine.
:::

::: {.zh}

在这里，我们启动100个goroutines来执行针对状态的重复读取，每毫秒一次。

:::


```go
	for r := 0; r < 100; r++ {
		go func() {
			total := 0
			for {
```


::: {.en}
For each read we pick a key to access,
`Lock()` the `mutex` to ensure
exclusive access to the `state`, read
the value at the chosen key,
`Unlock()` the mutex, and increment
the `readOps` count.
:::

::: {.zh}

对于每次读取，我们选择一个键来访问，`Lock（）``mutex`以确保对`state`的唯一访问，读取所选键的值，'解锁（）`互斥锁，并递增'readOps`计数。

:::


```go
				key := rand.Intn(5)
				mutex.Lock()
				total += state[key]
				mutex.Unlock()
				atomic.AddUint64(&readOps, 1)
```


::: {.en}
Wait a bit between reads.
:::

::: {.zh}

在读取之间稍等一下。

:::


```go
				time.Sleep(time.Millisecond)
			}
		}()
	}
```


::: {.en}
We'll also start 10 goroutines to simulate writes,
using the same pattern we did for reads.
:::

::: {.zh}

我们还将使用与读取相同的模式启动10个goroutine来模拟写入。

:::


```go
	for w := 0; w < 10; w++ {
		go func() {
			for {
				key := rand.Intn(5)
				val := rand.Intn(100)
				mutex.Lock()
				state[key] = val
				mutex.Unlock()
				atomic.AddUint64(&writeOps, 1)
				time.Sleep(time.Millisecond)
			}
		}()
	}
```


::: {.en}
Let the 10 goroutines work on the `state` and
`mutex` for a second.
:::

::: {.zh}

让10个goroutines在`state`和`mutex`上工作一秒钟。

:::


```go
	time.Sleep(time.Second)
```


::: {.en}
Take and report final operation counts.
:::

::: {.zh}

获取并报告最终操作计数。

:::


```go
	readOpsFinal := atomic.LoadUint64(&readOps)
	fmt.Println("readOps:", readOpsFinal)
	writeOpsFinal := atomic.LoadUint64(&writeOps)
	fmt.Println("writeOps:", writeOpsFinal)
```


::: {.en}
With a final lock of `state`, show how it ended up.
:::

::: {.zh}

最后锁定`state`，显示它是如何结束的。

:::


```go
	mutex.Lock()
	fmt.Println("state:", state)
	mutex.Unlock()
}
```


::: {.en}
Running the program shows that we executed about
90,000 total operations against our `mutex`-synchronized
`state`.
:::

::: {.zh}

运行程序表明我们对`mutex`-synchronized`state`执行了大约90,000个操作。

:::


```bash
$ go run mutexes.go
readOps: 83285
writeOps: 8320
state: map[1:97 4:53 0:33 2:15 3:2]
```


::: {.en}
Next we'll look at implementing this same state
management task using only goroutines and channels.
:::

::: {.zh}

接下来，我们将仅使用goroutines和channel来实现同样的状态管理任务。

:::


