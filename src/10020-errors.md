
# Errors {.en}


# 错误 {.zh}


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

在Go中，通过一个明确的，单独的返回值来传达错误是惯用的。这与Java和Ruby等语言中使用的异常以及有时在C中使用的重载单个结果/错误值形成对比.Go的方法使得很容易看到哪些函数返回错误并使用用于任何其他非错误任务的相同语言结构来处理它们。

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

按照惯例，错误是最后一个返回值，并且类型为`error`，一个内置接口。

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

`errors.New`用给定的错误消息构造一个基本的`error`值。

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

错误位置中的“nil”值表示没有错误。

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

通过对它们实现`Error（）`方法，可以使用自定义类型作为“错误”。以下是使用自定义类型显式表示参数错误的上述示例的变量。

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

在这种情况下，我们使用`＆argError`语法来构建一个新结构，为twofields`arg`和`prob`提供值。

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

下面的两个循环测试每个返回错误的函数。请注意，在`if`行上使用aninline错误检查是Go代码中的一个常见问题。

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

如果要以编程方式在自定义错误中使用数据，则需要通过typeassertion将错误作为自定义错误类型的实例。

:::


```go
	_, e := f2(42)
	if ae, ok := e.(*argError); ok {
		fmt.Println(ae.arg)
		fmt.Println(ae.prob)
	}
}
```


```sh
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

有关错误处理的更多信息，请参阅Go博客上的[great post]（http://blog.golang.org/2011/07/error-handling-and-go.html）。

:::


