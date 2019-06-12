
# Writing Files {.en}


# 写文件 {.zh}


::: {.en}
Writing files in Go follows similar patterns to the
ones we saw earlier for reading.
:::

::: {.zh}

在Go中编写文件的方式与我们之前看到的用于阅读的模式类似。

:::


```go
package main
import (
	"bufio"
	"fmt"
	"io/ioutil"
	"os"
)
func check(e error) {
	if e != nil {
		panic(e)
	}
}
func main() {
```


::: {.en}
To start, here's how to dump a string (or just
bytes) into a file.
:::

::: {.zh}

首先，这里是如何将字符串（或justbytes）转储到文件中。

:::


```go
	d1 := []byte("hellongon")
	err := ioutil.WriteFile("/tmp/dat1", d1, 0644)
	check(err)
```


::: {.en}
For more granular writes, open a file for writing.
:::

::: {.zh}

要进行更精细的写入，请打开文件进行写入。

:::


```go
	f, err := os.Create("/tmp/dat2")
	check(err)
```


::: {.en}
It's idiomatic to defer a `Close` immediately
after opening a file.
:::

::: {.zh}

打开文件后立即推迟“关闭”是惯用的。

:::


```go
	defer f.Close()
```


::: {.en}
You can `Write` byte slices as you'd expect.
:::

::: {.zh}

您可以按照预期“写”字节切片。

:::


```go
	d2 := []byte{115, 111, 109, 101, 10}
	n2, err := f.Write(d2)
	check(err)
	fmt.Printf("wrote %d bytesn", n2)
```


::: {.en}
A `WriteString` is also available.
:::

::: {.zh}

`WriteString`也可用。

:::


```go
	n3, err := f.WriteString("writesn")
	fmt.Printf("wrote %d bytesn", n3)
```


::: {.en}
Issue a `Sync` to flush writes to stable storage.
:::

::: {.zh}

发出“同步”以刷新写入稳定存储。

:::


```go
	f.Sync()
```


::: {.en}
`bufio` provides buffered writers in addition
to the buffered readers we saw earlier.
:::

::: {.zh}

`bufio`除了我们之前看到的缓冲读卡器外，还提供缓冲写入器。

:::


```go
	w := bufio.NewWriter(f)
	n4, err := w.WriteString("bufferedn")
	fmt.Printf("wrote %d bytesn", n4)
```


::: {.en}
Use `Flush` to ensure all buffered operations have
been applied to the underlying writer.
:::

::: {.zh}

使用`Flush`确保所有缓冲操作都已应用于底层writer。

:::


```go
	w.Flush()
}
```


::: {.en}
Try running the file-writing code.
:::

::: {.zh}

尝试运行文件编写代码。

:::


```sh
$ go run writing-files.go 
wrote 5 bytes
wrote 7 bytes
wrote 9 bytes
```


::: {.en}
Then check the contents of the written files.
:::

::: {.zh}

然后检查写入文件的内容。

:::


```sh
$ cat /tmp/dat1
hello
go
$ cat /tmp/dat2
some
writes
buffered
```


::: {.en}
Next we'll look at applying some of the file I/O ideas
we've just seen to the `stdin` and `stdout` streams.
:::

::: {.zh}

接下来我们将看看我们刚刚看到的一些文件I / O想法应用于`stdin`和`stdout`流。

:::


