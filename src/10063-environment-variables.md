
# Environment Variables {.en}


# 环境变量 {.zh}


::: {.en}
[Environment variables](http://en.wikipedia.org/wiki/Environment_variable)
are a universal mechanism for [conveying configuration
information to Unix programs](http://www.12factor.net/config).
Let's look at how to set, get, and list environment variables.
:::

::: {.zh}

[环境变量]（http://en.wikipedia.org/wiki/Environment_variable）是[将配置信息传递给Unix程序]的通用机制（http://www.12factor.net/config）。让我们来看看如何设置，获取和列出环境变量。

:::


```go
package main
import "os"
import "strings"
import "fmt"
func main() {
```


::: {.en}
To set a key/value pair, use `os.Setenv`. To get a
value for a key, use `os.Getenv`. This will return
an empty string if the key isn't present in the
environment.
:::

::: {.zh}

要设置键/值对，请使用`os.Setenv`。要获得密钥的价值，请使用`os.Getenv`。如果该环境中不存在该键，则将返回空字符串。

:::


```go
	os.Setenv("FOO", "1")
	fmt.Println("FOO:", os.Getenv("FOO"))
	fmt.Println("BAR:", os.Getenv("BAR"))
```


::: {.en}
Use `os.Environ` to list all key/value pairs in the
environment. This returns a slice of strings in the
form `KEY=value`. You can `strings.Split` them to
get the key and value. Here we print all the keys.
:::

::: {.zh}

使用`os.Environ`列出环境中的所有键/值对。这将返回形式为“KEY = value”的字符串片段。你可以`strings.Split`他们忘记关键和价值。在这里，我们打印所有的键。

:::


```go
	fmt.Println()
	for _, e := range os.Environ() {
		pair := strings.Split(e, "=")
		fmt.Println(pair[0])
	}
}
```


::: {.en}
Running the program shows that we pick up the value
for `FOO` that we set in the program, but that
`BAR` is empty.
:::

::: {.zh}

运行该程序表明我们获取了我们在程序中设置的“FOO”的值，但是`'#BAR`为空。

:::


```bash
$ go run environment-variables.go
FOO: 1
BAR: 
```


::: {.en}
The list of keys in the environment will depend on your
particular machine.
:::

::: {.zh}

环境中的键列表将取决于您的特定机器。

:::


```bash
TERM_PROGRAM
PATH
SHELL
...
```


::: {.en}
If we set `BAR` in the environment first, the running
program picks that value up.
:::

::: {.zh}

如果我们首先在环境中设置“BAR”，则运行程序会选择该值。

:::


```bash
$ BAR=2 go run environment-variables.go
FOO: 1
BAR: 2
...
```


