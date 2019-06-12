
# SHA1 Hashes {.en}


# SHA1哈希 {.zh}


::: {.en}
[_SHA1 hashes_](http://en.wikipedia.org/wiki/SHA-1) are
frequently used to compute short identities for binary
or text blobs. For example, the [git revision control
system](http://git-scm.com/) uses SHA1s extensively to
identify versioned files and directories. Here's how to
compute SHA1 hashes in Go.
:::

::: {.zh}

[_SHA1 hashes_]（http://en.wikipedia.org/wiki/SHA-1）经常用于计算二进制文本blob的短标识。例如，[git revision controlsystem]（http://git-scm.com/）广泛使用SHA1来识别版本化文件和目录。以下是Go中如何计算SHA1哈希值。

:::


```go
package main
```


::: {.en}
Go implements several hash functions in various
`crypto/*` packages.
:::

::: {.zh}

Go在各种`crypto / *`包中实现了几个哈希函数。

:::


```go
import "crypto/sha1"
import "fmt"
func main() {
	s := "sha1 this string"
```


::: {.en}
The pattern for generating a hash is `sha1.New()`,
`sha1.Write(bytes)`, then `sha1.Sum([]byte{})`.
Here we start with a new hash.
:::

::: {.zh}

生成哈希的模式是`sha1.New（）`，`sha1.Write（bytes）`，然后是`sha1.Sum（[] byte {}）`。我们从一个新的哈希开始。

:::


```go
	h := sha1.New()
```


::: {.en}
`Write` expects bytes. If you have a string `s`,
use `[]byte(s)` to coerce it to bytes.
:::

::: {.zh}

`Write`需要字节。如果你有一个字符串`s`，使用`[] byte（s）`将它强制转换为字节。

:::


```go
	h.Write([]byte(s))
```


::: {.en}
This gets the finalized hash result as a byte
slice. The argument to `Sum` can be used to append
to an existing byte slice: it usually isn't needed.
:::

::: {.zh}

这将最终的哈希结果作为字节片段获取。 “Sum”的参数可用于附加到现有的字节切片：通常不需要它。

:::


```go
	bs := h.Sum(nil)
```


::: {.en}
SHA1 values are often printed in hex, for example
in git commits. Use the `%x` format verb to convert
a hash results to a hex string.
:::

::: {.zh}

SHA1值通常以十六进制格式打印，例如在git提交中。使用`％x`格式动词将哈希结果转换为十六进制字符串。

:::


```go
	fmt.Println(s)
	fmt.Printf("%xn", bs)
}
```


::: {.en}
Running the program computes the hash and prints it in
a human-readable hex format.
:::

::: {.zh}

运行程序计算哈希并以人类可读的十六进制格式打印。

:::


```sh
$ go run sha1-hashes.go
sha1 this string
cf23df2207d99a74fbe169e3eba035e633b65d94
```


::: {.en}
You can compute other hashes using a similar pattern to
the one shown above. For example, to compute MD5 hashes
import `crypto/md5` and use `md5.New()`.
Note that if you need cryptographically secure hashes,
you should carefully research
[hash strength](http://en.wikipedia.org/wiki/Cryptographic_hash_function)!
:::

::: {.zh}

您可以使用与上面显示的类似模式计算其他哈希值。例如，计算MD5 hashesimport`crypto / md5`并使用`md5.New（）`。注意如果你需要加密安全哈希，你应该仔细研究[hash strength]（http://en.wikipedia.org/维基/ Cryptographic_hash_function）！

:::


