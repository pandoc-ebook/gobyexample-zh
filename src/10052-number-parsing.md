
# Number Parsing {.en}


# 数字解析 {.zh}


::: {.en}
Parsing numbers from strings is a basic but common task
in many programs; here's how to do it in Go.
:::

::: {.zh}

从字符串中解析数字是许多程序中基本但常见的任务;这是在Go中如何做到的。

:::


```go
package main
```


::: {.en}
The built-in package `strconv` provides the number
parsing.
:::

::: {.zh}

内置包`strconv`提供了numberparsing。

:::


```go
import "strconv"
import "fmt"
func main() {
```


::: {.en}
With `ParseFloat`, this `64` tells how many bits of
precision to parse.
:::

::: {.zh}

使用`ParseFloat`，这个`64`表示要解析的精确位数。

:::


```go
	f, _ := strconv.ParseFloat("1.234", 64)
	fmt.Println(f)
```


::: {.en}
For `ParseInt`, the `0` means infer the base from
the string. `64` requires that the result fit in 64
bits.
:::

::: {.zh}

对于`ParseInt`，“0”表示从字符串推断出基数。 `64`要求结果适合64位。

:::


```go
	i, _ := strconv.ParseInt("123", 0, 64)
	fmt.Println(i)
```


::: {.en}
`ParseInt` will recognize hex-formatted numbers.
:::

::: {.zh}

`ParseInt`将识别十六进制格式的数字。

:::


```go
	d, _ := strconv.ParseInt("0x1c8", 0, 64)
	fmt.Println(d)
```


::: {.en}
A `ParseUint` is also available.
:::

::: {.zh}

还可以使用`ParseUint`。

:::


```go
	u, _ := strconv.ParseUint("789", 0, 64)
	fmt.Println(u)
```


::: {.en}
`Atoi` is a convenience function for basic base-10
`int` parsing.
:::

::: {.zh}

`Atoi`是基本的10`int`解析的便利函数。

:::


```go
	k, _ := strconv.Atoi("135")
	fmt.Println(k)
```


::: {.en}
Parse functions return an error on bad input.
:::

::: {.zh}

解析函数在输入错误时返回错误。

:::


```go
	_, e := strconv.Atoi("wat")
	fmt.Println(e)
}
```


```bash
$ go run number-parsing.go 
1.234
123
456
789
135
strconv.ParseInt: parsing "wat": invalid syntax
```


::: {.en}
Next we'll look at another common parsing task: URLs.
:::

::: {.zh}

接下来我们将看另一个常见的解析任务：URL。

:::


