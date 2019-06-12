
# HTTP Servers {.en}


# HTTP服务器 {.zh}


::: {.en}
Writing a basic HTTP server is easy using the
`net/http` package.
:::

::: {.zh}

使用`net / http`包可以轻松编写基本的HTTP服务器。

:::


```go
package main
import (
	"fmt"
	"net/http"
)
```


::: {.en}
A fundamental concept in `net/http` servers is
*handlers*. A handler is an object implementing the
`http.Handler` interface. A common way to write
a handler is by using the `http.HandlerFunc` adapter
on functions with the appropriate signature.
:::

::: {.zh}

`net / http`服务器中的一个基本概念是*处理程序*。处理程序是实现`http.Handler`接口的对象。写入处理程序的常用方法是使用带有适当签名的`http.HandlerFunc` adapteron函数。

:::


```go
func hello(w http.ResponseWriter, req *http.Request) {
```


::: {.en}
Functions serving as handlers take a
`http.ResponseWriter` and a `http.Request` as
arguments. The response writer is used to fill in the
HTTP response. Here out simple response is just
"hellon".
:::

::: {.zh}

作为处理程序的函数采用`http：ResponseWriter`和`http.Request` asarguments。响应编写器用于填写HTTP响应。这里简单的回应就是“hellon”。

:::


```go
	fmt.Fprintf(w, "hellon")
}
func headers(w http.ResponseWriter, req *http.Request) {
```


::: {.en}
This handler does something a little more
sophisticated by reading all the HTTP request
headers and echoing them into the response body.
:::

::: {.zh}

这个处理程序通过读取所有HTTP请求标头并将它们回显到响应主体来做一些更复杂的事情。

:::


```go
	for name, headers := range req.Header {
		for _, h := range headers {
			fmt.Fprintf(w, "%v: %vn", name, h)
		}
	}
}
func main() {
```


::: {.en}
We register our handlers on server routes using the
`http.HandleFunc` convenience function. It sets up
the *default router* in the `net/http` package and
takes a function as an argument.
:::

::: {.zh}

我们使用`http.HandleFunc`便捷函数在服务器路由上注册我们的处理程序。它在`net / http`包中设置*默认路由器*并将一个函数作为参数。

:::


```go
	http.HandleFunc("/hello", hello)
	http.HandleFunc("/headers", headers)
```


::: {.en}
Finally, we call the `ListenAndServe` with the port
and a handler. `nil` tells it to use the default
router we've just set up.
:::

::: {.zh}

最后，我们将“ListenAndServe”称为portland处理程序。 `nil`告诉它使用我们刚设置的默认路由器。

:::


```go
	http.ListenAndServe(":8090", nil)
}
```


::: {.en}
Run the server in the background.
:::

::: {.zh}

在后台运行服务器。

:::


```sh
$ go run http-servers.go &
```


::: {.en}
Access the `/hello` route.
:::

::: {.zh}

访问`/ hello`路由。

:::


```sh
$ curl localhost:8090/hello
hello
```


