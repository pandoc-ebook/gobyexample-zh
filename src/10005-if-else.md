
# If/Else {.en}

# If/Else 分支 {.zh}

::: {.en}
Branching with `if` and `else` in Go is
straight-forward.
:::

::: {.zh}

if/else 分支结构在 Go 语言中非常直接。
:::

```go
package main
import "fmt"
func main() {
```

::: {.en}
Here's a basic example.
:::

::: {.zh}

这是一个基本的例子。

:::

```go
	if 7%2 == 0 {
		fmt.Println("7 is even")
	} else {
		fmt.Println("7 is odd")
	}
```

::: {.en}
You can have an `if` statement without an else.
:::

::: {.zh}

`if` 语句可以不包含 `else`。

:::

```go
	if 8%4 == 0 {
		fmt.Println("8 is divisible by 4")
	}
```

::: {.en}
A statement can precede conditionals; any variables
declared in this statement are available in all
branches.
:::

::: {.zh}

条件语句前可以有一个声明语句；声明的任何变量都可以用于所有分支。

:::

```go
	if num := 9; num < 0 {
		fmt.Println(num, "is negative")
	} else if num < 10 {
		fmt.Println(num, "has 1 digit")
	} else {
		fmt.Println(num, "has multiple digits")
	}
}
```

::: {.en}
Note that you don't need parentheses around conditions
in Go, but that the braces are required.
:::

::: {.zh}

请注意，Go 中的条件语句不需要括号，但需要大括号。

:::

```bash
$ go run if-else.go 
7 is odd
8 is divisible by 4
9 has 1 digit
```

::: {.en}
There is no [ternary if](http://en.wikipedia.org/wiki/%3F:)
in Go, so you'll need to use a full `if` statement even
for basic conditions.
:::

::: {.zh}

Go 中没有 [三目运算符](http://en.wikipedia.org/wiki/%3F:)，因此即使基本条件也需要使用完整的 `if` 语句。

:::
