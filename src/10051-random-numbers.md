
# Random Numbers {.en}


# 随机数 {.zh}


::: {.en}
Go's `math/rand` package provides
[pseudorandom number](http://en.wikipedia.org/wiki/Pseudorandom_number_generator)
generation.
:::

::: {.zh}

Go的`math / rand`包提供[伪随机数]（http://en.wikipedia.org/wiki/Pseudorandom_number_generator）生成。

:::


```go
package main
import "time"
import "fmt"
import "math/rand"
func main() {
```


::: {.en}
For example, `rand.Intn` returns a random `int` n,
`0 <= n < 100`.
:::

::: {.zh}

例如，`rand.Intn`返回一个随机的`int`n，`0 <= n <100`。

:::


```go
	fmt.Print(rand.Intn(100), ",")
	fmt.Print(rand.Intn(100))
	fmt.Println()
```


::: {.en}
`rand.Float64` returns a `float64` `f`,
`0.0 <= f < 1.0`.
:::

::: {.zh}

`rand.Float64`返回`float64``f`，`0.0 <= f <1.0`。

:::


```go
	fmt.Println(rand.Float64())
```


::: {.en}
This can be used to generate random floats in
other ranges, for example `5.0 <= f' < 10.0`.
:::

::: {.zh}

这可以用于在其他范围内生成随机浮点数，例如“5.0 <= f”<10.0`。

:::


```go
	fmt.Print((rand.Float64()*5)+5, ",")
	fmt.Print((rand.Float64() * 5) + 5)
	fmt.Println()
```


::: {.en}
The default number generator is deterministic, so it'll
produce the same sequence of numbers each time by default.
To produce varying sequences, give it a seed that changes.
Note that this is not safe to use for random numbers you
intend to be secret, use `crypto/rand` for those.
:::

::: {.zh}

默认数字生成器是确定性的，因此默认情况下每次都会生成相同的数字序列。要生成不同的序列，请给它一个变化的种子。注意这对于随机数使用是不安全的。 `crypto / rand`。

:::


```go
	s1 := rand.NewSource(time.Now().UnixNano())
	r1 := rand.New(s1)
```


::: {.en}
Call the resulting `rand.Rand` just like the
functions on the `rand` package.
:::

::: {.zh}

调用生成的`rand.Rand`就像`rand`包中的函数一样。

:::


```go
	fmt.Print(r1.Intn(100), ",")
	fmt.Print(r1.Intn(100))
	fmt.Println()
```


::: {.en}
If you seed a source with the same number, it
produces the same sequence of random numbers.
:::

::: {.zh}

如果为具有相同编号的源播种，则会生成相同的随机数序列。

:::


```go
	s2 := rand.NewSource(42)
	r2 := rand.New(s2)
	fmt.Print(r2.Intn(100), ",")
	fmt.Print(r2.Intn(100))
	fmt.Println()
	s3 := rand.NewSource(42)
	r3 := rand.New(s3)
	fmt.Print(r3.Intn(100), ",")
	fmt.Print(r3.Intn(100))
}
```


```bash
$ go run random-numbers.go
81,87
0.6645600532184904
7.123187485356329,8.434115364335547
0,28
5,87
5,87
```


::: {.en}
See the [`math/rand`](http://golang.org/pkg/math/rand/)
package docs for references on other random quantities
that Go can provide.
:::

::: {.zh}

请参阅[`math / rand`]（http://golang.org/pkg/math/rand/）包文档，以获取Go可提供的其他随机数量的参考。

:::


