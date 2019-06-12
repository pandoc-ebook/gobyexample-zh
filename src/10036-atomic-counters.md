
# Atomic Counters {.en}


# 原子计数器 {.zh}


::: {.en}
The primary mechanism for managing state in Go is
communication over channels. We saw this for example
with [worker pools](worker-pools). There are a few other
options for managing state though. Here we'll
look at using the `sync/atomic` package for _atomic
counters_ accessed by multiple goroutines.
:::

::: {.zh}

Go中管理状态的主要机制是通过渠道进行通信。我们在[工作池]（工作池）中看到了这一点。但是，有一些其他选项用于管理州。这里我们将看到使用多个goroutines访问的_atomiccounters_的`sync / atomic`包。

:::


```go
package main
import "fmt"
import "time"
import "sync/atomic"
func main() {
```


::: {.en}
We'll use an unsigned integer to represent our
(always-positive) counter.
:::

::: {.zh}

我们将使用无符号整数来表示我们的（始终为正）计数器。

:::


```go
	var ops uint64
```


::: {.en}
To simulate concurrent updates, we'll start 50
goroutines that each increment the counter about
once a millisecond.
:::

::: {.zh}

为了模拟并发更新，我们将启动50goroutines，每个增加计数器大约一毫秒。

:::


```go
	for i := 0; i < 50; i++ {
		go func() {
			for {
```


::: {.en}
To atomically increment the counter we
use `AddUint64`, giving it the memory
address of our `ops` counter with the
`&` syntax.
:::

::: {.zh}

为了原子地递增计数器，我们使用`AddUint64`，给它带有`＆`语法的`ops`计数器的memoryaddress。

:::


```go
				atomic.AddUint64(&ops, 1)
```


::: {.en}
Wait a bit between increments.
:::

::: {.zh}

在增量之间稍等一下。

:::


```go
				time.Sleep(time.Millisecond)
			}
		}()
	}
```


::: {.en}
Wait a second to allow some ops to accumulate.
:::

::: {.zh}

等一下，允许一些操作积累。

:::


```go
	time.Sleep(time.Second)
```


::: {.en}
In order to safely use the counter while it's still
being updated by other goroutines, we extract a
copy of the current value into `opsFinal` via
`LoadUint64`. As above we need to give this
function the memory address `&ops` from which to
fetch the value.
:::

::: {.zh}

为了安全地使用计数器，当它仍然由其他goroutine更新时，我们通过`LOadUint64`将当前值的副本提取到“opsFinal”。如上所述，我们需要给这个函数提供内存地址`＆ops`，从中获取值。

:::


```go
	opsFinal := atomic.LoadUint64(&ops)
	fmt.Println("ops:", opsFinal)
}
```


::: {.en}
Running the program shows that we executed about
40,000 operations.
:::

::: {.zh}

运行该程序表明我们执行了约40,000次操作。

:::


```sh
$ go run atomic-counters.go
ops: 41419
```


::: {.en}
Next we'll look at mutexes, another tool for managing
state.
:::

::: {.zh}

接下来我们将介绍互斥体，这是另一个管理状态的工具。

:::


