
# Spawning Processes {.en}


# 产卵过程 {.zh}


::: {.en}
Sometimes our Go programs need to spawn other, non-Go
processes. For example, the syntax highlighting on this
site is [implemented](https://github.com/mmcgrana/gobyexample/blob/master/tools/generate.go)
by spawning a [`pygmentize`](http://pygments.org/)
process from a Go program. Let's look at a few examples
of spawning processes from Go.
:::

::: {.zh}

有时我们的Go程序需要产生其他非Goprocesses。例如，通过生成[`pygmentize`]（http：// pygments，[实现]（https://github.com/mmcgrana/gobyexample/blob/master/tools/generate.go），在此网站上突出显示语法。 org /）来自Go程序的过程。让我们看一下Go的产卵过程的几个例子。

:::


```go
package main
import "fmt"
import "io/ioutil"
import "os/exec"
func main() {
```


::: {.en}
We'll start with a simple command that takes no
arguments or input and just prints something to
stdout. The `exec.Command` helper creates an object
to represent this external process.
:::

::: {.zh}

我们将从一个简单的命令开始，该命令不带任何参数或输入，只打印出一些东西。 `exec.Command`助手创建一个对象来表示这个外部进程。

:::


```go
	dateCmd := exec.Command("date")
```


::: {.en}
`.Output` is another helper that handles the common
case of running a command, waiting for it to finish,
and collecting its output. If there were no errors,
`dateOut` will hold bytes with the date info.
:::

::: {.zh}

`.Output`是另一个帮助程序，它处理运行命令，等待它完成并收集其输出的常见情况。如果没有错误，`dateOut`将保存带有日期信息的字节。

:::


```go
	dateOut, err := dateCmd.Output()
	if err != nil {
		panic(err)
	}
	fmt.Println("> date")
	fmt.Println(string(dateOut))
```


::: {.en}
Next we'll look at a slightly more involved case
where we pipe data to the external process on its
`stdin` and collect the results from its `stdout`.
:::

::: {.zh}

接下来我们将看一个稍微复杂的案例，我们将数据传输到其`stdin`上的外部进程，并从`stdout`收集结果。

:::


```go
	grepCmd := exec.Command("grep", "hello")
```


::: {.en}
Here we explicitly grab input/output pipes, start
the process, write some input to it, read the
resulting output, and finally wait for the process
to exit.
:::

::: {.zh}

在这里，我们明确地获取输入/输出管道，启动进程，向其写入一些输入，读取结果输出，最后等待进程退出。

:::


```go
	grepIn, _ := grepCmd.StdinPipe()
	grepOut, _ := grepCmd.StdoutPipe()
	grepCmd.Start()
	grepIn.Write([]byte("hello grepngoodbye grep"))
	grepIn.Close()
	grepBytes, _ := ioutil.ReadAll(grepOut)
	grepCmd.Wait()
```


::: {.en}
We ommited error checks in the above example, but
you could use the usual `if err != nil` pattern for
all of them. We also only collect the `StdoutPipe`
results, but you could collect the `StderrPipe` in
exactly the same way.
:::

::: {.zh}

我们在上面的例子中省略了错误检查，但你可以使用通常的`if err！= nil`模式。我们也只收集`StdoutPipe`结果，但你可以用不同的方式收集`StderrPipe`。

:::


```go
	fmt.Println("> grep hello")
	fmt.Println(string(grepBytes))
```


::: {.en}
Note that when spawning commands we need to
provide an explicitly delineated command and
argument array, vs. being able to just pass in one
command-line string. If you want to spawn a full
command with a string, you can use `bash`'s `-c`
option:
:::

::: {.zh}

请注意，在生成命令时，我们需要提供一个显式描述的命令和参数数组，而不能只传入一个命令行字符串。如果你想用字符串生成一个fullcommand，你可以使用`bash`的`-c`选项：

:::


```go
	lsCmd := exec.Command("bash", "-c", "ls -a -l -h")
	lsOut, err := lsCmd.Output()
	if err != nil {
		panic(err)
	}
	fmt.Println("> ls -a -l -h")
	fmt.Println(string(lsOut))
}
```


::: {.en}
The spawned programs return output that is the same
as if we had run them directly from the command-line.
:::

::: {.zh}

生成的程序返回的输出与我们直接从命令行运行它们的输出相同。

:::


```bash
$ go run spawning-processes.go 
> date
Wed Oct 10 09:53:11 PDT 2012
> grep hello
hello grep
> ls -a -l -h
drwxr-xr-x  4 mark 136B Oct 3 16:29 .
drwxr-xr-x 91 mark 3.0K Oct 3 12:50 ..
-rw-r--r--  1 mark 1.3K Oct 3 16:28 spawning-processes.go
```


