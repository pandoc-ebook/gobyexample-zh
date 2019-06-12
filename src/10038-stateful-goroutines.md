
# Stateful Goroutines {.en}


# 有状态的Goroutines {.zh}


::: {.en}
In the previous example we used explicit locking with
[mutexes](mutexes) to synchronize access to shared state
across multiple goroutines. Another option is to use the
built-in synchronization features of  goroutines and
channels to achieve the same result. This channel-based
approach aligns with Go's ideas of sharing memory by
communicating and having each piece of data owned
by exactly 1 goroutine.
:::

::: {.zh}

在前面的示例中，我们使用显式锁定[mutexes]（互斥锁）来同步对多个goroutine的共享状态的访问。另一个选择是使用goroutines和channel的内置同步功能来实现相同的结果。这种基于通道的方法与Go的共享内存的想法保持一致，通过通信和每个数据拥有正好1 goroutine。

:::


```go
package main
import (
	"fmt"
	"math/rand"
	"sync/atomic"
	"time"
)
```


::: {.en}
In this example our state will be owned by a single
goroutine. This will guarantee that the data is never
corrupted with concurrent access. In order to read or
write that state, other goroutines will send messages
to the owning goroutine and receive corresponding
replies. These `readOp` and `writeOp` `struct`s
encapsulate those requests and a way for the owning
goroutine to respond.
:::

::: {.zh}

在这个例子中，我们的州将由一个单一的路由所有。这将保证数据永远不会因并发访问而受损。为了读取或写入该状态，其他goroutine将向拥有的goroutine发送消息并接收相应的提示。这些`readOp`和`writeOp``struct`sencapsulate这些请求和一个拥有goutoutine响应的方式。

:::


```go
type readOp struct {
	key  int
	resp chan int
}
type writeOp struct {
	key  int
	val  int
	resp chan bool
}
func main() {
```


::: {.en}
As before we'll count how many operations we perform.
:::

::: {.zh}

和以前一样，我们将计算我们执行的操作数量。

:::


```go
	var readOps uint64
	var writeOps uint64
```


::: {.en}
The `reads` and `writes` channels will be used by
other goroutines to issue read and write requests,
respectively.
:::

::: {.zh}

“读取”和“写入”通道将被其他goroutines用于分别发出读取和写入请求。

:::


```go
	reads := make(chan readOp)
	writes := make(chan writeOp)
```


::: {.en}
Here is the goroutine that owns the `state`, which
is a map as in the previous example but now private
to the stateful goroutine. This goroutine repeatedly
selects on the `reads` and `writes` channels,
responding to requests as they arrive. A response
is executed by first performing the requested
operation and then sending a value on the response
channel `resp` to indicate success (and the desired
value in the case of `reads`).
:::

::: {.zh}

这是拥有`state`的goroutine，这是一个如前例所示的地图，但现在私有的有状态goroutine。这个goroutine在“读取”和“写入”通道上反复选择，在它们到达时响应请求。响应是通过首先执行所请求的操作然后在responsechannel`resp`上发送一个值来表示成功（以及“读取”的情况下的期望值）来执行的。

:::


```go
	go func() {
		var state = make(map[int]int)
		for {
			select {
			case read := <-reads:
				read.resp <- state[read.key]
			case write := <-writes:
				state[write.key] = write.val
				write.resp <- true
			}
		}
	}()
```


::: {.en}
This starts 100 goroutines to issue reads to the
state-owning goroutine via the `reads` channel.
Each read requires constructing a `readOp`, sending
it over the `reads` channel, and the receiving the
result over the provided `resp` channel.
:::

::: {.zh}

这将启动100个goroutines，通过`reads`通道向状态拥有的goroutine发出读取。每次读取都需要构建一个`readOp`，通过`reads`通道发送，并通过提供的`resp`通道接收结果。

:::


```go
	for r := 0; r < 100; r++ {
		go func() {
			for {
				read := readOp{
					key:  rand.Intn(5),
					resp: make(chan int)}
				reads <- read
				<-read.resp
				atomic.AddUint64(&readOps, 1)
				time.Sleep(time.Millisecond)
			}
		}()
	}
```


::: {.en}
We start 10 writes as well, using a similar
approach.
:::

::: {.zh}

我们也使用similarapproach开始10次写入。

:::


```go
	for w := 0; w < 10; w++ {
		go func() {
			for {
				write := writeOp{
					key:  rand.Intn(5),
					val:  rand.Intn(100),
					resp: make(chan bool)}
				writes <- write
				<-write.resp
				atomic.AddUint64(&writeOps, 1)
				time.Sleep(time.Millisecond)
			}
		}()
	}
```


::: {.en}
Let the goroutines work for a second.
:::

::: {.zh}

让goroutines工作一秒钟。

:::


```go
	time.Sleep(time.Second)
```


::: {.en}
Finally, capture and report the op counts.
:::

::: {.zh}

最后，捕获并报告操作计数。

:::


```go
	readOpsFinal := atomic.LoadUint64(&readOps)
	fmt.Println("readOps:", readOpsFinal)
	writeOpsFinal := atomic.LoadUint64(&writeOps)
	fmt.Println("writeOps:", writeOpsFinal)
}
```


::: {.en}
Running our program shows that the goroutine-based
state management example completes about 80,000
total operations.
:::

::: {.zh}

运行我们的程序表明，基于goroutine的状态管理示例完成了大约80,000个总操作。

:::


```sh
$ go run stateful-goroutines.go
readOps: 71708
writeOps: 7177
```


::: {.en}
For this particular case the goroutine-based approach
was a bit more involved than the mutex-based one. It
might be useful in certain cases though, for example
where you have other channels involved or when managing
multiple such mutexes would be error-prone. You should
use whichever approach feels most natural, especially
with respect to understanding the correctness of your
program.
:::

::: {.zh}

对于这种特殊情况，基于goroutine的方法比基于互斥锁的方法更复杂。在某些情况下，它可能很有用，例如，当您涉及其他通道或管理多个此类互斥锁时容易出错。你应该使用任何最自然的方法，特别是在理解你的程序的正确性方面。

:::


