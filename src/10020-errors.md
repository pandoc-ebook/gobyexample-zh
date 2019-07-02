
# Errors {.en}

# 错误处理 {.zh}

::: {.en}
In Go it's idiomatic to communicate errors via an
explicit, separate return value. This contrasts with
the exceptions used in languages like Java and Ruby and
the overloaded single result / error value sometimes
used in C. Go's approach makes it easy to see which
functions return errors and to handle them using the
same language constructs employed for any other,
non-error tasks.
:::

::: {.zh}

在 Go 中，通常用一个明确的，单独的返回值来传递错误信息。这与 Java 和 Ruby 等语言中使用的异常（exception）以及有时在 C 中使用的重载（overloaded）单返回/错误值有着明显不同。Go 的方法使得很容易看到哪些函数返回错误，并能像调用那些没有出错的函数一样调用。

:::

```go
package main
import "errors"
import "fmt"
```

::: {.en}
By convention, errors are the last return value and
have type `error`, a built-in interface.
:::

::: {.zh}

按照惯例，错误是最后一个返回值，并且类型为 `error`，一个内建的接口。

:::

```go
func f1(arg int) (int, error) {
	if arg == 42 {
```

::: {.en}
`errors.New` constructs a basic `error` value
with the given error message.
:::

::: {.zh}

`errors.New` 用给定的错误消息构造一个基本的 `error` 值。

:::

```go
		return -1, errors.New("can't work with 42")
	}
```

::: {.en}
A `nil` value in the error position indicates that
there was no error.
:::

::: {.zh}

返回错误值为 `nil` 表示没有错误。

:::

```go
	return arg + 3, nil
}
```

::: {.en}
It's possible to use custom types as `error`s by
implementing the `Error()` method on them. Here's a
variant on the example above that uses a custom type
to explicitly represent an argument error.
:::

::: {.zh}

可以通过实现 `Error()` 方法来自定义 `error` 类型。以下是使用自定义错误类型显式表示上面示例中的参数错误。

:::

```go
type argError struct {
	arg  int
	prob string
}
func (e *argError) Error() string {
	return fmt.Sprintf("%d - %s", e.arg, e.prob)
}
func f2(arg int) (int, error) {
	if arg == 42 {
```

::: {.en}
In this case we use `&argError` syntax to build
a new struct, supplying values for the two
fields `arg` and `prob`.
:::

::: {.zh}

在这个例子中，我们使用 `&argError` 语法来构建一个新结构体，为两个字段 `arg` 和 `prob` 提供值。

:::

```go
		return -1, &argError{arg, "can't work with it"}
	}
	return arg + 3, nil
}
func main() {
```

::: {.en}
The two loops below test out each of our
error-returning functions. Note that the use of an
inline error check on the `if` line is a common
idiom in Go code.
:::

::: {.zh}

下面的两个循环测试每个返回错误的函数。请注意，在 `if` 行内的错误检查是 Go 中的普遍用法。

:::

```go
	for _, i := range []int{7, 42} {
		if r, e := f1(i); e != nil {
			fmt.Println("f1 failed:", e)
		} else {
			fmt.Println("f1 worked:", r)
		}
	}
	for _, i := range []int{7, 42} {
		if r, e := f2(i); e != nil {
			fmt.Println("f2 failed:", e)
		} else {
			fmt.Println("f2 worked:", r)
		}
	}
```

::: {.en}
If you want to programmatically use the data in
a custom error, you'll need to get the error as an
instance of the custom error type via type
assertion.
:::

::: {.zh}

你如果想在程序中使用一个自定义错误类型中的数据，你 需要通过类型断言来得到这个错误类型的实例。

:::

```go
	_, e := f2(42)
	if ae, ok := e.(*argError); ok {
		fmt.Println(ae.arg)
		fmt.Println(ae.prob)
	}
}
```

```bash
$ go run errors.go
f1 worked: 10
f1 failed: can't work with 42
f2 worked: 10
f2 failed: 42 - can't work with it
42
can't work with it
```

::: {.en}
See this [great post](http://blog.golang.org/2011/07/error-handling-and-go.html)
on the Go blog for more on error handling.
:::

::: {.zh}

有关错误处理的更多信息，请参阅 Go 博客上的这篇 [很棒的文章](http://blog.golang.org/2011/07/error-handling-and-go.html)。

:::
