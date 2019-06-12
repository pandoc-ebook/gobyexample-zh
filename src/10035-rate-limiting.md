
# Rate Limiting {.en}


# 限速 {.zh}


::: {.en}
<em>[Rate limiting](http://en.wikipedia.org/wiki/Rate_limiting)</em>
is an important mechanism for controlling resource
utilization and maintaining quality of service. Go
elegantly supports rate limiting with goroutines,
channels, and [tickers](tickers).
:::

::: {.zh}

<em> [速率限制]（http://en.wikipedia.org/wiki/Rate_limiting）</ em>是控制资源利用和维护服务质量的重要机制。 Goelegantly支持goroutines，channel和[tickers]（代码）的速率限制。

:::


```go
package main
import "time"
import "fmt"
func main() {
```


::: {.en}
First we'll look at basic rate limiting. Suppose
we want to limit our handling of incoming requests.
We'll serve these requests off a channel of the
same name.
:::

::: {.zh}

首先，我们将介绍基本的速率限制。假设我们想限制我们对传入请求的处理。我们将通过相同名称的频道提供这些请求。

:::


```go
	requests := make(chan int, 5)
	for i := 1; i <= 5; i++ {
		requests <- i
	}
	close(requests)
```


::: {.en}
This `limiter` channel will receive a value
every 200 milliseconds. This is the regulator in
our rate limiting scheme.
:::

::: {.zh}

这个“限制器”通道每200毫秒会收到一个值。这是稳压器速率限制方案。

:::


```go
	limiter := time.Tick(200 * time.Millisecond)
```


::: {.en}
By blocking on a receive from the `limiter` channel
before serving each request, we limit ourselves to
1 request every 200 milliseconds.
:::

::: {.zh}

通过在为每个请求提供服务之前阻止来自“限制器”通道的接收，我们每200毫秒将自己限制为1个请求。

:::


```go
	for req := range requests {
		<-limiter
		fmt.Println("request", req, time.Now())
	}
```


::: {.en}
We may want to allow short bursts of requests in
our rate limiting scheme while preserving the
overall rate limit. We can accomplish this by
buffering our limiter channel. This `burstyLimiter`
channel will allow bursts of up to 3 events.
:::

::: {.zh}

我们可能希望允许在我们的速率限制方案中进行短时间的突发请求，同时保持整体速率限制。我们可以通过缓冲限制器通道来实现这一点。这个`burstyLimiter`channel将允许最多3个事件的突发。

:::


```go
	burstyLimiter := make(chan time.Time, 3)
```


::: {.en}
Fill up the channel to represent allowed bursting.
:::

::: {.zh}

填写频道以表示允许的爆发。

:::


```go
	for i := 0; i < 3; i++ {
		burstyLimiter <- time.Now()
	}
```


::: {.en}
Every 200 milliseconds we'll try to add a new
value to `burstyLimiter`, up to its limit of 3.
:::

::: {.zh}

每隔200毫秒我们就会尝试将新值添加到`burstyLimiter`，最高限制为3。

:::


```go
	go func() {
		for t := range time.Tick(200 * time.Millisecond) {
			burstyLimiter <- t
		}
	}()
```


::: {.en}
Now simulate 5 more incoming requests. The first
3 of these will benefit from the burst capability
of `burstyLimiter`.
:::

::: {.zh}

现在模拟另外5个传入请求。其中的前3个将受益于`burstyLimiter`的突发能力。

:::


```go
	burstyRequests := make(chan int, 5)
	for i := 1; i <= 5; i++ {
		burstyRequests <- i
	}
	close(burstyRequests)
	for req := range burstyRequests {
		<-burstyLimiter
		fmt.Println("request", req, time.Now())
	}
}
```


::: {.en}
Running our program we see the first batch of requests
handled once every ~200 milliseconds as desired.
:::

::: {.zh}

运行我们的程序，我们看到第一批请求每隔约200毫秒处理一次。

:::


```sh
$ go run rate-limiting.go
request 1 2012-10-19 00:38:18.687438 +0000 UTC
request 2 2012-10-19 00:38:18.887471 +0000 UTC
request 3 2012-10-19 00:38:19.087238 +0000 UTC
request 4 2012-10-19 00:38:19.287338 +0000 UTC
request 5 2012-10-19 00:38:19.487331 +0000 UTC
```


::: {.en}
For the second batch of requests we serve the first
3 immediately because of the burstable rate limiting,
then serve the remaining 2 with ~200ms delays each.
:::

::: {.zh}

对于第二批请求，由于可突发的速率限制，我们立即服务于前3，然后为剩余的2个服务，每个延迟约200ms。

:::


```sh
request 1 2012-10-19 00:38:20.487578 +0000 UTC
request 2 2012-10-19 00:38:20.487645 +0000 UTC
request 3 2012-10-19 00:38:20.487676 +0000 UTC
request 4 2012-10-19 00:38:20.687483 +0000 UTC
request 5 2012-10-19 00:38:20.887542 +0000 UTC
```


