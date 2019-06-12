
# Command-Line Arguments {.en}


# 命令行参数 {.zh}


::: {.en}
[_Command-line arguments_](http://en.wikipedia.org/wiki/Command-line_interface#Arguments)
are a common way to parameterize execution of programs.
For example, `go run hello.go` uses `run` and
`hello.go` arguments to the `go` program.
:::

::: {.zh}

[_Command-line arguments_]（http://en.wikipedia.org/wiki/Command-line_interface#Arguments）是参数化程序执行的常用方法。例如，`go run hello.go`使用`run`和`go`程序的`hello.go`参数。

:::


```go
package main
import "os"
import "fmt"
func main() {
```


::: {.en}
`os.Args` provides access to raw command-line
arguments. Note that the first value in this slice
is the path to the program, and `os.Args[1:]`
holds the arguments to the program.
:::

::: {.zh}

`os.Args`提供对原始命令 - 线性参数的访问。请注意，此slice中的第一个值是程序的路径，而`os.Args [1：]`保存程序的参数。

:::


```go
	argsWithProg := os.Args
	argsWithoutProg := os.Args[1:]
```


::: {.en}
You can get individual args with normal indexing.
:::

::: {.zh}

您可以使用正常索引获取单个args。

:::


```go
	arg := os.Args[3]
	fmt.Println(argsWithProg)
	fmt.Println(argsWithoutProg)
	fmt.Println(arg)
}
```


::: {.en}
To experiment with command-line arguments it's best to
build a binary with `go build` first.
:::

::: {.zh}

要试验命令行参数，最好首先使用`go build`构建二进制文件。

:::


```bash
$ go build command-line-arguments.go
$ ./command-line-arguments a b c d
[./command-line-arguments a b c d]       
[a b c d]
c
```


::: {.en}
Next we'll look at more advanced command-line processing
with flags.
:::

::: {.zh}

接下来我们将看看更高级的带标志的命令行处理。

:::


