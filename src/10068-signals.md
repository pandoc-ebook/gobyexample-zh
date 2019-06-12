
# Signals {.en}


# 信号 {.zh}


::: {.en}
Sometimes we'd like our Go programs to intelligently
handle [Unix signals](http://en.wikipedia.org/wiki/Unix_signal).
For example, we might want a server to gracefully
shutdown when it receives a `SIGTERM`, or a command-line
tool to stop processing input if it receives a `SIGINT`.
Here's how to handle signals in Go with channels.
:::

::: {.zh}

有时我们希望我们的Go程序能够智能地处理[Unix信号]（http://en.wikipedia.org/wiki/Unix_signal）。例如，我们可能希望服务器在收到`SIGTERM`时优雅地关闭，或者命令行工具如果收到`SIGINT`则停止处理输入。这是如何处理带有通道的Go中的信号。

:::


```go
package main
import "fmt"
import "os"
import "os/signal"
import "syscall"
func main() {
```


::: {.en}
Go signal notification works by sending `os.Signal`
values on a channel. We'll create a channel to
receive these notifications (we'll also make one to
notify us when the program can exit).
:::

::: {.zh}

通过在通道上发送`os.Signal`值来发送信号通知。我们将创建一个频道来接收这些通知（我们还会在程序退出时让我们加以通知）。

:::


```go
	sigs := make(chan os.Signal, 1)
	done := make(chan bool, 1)
```


::: {.en}
`signal.Notify` registers the given channel to
receive notifications of the specified signals.
:::

::: {.zh}

`signal.Notify`注册给定的通道以接收指定信号的通知。

:::


```go
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)
```


::: {.en}
This goroutine executes a blocking receive for
signals. When it gets one it'll print it out
and then notify the program that it can finish.
:::

::: {.zh}

这个goroutine执行阻塞接收forsignals。当它得到一个它将打印出来然后通知程序它可以完成。

:::


```go
	go func() {
		sig := <-sigs
		fmt.Println()
		fmt.Println(sig)
		done <- true
	}()
```


::: {.en}
The program will wait here until it gets the
expected signal (as indicated by the goroutine
above sending a value on `done`) and then exit.
:::

::: {.zh}

程序将在此处等待，直到它获得预期的信号（如上所述，在'done`上发送一个值的goroutine指示）然后退出。

:::


```go
	fmt.Println("awaiting signal")
	<-done
	fmt.Println("exiting")
}
```


::: {.en}
When we run this program it will block waiting for a
signal. By typing `ctrl-C` (which the
terminal shows as `^C`) we can send a `SIGINT` signal,
causing the program to print `interrupt` and then exit.
:::

::: {.zh}

当我们运行这个程序时，它将阻止等待信号。通过键入`ctrl-C`（终端显示为`^ C`），我们可以发送`SIGINT`信号，使程序打印`interrupt`然后退出。

:::


```bash
$ go run signals.go
awaiting signal
^C
interrupt
exiting
```


