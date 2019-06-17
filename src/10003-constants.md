
# Constants {.en}

# 常量 {.zh}

::: {.en}
Go supports _constants_ of character, string, boolean,
and numeric values.
:::

::: {.zh}

Go 支持字符，字符串，布尔值和数值常量。

:::

```go
package main
import "fmt"
import "math"
```

::: {.en}
`const` declares a constant value.
:::

::: {.zh}

使用 `const` 声明一个常量。

:::

```go
const s string = "constant"
func main() {
	fmt.Println(s)
```

::: {.en}
A `const` statement can appear anywhere a `var`
statement can.
:::

::: {.zh}

`const` 语句可以出现在任何 `var` 语句可以出现的地方。

:::

```go
	const n = 500000000
```

::: {.en}
Constant expressions perform arithmetic with
arbitrary precision.
:::

::: {.zh}

常量表达式可执行任意精度的运算。

:::

```go
	const d = 3e20 / n
	fmt.Println(d)
```

::: {.en}
A numeric constant has no type until it's given
one, such as by an explicit conversion.
:::

::: {.zh}

数字常量在给定之前没有类型，例如一次显式类型转换。

:::

```go
	fmt.Println(int64(d))
```

::: {.en}
A number can be given a type by using it in a
context that requires one, such as a variable
assignment or function call. For example, here
`math.Sin` expects a `float64`.
:::

::: {.zh}

数字常量可以在使用它的上下文需要时被给定一个类型，比如变量复制和函数调用时。举例来说，这里 `math.Sin` 函数期望一个 `float64` 类型，那么输出也将是 `float64` 类型。

:::

```go
	fmt.Println(math.Sin(n))
}
```

```bash
$ go run constant.go 
constant
6e+11
600000000000
-0.28470407323754404
```
