
# Methods {.en}

# 方法 {.zh}

::: {.en}
Go supports _methods_ defined on struct types.
:::

::: {.zh}

Go 支持在结构体类型中定义方法（methods）。

:::

```go
package main
import "fmt"
type rect struct {
	width, height int
}
```

::: {.en}
This `area` method has a _receiver type_ of `*rect`.
:::

::: {.zh}

这个 `area` 方法有一个*接收器*（receiver）类型 `*rect`。

:::

```go
func (r *rect) area() int {
	return r.width * r.height
}
```

::: {.en}
Methods can be defined for either pointer or value
receiver types. Here's an example of a value receiver.
:::

::: {.zh}

可以为指针或值类型的接收器定义方法。这是一个值类型接收器的例子。

:::

```go
func (r rect) perim() int {
	return 2*r.width + 2*r.height
}
func main() {
	r := rect{width: 10, height: 5}
```

::: {.en}
Here we call the 2 methods defined for our struct.
:::

::: {.zh}

这里我们调用为结构体定义的 2 个方法。

:::

```go
	fmt.Println("area: ", r.area())
	fmt.Println("perim:", r.perim())
```

::: {.en}
Go automatically handles conversion between values
and pointers for method calls. You may want to use
a pointer receiver type to avoid copying on method
calls or to allow the method to mutate the
receiving struct.
:::

::: {.zh}

Go 自动处理方法调用时的值和指针之间的转化。你可以使 用指针来调用方法来避免在方法调用时产生一个拷贝，或者 让方法能够改变接受的结构体。

:::

```go
	rp := &r
	fmt.Println("area: ", rp.area())
	fmt.Println("perim:", rp.perim())
}
```

```bash
$ go run methods.go 
area:  50
perim: 30
area:  50
perim: 30
```

::: {.en}
Next we'll look at Go's mechanism for grouping and
naming related sets of methods: interfaces.
:::

::: {.zh}

接下来我们将介绍 Go 用于分组和命名相关 方法集合的机制：接口。

:::
