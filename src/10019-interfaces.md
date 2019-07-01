
# Interfaces {.en}

# 接口 {.zh}

::: {.en}
_Interfaces_ are named collections of method
signatures.
:::

::: {.zh}

*接口*（Interfaces）是命名了的方法签名（signatures） 的集合。

:::

```go
package main
import "fmt"
import "math"
```

::: {.en}
Here's a basic interface for geometric shapes.
:::

::: {.zh}

这是一个几何形状的基本接口。

:::

```go
type geometry interface {
	area() float64
	perim() float64
}
```

::: {.en}
For our example we'll implement this interface on
`rect` and `circle` types.
:::

::: {.zh}

对于我们的示例，我们将在类型 `rect` 和 `circle` 上实现此接口。

:::

```go
type rect struct {
	width, height float64
}
type circle struct {
	radius float64
}
```

::: {.en}
To implement an interface in Go, we just need to
implement all the methods in the interface. Here we
implement `geometry` on `rect`s.
:::

::: {.zh}

要在 Go 中实现接口，我们只需要实现接口中的所有方法。这里我们在 `rect` 上实现 `geometry` 接口。

:::

```go
func (r rect) area() float64 {
	return r.width * r.height
}
func (r rect) perim() float64 {
	return 2*r.width + 2*r.height
}
```

::: {.en}
The implementation for `circle`s.
:::

::: {.zh}

`circle` 的实现。

:::

```go
func (c circle) area() float64 {
	return math.Pi * c.radius * c.radius
}
func (c circle) perim() float64 {
	return 2 * math.Pi * c.radius
}
```

::: {.en}
If a variable has an interface type, then we can call
methods that are in the named interface. Here's a
generic `measure` function taking advantage of this
to work on any `geometry`.
:::

::: {.zh}

如果变量具有接口类型，那么我们可以调用指定接口中的方法。这里有一个通用 `measure` 函数，利用它来在任何 `geometry` 上工作。

:::

```go
func measure(g geometry) {
	fmt.Println(g)
	fmt.Println(g.area())
	fmt.Println(g.perim())
}
func main() {
	r := rect{width: 3, height: 4}
	c := circle{radius: 5}
```

::: {.en}
The `circle` and `rect` struct types both
implement the `geometry` interface so we can use
instances of
these structs as arguments to `measure`.
:::

::: {.zh}

结构体类型 `circle` 和 `rect` 都实现了 `geometry` 接口，所以我们可以使用这些结构体的实例作为 `measure` 的参数。

:::

```go
	measure(r)
	measure(c)
}
```

```bash
$ go run interfaces.go
{3 4}
12
14
{5}
78.53981633974483
31.41592653589793
```

::: {.en}
To learn more about Go's interfaces, check out this
[great blog post](http://jordanorelli.tumblr.com/post/32665860244/how-to-use-interfaces-in-go).
:::

::: {.zh}

要了解有关 Go 的接口的更多信息，请查看 [很棒的博客文章](http://jordanorelli.tumblr.com/post/32665860244/how-to-use-interfaces-in-go)。

:::
