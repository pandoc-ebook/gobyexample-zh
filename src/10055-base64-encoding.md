
# Base64 Encoding {.en}


# Base64编码 {.zh}


::: {.en}
Go provides built-in support for [base64
encoding/decoding](http://en.wikipedia.org/wiki/Base64).
:::

::: {.zh}

Go为[base64encoding / decoding]（http://en.wikipedia.org/wiki/Base64）提供内置支持。

:::


```go
package main
```


::: {.en}
This syntax imports the `encoding/base64` package with
the `b64` name instead of the default `base64`. It'll
save us some space below.
:::

::: {.zh}

此语法使用`b64`名称而不是默认的`base64`导入`encoding / base64`包。它会给我们留下一些空间。

:::


```go
import b64 "encoding/base64"
import "fmt"
func main() {
```


::: {.en}
Here's the `string` we'll encode/decode.
:::

::: {.zh}

这是我们将编码/解码的`字符串'。

:::


```go
	data := "abc123!?$*&()'-=@~"
```


::: {.en}
Go supports both standard and URL-compatible
base64. Here's how to encode using the standard
encoder. The encoder requires a `[]byte` so we
convert our `string` to that type.
:::

::: {.zh}

Go支持标准和URL兼容的base64。以下是使用standardencoder进行编码的方法。编码器需要一个`[] byte`，所以我们将`string`转换为该类型。

:::


```go
	sEnc := b64.StdEncoding.EncodeToString([]byte(data))
	fmt.Println(sEnc)
```


::: {.en}
Decoding may return an error, which you can check
if you don't already know the input to be
well-formed.
:::

::: {.zh}

解码可能会返回错误，您可以检查是否您还不知道输入是否格式正确。

:::


```go
	sDec, _ := b64.StdEncoding.DecodeString(sEnc)
	fmt.Println(string(sDec))
	fmt.Println()
```


::: {.en}
This encodes/decodes using a URL-compatible base64
format.
:::

::: {.zh}

这使用与URL兼容的base64format进行编码/解码。

:::


```go
	uEnc := b64.URLEncoding.EncodeToString([]byte(data))
	fmt.Println(uEnc)
	uDec, _ := b64.URLEncoding.DecodeString(uEnc)
	fmt.Println(string(uDec))
}
```


::: {.en}
The string encodes to slightly different values with the
standard and URL base64 encoders (trailing `+` vs `-`)
but they both decode to the original string as desired.
:::

::: {.zh}

该字符串使用标准和URL base64编码器（尾随`+`vs` -`）编码略有不同的值，但它们都根据需要解码为原始字符串。

:::


```bash
$ go run base64-encoding.go
YWJjMTIzIT8kKiYoKSctPUB+
abc123!?$*&()'-=@~
YWJjMTIzIT8kKiYoKSctPUB-
abc123!?$*&()'-=@~
```


