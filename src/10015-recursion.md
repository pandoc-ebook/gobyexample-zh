
# Recursion {.en}


# 递归 {.zh}


::: {.en}
Go supports
<a href="http://en.wikipedia.org/wiki/Recursion_(computer_science)"><em>recursive functions</em></a>.
Here's a classic factorial example.
:::

::: {.zh}

Go支持<a href="http://en.wikipedia.org/wiki/Recursion_(computer_science)"> <em>递归函数</ em> </a>。这是一个经典的因子示例。

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

这个`fact`函数调用自身，直到它达到`fact（0）`的基本情况。

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


