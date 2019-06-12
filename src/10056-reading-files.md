
# Reading Files {.en}


# 阅读文件 {.zh}


::: {.en}
Reading and writing files are basic tasks needed for
many Go programs. First we'll look at some examples of
reading files.
:::

::: {.zh}

读取和写入文件是许多Go程序所需的基本任务。首先，我们将看一些阅读文件的例子。

:::


```go
package main
import (
	"bufio"
	"fmt"
	"io"
	"io/ioutil"
	"os"
)
```


::: {.en}
Reading files requires checking most calls for errors.
This helper will streamline our error checks below.
:::

::: {.zh}

读取文件需要检查大多数错误调用。这个帮助程序将简化我们的错误检查。

:::


```go
func check(e error) {
	if e != nil {
		panic(e)
	}
}
func main() {
```


::: {.en}
Perhaps the most basic file reading task is
slurping a file's entire contents into memory.
:::

::: {.zh}

也许最基本的文件读取任务是将文件的全部内容发送到内存中。

:::


```go
	dat, err := ioutil.ReadFile("/tmp/dat")
	check(err)
	fmt.Print(string(dat))
```


::: {.en}
You'll often want more control over how and what
parts of a file are read. For these tasks, start
by `Open`ing a file to obtain an `os.File` value.
:::

::: {.zh}

您经常需要更多地控制文件的读取方式和部分内容。对于这些任务，从`打开'文件开始获取`os.File`值。

:::


```go
	f, err := os.Open("/tmp/dat")
	check(err)
```


::: {.en}
Read some bytes from the beginning of the file.
Allow up to 5 to be read but also note how many
actually were read.
:::

::: {.zh}

从文件的开头读取一些字节。最多可读取5个字节，但也要注意读取的实际数量。

:::


```go
	b1 := make([]byte, 5)
	n1, err := f.Read(b1)
	check(err)
	fmt.Printf("%d bytes: %sn", n1, string(b1[:n1]))
```


::: {.en}
You can also `Seek` to a known location in the file
and `Read` from there.
:::

::: {.zh}

您还可以“查找”文件中的已知位置和“读取”。

:::


```go
	o2, err := f.Seek(6, 0)
	check(err)
	b2 := make([]byte, 2)
	n2, err := f.Read(b2)
	check(err)
	fmt.Printf("%d bytes @ %d: ", n2, o2)
	fmt.Printf("%vn", string(b2[:n2]))
```


::: {.en}
The `io` package provides some functions that may
be helpful for file reading. For example, reads
like the ones above can be more robustly
implemented with `ReadAtLeast`.
:::

::: {.zh}

`io`包提供了一些可能有助于文件读取的功能。例如，使用`ReadAtLeast`可以更加稳健地实现上述读取。

:::


```go
	o3, err := f.Seek(6, 0)
	check(err)
	b3 := make([]byte, 2)
	n3, err := io.ReadAtLeast(f, b3, 2)
	check(err)
	fmt.Printf("%d bytes @ %d: %sn", n3, o3, string(b3))
```


::: {.en}
There is no built-in rewind, but `Seek(0, 0)`
accomplishes this.
:::

::: {.zh}

没有内置的倒带，但是`Seek（0,0）`完成了这个。

:::


```go
	_, err = f.Seek(0, 0)
	check(err)
```


::: {.en}
The `bufio` package implements a buffered
reader that may be useful both for its efficiency
with many small reads and because of the additional
reading methods it provides.
:::

::: {.zh}

`bufio`包实现了一个bufferedreader，它既可以用于许多小读取的效率，也可以用于它提供的附加读取方法。

:::


```go
	r4 := bufio.NewReader(f)
	b4, err := r4.Peek(5)
	check(err)
	fmt.Printf("5 bytes: %sn", string(b4))
```


::: {.en}
Close the file when you're done (usually this would
be scheduled immediately after `Open`ing with
`defer`).
:::

::: {.zh}

完成后关闭文件（通常这将在`使用`defer`打开后立即安排）。

:::


```go
	f.Close()
}
```


```bash
$ echo "hello" > /tmp/dat
$ echo "go" >>   /tmp/dat
$ go run reading-files.go
hello
go
5 bytes: hello
2 bytes @ 6: go
2 bytes @ 6: go
5 bytes: hello
```


::: {.en}
Next we'll look at writing files.
:::

::: {.zh}

接下来我们将看看编写文件。

:::


