
# Switch {.en}

# Switch 语句 {.zh}

::: {.en}
_Switch statements_ express conditionals across many
branches.
:::

::: {.zh}

_Switch_ 语句用于多个分支的条件。

:::

```go
package main
import "fmt"
import "time"
func main() {
```

::: {.en}
Here's a basic `switch`.
:::

::: {.zh}

一个基本的 `switch`。

:::

```go
	i := 2
	fmt.Print("Write ", i, " as ")
	switch i {
	case 1:
		fmt.Println("one")
	case 2:
		fmt.Println("two")
	case 3:
		fmt.Println("three")
	}
```

::: {.en}
You can use commas to separate multiple expressions
in the same `case` statement. We use the optional
`default` case in this example as well.
:::

::: {.zh}

您可以使用逗号分隔同一 `case` 语句中的多个表达式。我们在这个例子中也使用了可选的 `default` 分支。

:::

```go
	switch time.Now().Weekday() {
	case time.Saturday, time.Sunday:
		fmt.Println("It's the weekend")
	default:
		fmt.Println("It's a weekday")
	}
```

::: {.en}
`switch` without an expression is an alternate way
to express if/else logic. Here we also show how the
`case` expressions can be non-constants.
:::

::: {.zh}

没有表达式的 `switch` 是表达 if / else 逻辑的另一种方式。这里我们还展示了 `case` 表达式也可以不使用常量。

:::

```go
	t := time.Now()
	switch {
	case t.Hour() < 12:
		fmt.Println("It's before noon")
	default:
		fmt.Println("It's after noon")
	}
```

::: {.en}
A type `switch` compares types instead of values.  You
can use this to discover the type of an interface
value.  In this example, the variable `t` will have the
type corresponding to its clause.
:::

::: {.zh}

类型开关（`type switch`） 比较类型而非值。可以使用它来发现接口值的类型。在这个例子中，变量 `t` 在每个分支中会有相应的类型。

:::

```go
	whatAmI := func(i interface{}) {
		switch t := i.(type) {
		case bool:
			fmt.Println("I'm a bool")
		case int:
			fmt.Println("I'm an int")
		default:
			fmt.Printf("Don't know type %Tn", t)
		}
	}
	whatAmI(true)
	whatAmI(1)
	whatAmI("hey")
}
```

```bash
$ go run switch.go 
Write 2 as two
It's a weekday
It's after noon
I'm a bool
I'm an int
Don't know type string
```
