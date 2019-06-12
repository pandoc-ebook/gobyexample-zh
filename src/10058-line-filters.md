
# Line Filters {.en}


# 线路滤波器 {.zh}


::: {.en}
A _line filter_ is a common type of program that reads
input on stdin, processes it, and then prints some
derived result to stdout. `grep` and `sed` are common
line filters.
Here's an example line filter in Go that writes a
capitalized version of all input text. You can use this
pattern to write your own Go line filters.
:::

::: {.zh}

_line filter_是一种常见的程序类型，它读取stdin上的输入，处理它，然后将一些衍生的结果打印到stdout。 `grep`和`sed`是公共线过滤器。这是Go中的一个示例行过滤器，用于写入所有输入文本的资本化版本。您可以使用此模式编写自己的Go行过滤器。

:::


```go
package main
import (
	"bufio"
	"fmt"
	"os"
	"strings"
)
func main() {
```


::: {.en}
Wrapping the unbuffered `os.Stdin` with a buffered
scanner gives us a convenient `Scan` method that
advances the scanner to the next token; which is
the next line in the default scanner.
:::

::: {.zh}

使用bufferedscanner包装无缓冲的`os.Stdin`为我们提供了一种方便的`Scan`方法，可以将扫描器提供给下一个令牌;这是默认扫描仪中的下一行。

:::


```go
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
```


::: {.en}
`Text` returns the current token, here the next line,
from the input.
:::

::: {.zh}

`Text`从输入返回当前标记，这里是下一行。

:::


```go
		ucl := strings.ToUpper(scanner.Text())
```


::: {.en}
Write out the uppercased line.
:::

::: {.zh}

写出大写的线。

:::


```go
		fmt.Println(ucl)
	}
```


::: {.en}
Check for errors during `Scan`. End of file is
expected and not reported by `Scan` as an error.
:::

::: {.zh}

在“扫描”期间检查错误。文件结束是预期的，并且不会被“扫描”报告为错误。

:::


```go
	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "error:", err)
		os.Exit(1)
	}
}
```


::: {.en}
To try out our line filter, first make a file with a few
lowercase lines.
:::

::: {.zh}

要试用我们的线路过滤器，首先要制作一个带有一些低速线路的文件。

:::


```bash
$ echo 'hello'   > /tmp/lines
$ echo 'filter' >> /tmp/lines
```


::: {.en}
Then use the line filter to get uppercase lines.
:::

::: {.zh}

然后使用线条过滤器获取大写行。

:::


```bash
$ cat /tmp/lines | go run line-filters.go
HELLO
FILTER
```


