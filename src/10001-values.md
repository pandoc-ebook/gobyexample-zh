
# Values {.en}

# 值 {.zh}

::: {.en}
Go has various value types including strings,
integers, floats, booleans, etc. Here are a few
basic examples.
:::

::: {.zh}

Go 有各种值类型，包括字符串，整数，浮点数，布尔值等。这里有一些基本的例子。

:::

```go
package main
import "fmt"
func main() {
```

::: {.en}
Strings, which can be added together with `+`.
:::

::: {.zh}

字符串可以用`+`连接。

:::

```go
	fmt.Println("go" + "lang")
```

::: {.en}
Integers and floats.
:::

::: {.zh}

整数和浮点数。

:::

```go
	fmt.Println("1+1 =", 1+1)
	fmt.Println("7.0/3.0 =", 7.0/3.0)
```

::: {.en}
Booleans, with boolean operators as you'd expect.
:::

::: {.zh}

布尔值，使用布尔运算符。

:::

```go
	fmt.Println(true && false)
	fmt.Println(true || false)
	fmt.Println(!true)
}
```

```bash
$ go run values.go
golang
1+1 = 2
7.0/3.0 = 2.3333333333333335
false
true
false
```
