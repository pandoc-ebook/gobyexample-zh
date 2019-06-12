
# URL Parsing {.en}


# URL解析 {.zh}


::: {.en}
URLs provide a [uniform way to locate resources](https://adam.herokuapp.com/past/2010/3/30/urls_are_the_uniform_way_to_locate_resources/).
Here's how to parse URLs in Go.
:::

::: {.zh}

URL提供[查找资源的统一方式]（https://adam.herokuapp.com/past/2010/3/30/urls_are_the_uniform_way_to_locate_resources/）。这是如何解析Go中的URL。

:::


```go
package main
import "fmt"
import "net"
import "net/url"
func main() {
```


::: {.en}
We'll parse this example URL, which includes a
scheme, authentication info, host, port, path,
query params, and query fragment.
:::

::: {.zh}

我们将解析此示例URL，其中包括ascheme，身份验证信息，主机，端口，路径，查询参数和查询片段。

:::


```go
	s := "postgres://user:pass@host.com:5432/path?k=v#f"
```


::: {.en}
Parse the URL and ensure there are no errors.
:::

::: {.zh}

解析URL并确保没有错误。

:::


```go
	u, err := url.Parse(s)
	if err != nil {
		panic(err)
	}
```


::: {.en}
Accessing the scheme is straightforward.
:::

::: {.zh}

访问该方案很简单。

:::


```go
	fmt.Println(u.Scheme)
```


::: {.en}
`User` contains all authentication info; call
`Username` and `Password` on this for individual
values.
:::

::: {.zh}

`User`包含所有身份验证信息;为个别值调用`username`和`Password`。

:::


```go
	fmt.Println(u.User)
	fmt.Println(u.User.Username())
	p, _ := u.User.Password()
	fmt.Println(p)
```


::: {.en}
The `Host` contains both the hostname and the port,
if present. Use `SplitHostPort` to extract them.
:::

::: {.zh}

`Host`包含主机名和端口（如果存在）。使用`SplitHostPort`来提取它们。

:::


```go
	fmt.Println(u.Host)
	host, port, _ := net.SplitHostPort(u.Host)
	fmt.Println(host)
	fmt.Println(port)
```


::: {.en}
Here we extract the `path` and the fragment after
the `#`.
:::

::: {.zh}

在这里，我们在`＃`后面提取`path`和片段。

:::


```go
	fmt.Println(u.Path)
	fmt.Println(u.Fragment)
```


::: {.en}
To get query params in a string of `k=v` format,
use `RawQuery`. You can also parse query params
into a map. The parsed query param maps are from
strings to slices of strings, so index into `[0]`
if you only want the first value.
:::

::: {.zh}

要以`k = v`格式的字符串获取查询参数，请使用`RawQuery`。您还可以将查询paramsin解析为地图。解析后的查询参数映射是从字符串到字符串切片，因此如果只需要第一个值，则索引到“[0]`。

:::


```go
	fmt.Println(u.RawQuery)
	m, _ := url.ParseQuery(u.RawQuery)
	fmt.Println(m)
	fmt.Println(m["k"][0])
}
```


::: {.en}
Running our URL parsing program shows all the different
pieces that we extracted.
:::

::: {.zh}

运行我们的URL解析程序会显示我们提取的所有不同的部分。

:::


```sh
$ go run url-parsing.go 
postgres
user:pass
user
pass
host.com:5432
host.com
5432
/path
f
k=v
map[k:[v]]
v
```


