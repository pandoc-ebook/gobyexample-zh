
# Exec'ing Processes {.en}


# 执行流程 {.zh}


::: {.en}
In the previous example we looked at
[spawning external processes](spawning-processes). We
do this when we need an external process accessible to
a running Go process. Sometimes we just want to
completely replace the current Go process with another
(perhaps non-Go) one. To do this we'll use Go's
implementation of the classic
<a href="http://en.wikipedia.org/wiki/Exec_(operating_system)"><code>exec</code></a>
function.
:::

::: {.zh}

在前面的例子中，我们研究了[产生外部过程]（产生过程）。当我们需要一个可以运行Go进程的外部进程时，我们会这样做。有时我们只想完全用另一个（也许是非Go）替换当前的Go进程。为此，我们将使用经典<a href="http://en.wikipedia.org/wiki/Exec_(operating_system)"> <code> exec </ code> </a>功能的Go实现。

:::


```go
package main
import "syscall"
import "os"
import "os/exec"
func main() {
```


::: {.en}
For our example we'll exec `ls`. Go requires an
absolute path to the binary we want to execute, so
we'll use `exec.LookPath` to find it (probably
`/bin/ls`).
:::

::: {.zh}

对于我们的例子，我们将执行`ls`。 Go需要一个我们想要执行的二进制文件的绝对路径，sowe将使用`exec.LookPath`来找到它（可能是`/ bin / ls`）。

:::


```go
	binary, lookErr := exec.LookPath("ls")
	if lookErr != nil {
		panic(lookErr)
	}
```


::: {.en}
`Exec` requires arguments in slice form (as
apposed to one big string). We'll give `ls` a few
common arguments. Note that the first argument should
be the program name.
:::

::: {.zh}

`exec`需要切片形式的参数（适用于一个大字符串）。我们将给'ls`一些常见的论点。请注意，第一个参数应该是程序名称。

:::


```go
	args := []string{"ls", "-a", "-l", "-h"}
```


::: {.en}
`Exec` also needs a set of [environment variables](environment-variables)
to use. Here we just provide our current
environment.
:::

::: {.zh}

`Exec`还需要一组[环境变量]（环境变量）来使用。在这里，我们只提供我们的当前环境。

:::


```go
	env := os.Environ()
```


::: {.en}
Here's the actual `syscall.Exec` call. If this call is
successful, the execution of our process will end
here and be replaced by the `/bin/ls -a -l -h`
process. If there is an error we'll get a return
value.
:::

::: {.zh}

这是实际的`syscall.Exec`调用。如果此调用成功，则我们的进程的执行将结束，并由`/ bin / ls -a -l -h`进程替换。如果有错误，我们会得到一个返回值。

:::


```go
	execErr := syscall.Exec(binary, args, env)
	if execErr != nil {
		panic(execErr)
	}
}
```


::: {.en}
When we run our program it is replaced by `ls`.
:::

::: {.zh}

当我们运行程序时，它被`ls`取代。

:::


```bash
$ go run execing-processes.go
total 16
drwxr-xr-x  4 mark 136B Oct 3 16:29 .
drwxr-xr-x 91 mark 3.0K Oct 3 12:50 ..
-rw-r--r--  1 mark 1.3K Oct 3 16:28 execing-processes.go
```


::: {.en}
Note that Go does not offer a classic Unix `fork`
function. Usually this isn't an issue though, since
starting goroutines, spawning processes, and exec'ing
processes covers most use cases for `fork`.
:::

::: {.zh}

请注意，Go不提供经典的Unix`forke`函数。通常这不是问题，因为启动goroutine，产生进程和exec'ingprocesses涵盖了`fork`的大多数用例。

:::


