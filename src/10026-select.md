
# Select {.en}

# 通道选择器 {.zh}

::: {.en}
Go's _select_ lets you wait on multiple channel
operations. Combining goroutines and channels with
select is a powerful feature of Go.
:::

::: {.zh}

Go 的*通道选择器*让你可以同时等待多个通道操作。Go 协程和通道以及选择器的结合是 Go 的一个强大特性。

:::

```go
package main
import "time"
import "fmt"
func main() {
```

::: {.en}
For our example we'll select across two channels.
:::

::: {.zh}

对于我们的示例，我们将在两个通道中选择。

:::

```go
	c1 := make(chan string)
	c2 := make(chan string)
```

::: {.en}
Each channel will receive a value after some amount
of time, to simulate e.g. blocking RPC operations
executing in concurrent goroutines.
:::

::: {.zh}

各个通道将在若干时间后接收一个值，这个用来模拟例如 并行的 Go 协程中阻塞的 RPC 操作

:::

```go
	go func() {
		time.Sleep(1 * time.Second)
		c1 <- "one"
	}()
	go func() {
		time.Sleep(2 * time.Second)
		c2 <- "two"
	}()
```

::: {.en}
We'll use `select` to await both of these values
simultaneously, printing each one as it arrives.
:::

::: {.zh}

我们使用 select 关键字来同时等待这两个值，并打 印各自接收到的值。

:::

```go
	for i := 0; i < 2; i++ {
		select {
		case msg1 := <-c1:
			fmt.Println("received", msg1)
		case msg2 := <-c2:
			fmt.Println("received", msg2)
		}
	}
}
```

::: {.en}
We receive the values `"one"` and then `"two"` as
expected.
:::

::: {.zh}

我们首先接收到值 "one"，然后就是预料中的 "two" 了。

:::

```bash
$ time go run select.go 
received one
received two
```

::: {.en}
Note that the total execution time is only ~2 seconds
since both the 1 and 2 second `Sleeps` execute
concurrently.
:::

::: {.zh}

注意从第一次和第二次 Sleeps 并发执行，总共仅运行了 两秒左右。

:::

```bash
real	0m2.245s
```
