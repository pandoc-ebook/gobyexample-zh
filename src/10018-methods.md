
# Methods {.en}


# 方法 {.zh}


::: {.en}
Go supports _methods_ defined on struct types.
:::

::: {.zh}

Go支持在struct类型上定义的_methods_。

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

这个`area`方法的_receiver type_为`* rect`。

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

可以为指针或值接收器类型定义方法。这是一个值接收器的例子。

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

这里我们调用为结构定义的2个方法。

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

Go会自动处理方法调用的值和指针之间的转换。您可能希望使用指针接收器类型以避免复制方法调用或允许该方法改变接收结构。

:::


```go
	rp := &r
	fmt.Println("area: ", rp.area())
	fmt.Println("perim:", rp.perim())
}
```


```sh
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

接下来我们将看看Go的机制，用于分组和理解相关的方法集：接口。

:::


