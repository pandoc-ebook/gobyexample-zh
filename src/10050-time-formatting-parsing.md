
# Time Formatting / Parsing {.en}


# 时间格式/解析 {.zh}


::: {.en}
Go supports time formatting and parsing via
pattern-based layouts.
:::

::: {.zh}

Go支持时间格式化和解析基于模式的布局。

:::


```go
package main
import "fmt"
import "time"
func main() {
	p := fmt.Println
```


::: {.en}
Here's a basic example of formatting a time
according to RFC3339, using the corresponding layout
constant.
:::

::: {.zh}

这是使用相应的layoutconstant根据RFC3339格式化时间的基本示例。

:::


```go
	t := time.Now()
	p(t.Format(time.RFC3339))
```


::: {.en}
Time parsing uses the same layout values as `Format`.
:::

::: {.zh}

时间解析使用与“格式”相同的布局值。

:::


```go
	t1, e := time.Parse(
		time.RFC3339,
		"2012-11-01T22:08:41+00:00")
	p(t1)
```


::: {.en}
`Format` and `Parse` use example-based layouts. Usually
you'll use a constant from `time` for these layouts, but
you can also supply custom layouts. Layouts must use the
reference time `Mon Jan 2 15:04:05 MST 2006` to show the
pattern with which to format/parse a given time/string.
The example time must be exactly as shown: the year 2006,
15 for the hour, Monday for the day of the week, etc.
:::

::: {.zh}

`Format`和`Parse`使用基于示例的布局。通常你会对这些布局使用“时间”的常量，但你也可以提供自定义布局。布局必须使用参考时间`Mon Jan 2 15:04:05 MST 2006`来显示用于格式化/解析给定时间/字符串的模式。示例时间必须完全如图所示：2006,15小时，星期一，星期几等

:::


```go
	p(t.Format("3:04PM"))
	p(t.Format("Mon Jan _2 15:04:05 2006"))
	p(t.Format("2006-01-02T15:04:05.999999-07:00"))
	form := "3 04 PM"
	t2, e := time.Parse(form, "8 41 PM")
	p(t2)
```


::: {.en}
For purely numeric representations you can also
use standard string formatting with the extracted
components of the time value.
:::

::: {.zh}

对于纯数字表示，您可以使用提取的时间值组件来标准字符串格式。

:::


```go
	fmt.Printf("%d-%02d-%02dT%02d:%02d:%02d-00:00n",
		t.Year(), t.Month(), t.Day(),
		t.Hour(), t.Minute(), t.Second())
```


::: {.en}
`Parse` will return an error on malformed input
explaining the parsing problem.
:::

::: {.zh}

`Parse`将在错误的inputexplaining解析问题上返回错误。

:::


```go
	ansic := "Mon Jan _2 15:04:05 2006"
	_, e = time.Parse(ansic, "8:41PM")
	p(e)
}
```


```sh
$ go run time-formatting-parsing.go 
2014-04-15T18:00:15-07:00
2012-11-01 22:08:41 +0000 +0000
6:00PM
Tue Apr 15 18:00:15 2014
2014-04-15T18:00:15.161182-07:00
0000-01-01 20:41:00 +0000 UTC
2014-04-15T18:00:15-00:00
parsing time "8:41PM" as "Mon Jan _2 15:04:05 2006": ...
```


