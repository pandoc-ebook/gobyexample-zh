
# Sorting by Functions {.en}


# 按功能排序 {.zh}


::: {.en}
Sometimes we'll want to sort a collection by something
other than its natural order. For example, suppose we
wanted to sort strings by their length instead of
alphabetically. Here's an example of custom sorts
in Go.
:::

::: {.zh}

有时我们会想要通过除自然顺序以外的其他东西对集合进行排序。例如，假设我们希望按字母长度而不是按字母顺序对字符串进行排序。以下是自定义排序Go的示例。

:::


```go
package main
import "sort"
import "fmt"
```


::: {.en}
In order to sort by a custom function in Go, we need a
corresponding type. Here we've created a `byLength`
type that is just an alias for the builtin `[]string`
type.
:::

::: {.zh}

为了按Go中的自定义函数排序，我们需要相应的类型。这里我们创建了一个`byLength`type，它只是内置`[] string`type的别名。

:::


```go
type byLength []string
```


::: {.en}
We implement `sort.Interface` - `Len`, `Less`, and
`Swap` - on our type so we can use the `sort` package's
generic `Sort` function. `Len` and `Swap`
will usually be similar across types and `Less` will
hold the actual custom sorting logic. In our case we
want to sort in order of increasing string length, so
we use `len(s[i])` and `len(s[j])` here.
:::

::: {.zh}

我们在类型上实现`sort.Interface`  - `Len`，`Less`和`Swap`  - 所以我们可以使用`sort` package'sgeneric`Sorting`函数。 `Len`和`Swap`通常在类型之间是相似的，而'Less`将保留实际的自定义排序逻辑。在我们的例子中，我们想按照增加字符串长度的顺序排序，sowe在这里使用`len（s [i]）`和`len（s [j]）`。

:::


```go
func (s byLength) Len() int {
	return len(s)
}
func (s byLength) Swap(i, j int) {
	s[i], s[j] = s[j], s[i]
}
func (s byLength) Less(i, j int) bool {
	return len(s[i]) < len(s[j])
}
```


::: {.en}
With all of this in place, we can now implement our
custom sort by converting the original `fruits` slice
to `byLength`, and then use `sort.Sort` on that typed
slice.
:::

::: {.zh}

有了所有这些，我们现在可以通过转换原始的`fruits` sliceto`byLength`来实现我们的自定义排序，然后在该typedlice上使用`sort.Sort`。

:::


```go
func main() {
	fruits := []string{"peach", "banana", "kiwi"}
	sort.Sort(byLength(fruits))
	fmt.Println(fruits)
}
```


::: {.en}
Running our program shows a list sorted by string
length, as desired.
:::

::: {.zh}

运行我们的程序会根据需要显示按stringlength排序的列表。

:::


```bash
$ go run sorting-by-functions.go 
[kiwi peach banana]
```


::: {.en}
By following this same pattern of creating a custom
type, implementing the three `Interface` methods on that
type, and then calling sort.Sort on a collection of that
custom type, we can sort Go slices by arbitrary
functions.
:::

::: {.zh}

通过遵循创建自定义类型的相同模式，在该类型上实现三个`Interface`方法，然后在该自定义类型的集合上调用sort.Sort，我们可以通过任意函数对Go切片进行排序。

:::


