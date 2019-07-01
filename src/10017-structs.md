
# Structs {.en}

# 结构体 {.zh}

::: {.en}
Go's _structs_ are typed collections of fields.
They're useful for grouping data together to form
records.
:::

::: {.zh}

Go 的*结构体*是带类型的字段集合。这在组织数据时非常有用。

:::

```go
package main
import "fmt"
```

::: {.en}
This `person` struct type has `name` and `age` fields.
:::

::: {.zh}

这个 `person` 结构体有`name`和`age`字段。

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

此语法创建一个新结构体元素。

:::

```go
	fmt.Println(person{"Bob", 20})
```

::: {.en}
You can name the fields when initializing a struct.
:::

::: {.zh}

您可以在初始化结构体元素时指定字段名字。

:::

```go
	fmt.Println(person{name: "Alice", age: 30})
```

::: {.en}
Omitted fields will be zero-valued.
:::

::: {.zh}

省略的字段将被初始化为零值。

:::

```go
	fmt.Println(person{name: "Fred"})
```

::: {.en}
An `&` prefix yields a pointer to the struct.
:::

::: {.zh}

`&` 前缀生成指向结构体的指针。

:::

```go
	fmt.Println(&person{name: "Ann", age: 40})
```

::: {.en}
Access struct fields with a dot.
:::

::: {.zh}

使用点（`.`）访问结构体字段。

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

也可以对结构体指针使用 `.` - 指针会被自动解引用。

:::

```go
	sp := &s
	fmt.Println(sp.age)
```

::: {.en}
Structs are mutable.
:::

::: {.zh}

结构体是可变（mutable）的。

:::

```go
	sp.age = 51
	fmt.Println(sp.age)
}
```

```bash
$ go run structs.go
{Bob 20}
{Alice 30}
{Fred 0}
&{Ann 40}
Sean
50
51
```
