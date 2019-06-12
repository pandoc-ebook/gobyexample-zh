
# Range over Channels {.en}


# 频道范围 {.zh}


::: {.en}
In a [previous](range) example we saw how `for` and
`range` provide iteration over basic data structures.
We can also use this syntax to iterate over
values received from a channel.
:::

::: {.zh}

在[previous]（范围）示例中，我们看到`for`和`range`如何在基本数据结构上提供迭代。我们也可以使用此语法迭代从通道接收的超值。

:::


```go
package main
import "fmt"
func main() {
```


::: {.en}
We'll iterate over 2 values in the `queue` channel.
:::

::: {.zh}

我们将在`queue`通道中迭代2个值。

:::


```go
	queue := make(chan string, 2)
	queue <- "one"
	queue <- "two"
	close(queue)
```


::: {.en}
This `range` iterates over each element as it's
received from `queue`. Because we `close`d the
channel above, the iteration terminates after
receiving the 2 elements.
:::

::: {.zh}

这个`range`遍历每个元素，因为它是从`queue`接收的。因为我们“关闭”上面的通道，迭代在接收到2个元素后终止。

:::


```go
	for elem := range queue {
		fmt.Println(elem)
	}
}
```


```sh
$ go run range-over-channels.go
one
two
```


::: {.en}
This example also showed that it's possible to close
a non-empty channel but still have the remaining
values be received.
:::

::: {.zh}

此示例还显示可以关闭非空通道但仍然可以接收剩余值。

:::


