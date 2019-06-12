
# Select {.en}


# 选择 {.zh}


::: {.en}
Go's _select_ lets you wait on multiple channel
operations. Combining goroutines and channels with
select is a powerful feature of Go.
:::

::: {.zh}

Go的_select_让你等待多个通道。将goroutines和渠道与选择相结合是Go的一个强大功能。

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

对于我们的示例，我们将选择两个通道。

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

每个频道将在一段时间后收到一个值，以模拟例如阻止RPC操作在并发goroutine中执行。

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

我们将使用`select`同时等待这两个值，并在它们到达时打印每个值。

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

我们收到的值是“一个”，然后是“两个”`asexpected。

:::


```sh
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

请注意，总执行时间仅为约2秒，因为1秒和2秒的“睡眠”同时执行。

:::


```sh
real	0m2.245s
```


