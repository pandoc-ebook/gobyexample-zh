
# Multiple Return Values {.en}


# 多个返回值 {.zh}


::: {.en}
Go has built-in support for _multiple return values_.
This feature is used often in idiomatic Go, for example
to return both result and error values from a function.
:::

::: {.zh}

Go内置支持_multiple返回值_。此功能常用于惯用Go，例如从函数返回结果和错误值。

:::


```go
package main
import "fmt"
```


::: {.en}
The `(int, int)` in this function signature shows that
the function returns 2 `int`s.
:::

::: {.zh}

这个函数签名中的`（int，int）`表明函数返回2`int`s。

:::


```go
func vals() (int, int) {
	return 3, 7
}
func main() {
```


::: {.en}
Here we use the 2 different return values from the
call with _multiple assignment_.
:::

::: {.zh}

这里我们使用来自call的2个不同的返回值和_multiple assignment_。

:::


```go
	a, b := vals()
	fmt.Println(a)
	fmt.Println(b)
```


::: {.en}
If you only want a subset of the returned values,
use the blank identifier `_`.
:::

::: {.zh}

如果您只想要返回值的子集，请使用空标识符`_`。

:::


```go
	_, c := vals()
	fmt.Println(c)
}
```


```bash
$ go run multiple-return-values.go
3
7
7
```


::: {.en}
Accepting a variable number of arguments is another nice
feature of Go functions; we'll look at this next.
:::

::: {.zh}

接受可变数量的参数是Go函数的另一个不错的特征;我们接下来会看看这个。

:::


