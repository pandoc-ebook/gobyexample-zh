
# Variables {.en}

# 变量 {.zh}

::: {.en}
In Go, _variables_ are explicitly declared and used by
the compiler to e.g. check type-correctness of function
calls.
:::

::: {.zh}

在 Go 中，_variables_ 被显式声明并由编译器用于例如检查函数调用时的类型正确性。

:::

```go
package main
import "fmt"
func main() {
```

::: {.en}
`var` declares 1 or more variables.
:::

::: {.zh}

`var`声明一个或多个变量。

:::

```go
	var a = "initial"
	fmt.Println(a)
```

::: {.en}
You can declare multiple variables at once.
:::

::: {.zh}

你可以一次声明多个变量。

:::

```go
	var b, c int = 1, 2
	fmt.Println(b, c)
```

::: {.en}
Go will infer the type of initialized variables.
:::

::: {.zh}

Go 将推断已初始化的变量的类型。

:::

```go
	var d = true
	fmt.Println(d)
```

::: {.en}
Variables declared without a corresponding
initialization are _zero-valued_. For example, the
zero value for an `int` is `0`.
:::

::: {.zh}

在没有相应的初始化的情况下声明的变量是 _zero-valued_。例如，`int` 的零值是 `0`。

:::

```go
	var e int
	fmt.Println(e)
```

::: {.en}
The `:=` syntax is shorthand for declaring and
initializing a variable, e.g. for
`var f string = "apple"` in this case.
:::

::: {.zh}

`:=` 语法是声明和初始化变量的简写，例如这个例子中的 `var f string = "apple"`。

:::

```go
	f := "apple"
	fmt.Println(f)
}
```

```bash
$ go run variables.go
initial
1 2
true
0
apple
```
