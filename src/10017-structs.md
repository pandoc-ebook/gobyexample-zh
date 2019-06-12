
# Structs {.en}


# 结构 {.zh}


::: {.en}
Go's _structs_ are typed collections of fields.
They're useful for grouping data together to form
records.
:::

::: {.zh}

Go的_structs_是字段的类型集合。它们可用于将数据分组到formrecords。

:::


```go
package main
import "fmt"
```


::: {.en}
This `person` struct type has `name` and `age` fields.
:::

::: {.zh}

这个`person`结构类型有`name`和`age`字段。

:::


```go
type person struct {
	name string
	age  int
}
func main() {
```


::: {.en}
This syntax creates a new struct.
:::

::: {.zh}

此语法创建一个新结构。

:::


```go
	fmt.Println(person{"Bob", 20})
```


::: {.en}
You can name the fields when initializing a struct.
:::

::: {.zh}

您可以在初始化结构时命名字段。

:::


```go
	fmt.Println(person{name: "Alice", age: 30})
```


::: {.en}
Omitted fields will be zero-valued.
:::

::: {.zh}

省略的字段将为零值。

:::


```go
	fmt.Println(person{name: "Fred"})
```


::: {.en}
An `&` prefix yields a pointer to the struct.
:::

::: {.zh}

`＆`前缀产生指向结构的指针。

:::


```go
	fmt.Println(&person{name: "Ann", age: 40})
```


::: {.en}
Access struct fields with a dot.
:::

::: {.zh}

使用点访问struct字段。

:::


```go
	s := person{name: "Sean", age: 50}
	fmt.Println(s.name)
```


::: {.en}
You can also use dots with struct pointers - the
pointers are automatically dereferenced.
:::

::: {.zh}

您还可以使用带有结构指针的点 - 指针会自动解除引用。

:::


```go
	sp := &s
	fmt.Println(sp.age)
```


::: {.en}
Structs are mutable.
:::

::: {.zh}

结构是可变的。

:::


```go
	sp.age = 51
	fmt.Println(sp.age)
}
```


```sh
$ go run structs.go
{Bob 20}
{Alice 30}
{Fred 0}
&{Ann 40}
Sean
50
51
```


