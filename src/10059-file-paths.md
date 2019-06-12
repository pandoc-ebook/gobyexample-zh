
# File Paths {.en}


# 文件路径 {.zh}


::: {.en}
The `filepath` package provides functions to parse
and construct *file paths* in a way that is portable
between operating systems; `dir/file` on Linux vs.
`dirfile` on Windows, for example.
:::

::: {.zh}

`filepath`包提供了以可在操作系统之间移植的方式解析和构造*文件路径*的函数;例如，Windows上的`dir / file`和Windows上的.dirfile`。

:::


```go
package main
import (
	"fmt"
	"path/filepath"
	"strings"
)
func main() {
```


::: {.en}
`Join` should be used to construct paths in a
portable way. It takes any number of arguments
and constructs a hierarchical path from them.
:::

::: {.zh}

`Join`应该用于以便携方式构造路径。它接受任意数量的参数并从中构造分层路径。

:::


```go
	p := filepath.Join("dir1", "dir2", "filename")
	fmt.Println("p:", p)
```


::: {.en}
You should always use `Join` instead of
concatenating `/`s or ``s manually. In addition
to providing portability, `Join` will also
normalize paths by removing superfluous separators
and directory changes.
:::

::: {.zh}

你应该总是使用`Join`而不是手动连接`/`s或`s。除了提供可移植性之外，`Join`还会通过删除多余的分隔符和目录更改来对路径进行alsonormal化。

:::


```go
	fmt.Println(filepath.Join("dir1//", "filename"))
	fmt.Println(filepath.Join("dir1/../dir1", "filename"))
```


::: {.en}
`Dir` and `Base` can be used to split a path to the
directory and the file. Alternatively, `Split` will
return both in the same call.
:::

::: {.zh}

`Dir`和`Base`可用于分割目录和文件的路径。或者，`Split`将在同一个调用中返回。

:::


```go
	fmt.Println("Dir(p):", filepath.Dir(p))
	fmt.Println("Base(p):", filepath.Base(p))
```


::: {.en}
We can check whether a path is absolute.
:::

::: {.zh}

我们可以检查路径是否是绝对的。

:::


```go
	fmt.Println(filepath.IsAbs("dir/file"))
	fmt.Println(filepath.IsAbs("/dir/file"))
	filename := "config.json"
```


::: {.en}
Some file names have extensions following a dot. We
can split the extension out of such names with `Ext`.
:::

::: {.zh}

某些文件名在点后面有扩展名。我们可以使用`Ext`将扩展名从这些名称中分离出来。

:::


```go
	ext := filepath.Ext(filename)
	fmt.Println(ext)
```


::: {.en}
To find the file's name with the extension removed,
use `strings.TrimSuffix`.
:::

::: {.zh}

要找到删除了扩展名的文件名，请使用`strings.TrimSuffix`。

:::


```go
	fmt.Println(strings.TrimSuffix(filename, ext))
```


::: {.en}
`Rel` finds a relative path between a *base* and a
*target*. It returns an error if the target cannot
be made relative to base.
:::

::: {.zh}

`Rel`找到* base *和* * *之间的相对路径。如果目标不能相对于base，则返回错误。

:::


```go
	rel, err := filepath.Rel("a/b", "a/b/t/file")
	if err != nil {
		panic(err)
	}
	fmt.Println(rel)
	rel, err = filepath.Rel("a/b", "a/c/t/file")
	if err != nil {
		panic(err)
	}
	fmt.Println(rel)
}
```


```bash
$ go run file-paths.go
p: dir1/dir2/filename
dir1/filename
dir1/filename
Dir(p): dir1/dir2
Base(p): filename
false
true
.json
config
t/file
../c/t/file
```


