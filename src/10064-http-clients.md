
# HTTP Clients {.en}


# HTTP客户端 {.zh}


::: {.en}
The Go standard library comes with excellent support
for HTTP clients and servers in the `net/http`
package. In this example we'll use it to issue simple
HTTP requests.
:::

::: {.zh}

Go标准库为`net / http`package中的HTTP客户端和服务器提供了出色的支持。在这个例子中，我们将使用它来发出简单的HTTP请求。

:::


```go
package main
import (
	"bufio"
	"fmt"
	"net/http"
)
func main() {
```


::: {.en}
Issue an HTTP GET request to a server. `http.Get` is a
convenient shortcut around creating an `http.Client`
object and calling its `Get` method; it uses the
`http.DefaultClient` object which has useful default
settings.
:::

::: {.zh}

向服务器发出HTTP GET请求。 `http.Get`是创建`http.Client`object并调用其`Get`方法的简便快捷方式;它使用`http.DefaultClient`对象，该对象具有有用的默认设置。

:::


```go
	resp, err := http.Get("http://gobyexample.com")
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()
```


::: {.en}
Print the HTTP response status.
:::

::: {.zh}

打印HTTP响应状态。

:::


```go
	fmt.Println("Response status:", resp.Status)
```


::: {.en}
Print the first 5 lines of the response body.
:::

::: {.zh}

打印响应正文的前5行。

:::


```go
	scanner := bufio.NewScanner(resp.Body)
	for i := 0; scanner.Scan() && i < 5; i++ {
		fmt.Println(scanner.Text())
	}
	if err := scanner.Err(); err != nil {
		panic(err)
	}
}
```


```bash
$ go run http-clients.go
Response status: 200 OK
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Go by Example</title>
```


