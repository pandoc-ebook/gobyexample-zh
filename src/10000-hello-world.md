
# Hello World {.en}


# 你好，世界 {.zh}


::: {.en}
Our first program will print the classic "hello world"
message. Here's the full source code.
:::

::: {.zh}

我们的第一个程序将打印经典的“hello world”消息。这是完整的源代码。

:::


```go
package main
import "fmt"
func main() {
	fmt.Println("hello world")
}
```


::: {.en}
To run the program, put the code in `hello-world.go` and
use `go run`.
:::

::: {.zh}

要运行该程序，请将代码放在`hello-world.go`中并使用`go run`。

:::


```sh
$ go run hello-world.go
hello world
```


::: {.en}
Sometimes we'll want to build our programs into
binaries. We can do this using `go build`.
:::

::: {.zh}

有时候我们会想把我们的程序构建成二进制文件。我们可以使用`go build`来做到这一点。

:::


```sh
$ go build hello-world.go
$ ls
hello-world	hello-world.go
```


::: {.en}
We can then execute the built binary directly.
:::

::: {.zh}

然后我们可以直接执行构建的二进制文件

:::


```sh
$ ./hello-world
hello world
```


::: {.en}
Now that we can run and build basic Go programs, let's
learn more about the language.
:::

::: {.zh}

既然我们可以运行并构建基本的Go程序，那么我们将更多地了解该语言。

:::


