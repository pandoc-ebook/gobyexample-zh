
# Multiple Return Values {.en}

# 多返回值 {.zh}

::: {.en}
Go has built-in support for _multiple return values_.
This feature is used often in idiomatic Go, for example
to return both result and error values from a function.
:::

::: {.zh}

Go 内置支持多返回值。此功能在 Go 中经常使用，例如从函数同时返回结果和错误值。

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

这个函数中的 `(int，int)` 表明函数返回 2 个 `int` 类型的值。

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

这里我们使用*多赋值操作*来使用这 2 个不同的返回值。

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

如果你只想要返回值的一部分，请使用空标识符 `_`。

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
```

::: {.en}
Accepting a variable number of arguments is another nice
feature of Go functions; we'll look at this next.
:::

::: {.zh}

接受可变数量的参数是 Go 函数的另一个不错的特性；我们接下来会学习此特性。

:::
