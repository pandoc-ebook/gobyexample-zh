
# Constants {.en}


# 常量 {.zh}


::: {.en}
Go supports _constants_ of character, string, boolean,
and numeric values.
:::

::: {.zh}

Go支持字符，字符串，布尔值和数值的_constants_。

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

`const`声明一个常量值。

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

`const`语句可以出现在`var`语句的任何地方。

:::


```go
	const n = 500000000
```


::: {.en}
Constant expressions perform arithmetic with
arbitrary precision.
:::

::: {.zh}

常量表达式执行算术任意精度。

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

数字常量在给定之前没有类型，例如通过显式转换。

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

可以通过在需要一个的acontext中使用它来赋予数字类型，例如变量赋值或函数调用。例如，这里``sth.Sin`期望一个`float64`。

:::


```go
	fmt.Println(math.Sin(n))
}
```


```sh
$ go run constant.go 
constant
6e+11
600000000000
-0.28470407323754404
```


