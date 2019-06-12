
# Pointers {.en}


# 指针 {.zh}


::: {.en}
Go supports <em><a href="http://en.wikipedia.org/wiki/Pointer_(computer_programming)">pointers</a></em>,
allowing you to pass references to values and records
within your program.
:::

::: {.zh}

Go支持<em> <a href="http://en.wikipedia.org/wiki/Pointer_(computer_programming)">指针</a> </ em>，允许您在程序中传递对值和记录的引用。

:::


```go
package main
import "fmt"
```


::: {.en}
We'll show how pointers work in contrast to values with
2 functions: `zeroval` and `zeroptr`. `zeroval` has an
`int` parameter, so arguments will be passed to it by
value. `zeroval` will get a copy of `ival` distinct
from the one in the calling function.
:::

::: {.zh}

我们将展示指针如何与具有2个函数的值形成对比：`zeroval`和`zeroptr`。 `zeroval`有一个`int`参数，所以参数将通过值传递给它。 `zeroval`将获得与调用函数中的`ival'不同的副本。

:::


```go
func zeroval(ival int) {
	ival = 0
}
```


::: {.en}
`zeroptr` in contrast has an `*int` parameter, meaning
that it takes an `int` pointer. The `*iptr` code in the
function body then _dereferences_ the pointer from its
memory address to the current value at that address.
Assigning a value to a dereferenced pointer changes the
value at the referenced address.
:::

::: {.zh}

相比之下，`zeroptr`有一个`* int`参数，这意味着它需要一个`int`指针。函数体中的`* iptr`代码然后_dereferences_指针从其存储地址到该地址的当前值。将值赋给解除引用的指针会改变引用地址的值。

:::


```go
func zeroptr(iptr *int) {
	*iptr = 0
}
func main() {
	i := 1
	fmt.Println("initial:", i)
	zeroval(i)
	fmt.Println("zeroval:", i)
```


::: {.en}
The `&i` syntax gives the memory address of `i`,
i.e. a pointer to `i`.
:::

::: {.zh}

`＆i`语法给出了'i`的内存地址，即。指向`i`的指针。

:::


```go
	zeroptr(&i)
	fmt.Println("zeroptr:", i)
```


::: {.en}
Pointers can be printed too.
:::

::: {.zh}

指针也可以打印。

:::


```go
	fmt.Println("pointer:", &i)
}
```


::: {.en}
`zeroval` doesn't change the `i` in `main`, but
`zeroptr` does because it has a reference to
the memory address for that variable.
:::

::: {.zh}

`zeroval`不会改变`main`中的`i`，但是`ofzerop`会改变，因为它有一个对该变量的内存地址的引用。

:::


```bash
$ go run pointers.go
initial: 1
zeroval: 1
zeroptr: 0
pointer: 0x42131100
```


