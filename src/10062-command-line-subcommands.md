
# Command-Line Subcommands {.en}


# 命令行子命令 {.zh}


::: {.en}
Some command-line tools, like the `go` tool or `git`
have many *subcommands*, each with its own set of
flags. For example, `go build` and `go get` are two
different subcommands of the `go` tool.
The `flag` package lets us easily define simple
subcommands that have their own flags.
:::

::: {.zh}

一些命令行工具，比如`go`工具或`git`有很多*子命令*，每个工具都有自己的set offlags。例如，`go build`和`go get`是`go`工具的两个不同的子命令.`flag`包让我们可以轻松定义具有自己标志的simplesubcommands。

:::


```go
package main
import (
	"flag"
	"fmt"
	"os"
)
func main() {
```


::: {.en}
We declare a subcommand using the `NewFlagSet`
function, and proceed to define new flags specific
for this subcommand.
:::

::: {.zh}

我们使用`NewFlagSet`函数声明一个子命令，然后继续定义特定于该子命令的新标志。

:::


```go
	fooCmd := flag.NewFlagSet("foo", flag.ExitOnError)
	fooEnable := fooCmd.Bool("enable", false, "enable")
	fooName := fooCmd.String("name", "", "name")
```


::: {.en}
For a different subcommand we can define different
supported flags.
:::

::: {.zh}

对于不同的子命令，我们可以定义不同的支持标志。

:::


```go
	barCmd := flag.NewFlagSet("bar", flag.ExitOnError)
	barLevel := barCmd.Int("level", 0, "level")
```


::: {.en}
The subcommand is expected as the first argument
to the program.
:::

::: {.zh}

子命令被期望作为程序的第一个参数。

:::


```go
	if len(os.Args) < 2 {
		fmt.Println("expected 'foo' or 'bar' subcommands")
		os.Exit(1)
	}
```


::: {.en}
Check which subcommand is invoked.
:::

::: {.zh}

检查调用哪个子命令。

:::


```go
	switch os.Args[1] {
```


::: {.en}
For every subcommand, we parse its own flags and
have access to trailing positional arguments.
:::

::: {.zh}

对于每个子命令，我们解析自己的标志并可以访问尾随位置参数。

:::


```go
	case "foo":
		fooCmd.Parse(os.Args[2:])
		fmt.Println("subcommand 'foo'")
		fmt.Println("  enable:", *fooEnable)
		fmt.Println("  name:", *fooName)
		fmt.Println("  tail:", fooCmd.Args())
	case "bar":
		barCmd.Parse(os.Args[2:])
		fmt.Println("subcommand 'bar'")
		fmt.Println("  level:", *barLevel)
		fmt.Println("  tail:", barCmd.Args())
	default:
		fmt.Println("expected 'foo' or 'bar' subcommands")
		os.Exit(1)
	}
}
```


```bash
$ go build command-line-subcommands.go 
```


::: {.en}
First invoke the foo subcommand.
:::

::: {.zh}

首先调用foo子命令。

:::


```bash
$ ./command-line-subcommands foo -enable -name=joe a1 a2
subcommand 'foo'
  enable: true
  name: joe
  tail: [a1 a2]
```


::: {.en}
Now try bar.
:::

::: {.zh}

现在试试吧。

:::


```bash
$ ./command-line-subcommands bar -level 8 a1
subcommand 'bar'
  level: 8
  tail: [a1]
```


::: {.en}
But bar won't accept foo's flags.
:::

::: {.zh}

但酒吧不会接受foo的旗帜。

:::


```bash
$ ./command-line-subcommands bar -enable a1
flag provided but not defined: -enable
Usage of bar:
  -level int
    	level
```


