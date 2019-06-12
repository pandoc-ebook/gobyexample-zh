
# Switch {.en}


# 开关 {.zh}


::: {.en}
_Switch statements_ express conditionals across many
branches.
:::

::: {.zh}

_切换语句_表达多个分支的条件。

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

这是一个基本的`switch`。

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

您可以使用逗号分隔同一`case`语句中的多个表达式。我们在这个例子中也使用了可选的`default`案例。

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

没有表达式的`switch`是表达if / else逻辑的另一种方式。这里我们还展示了`case`表达式如何可以是非常量。

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

类型`switch`比较类型而不是值。您可以使用它来发现interfacevalue的类型。在这个例子中，变量`t`将具有与其子句对应的类型。

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


```sh
$ go run switch.go 
Write 2 as two
It's a weekday
It's after noon
I'm a bool
I'm an int
Don't know type string
```


