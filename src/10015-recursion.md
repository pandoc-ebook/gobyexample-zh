
# Recursion {.en}

# 递归 {.zh}

::: {.en}
Go supports
<a href="http://en.wikipedia.org/wiki/Recursion_(computer_science)"><em>recursive functions</em></a>.
Here's a classic factorial example.
:::

::: {.zh}

Go 支持 [*递归*](http://en.wikipedia.org/wiki/Recursion_%28computer_science%29)。这是一个经典的阶乘示例。

:::

```go
package main
import "fmt"
```

::: {.en}
This `fact` function calls itself until it reaches the
base case of `fact(0)`.
:::

::: {.zh}

`fact` 函数在达到 `fact(0)` 之前一致调用自身。

:::

```go
func fact(n int) int {
	if n == 0 {
		return 1
	}
	return n * fact(n-1)
}
func main() {
	fmt.Println(fact(7))
}
```

```bash
$ go run recursion.go 
5040
```
