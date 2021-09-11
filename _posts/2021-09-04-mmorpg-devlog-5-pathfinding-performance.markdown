---
layout: post
title: "MMORPG Devlog 5: Improving Pathfinding Performance"
date: 2021-09-03 01:45
tags: mmorpgdevlog
---

*This post is part of my [MMORPG Devlog series.]({{site.baseurl}}/tags/mmorpgdevlog/)*

Following my recent dive into [server side navmeshes]({{site.baseurl}}/2021/08/22/mmorpg-devlog-4-pathfinding-geometry/), I quickly discovered some apparent performance issues that could use some investigation. The pathfinding routine seemed to lag for a few seconds before the route was drawn onscreen, and the server startup was also delayed by the graph generation.


### Profiling With Stopwatches
My development machine is a MacBook Pro, which presented a limitation in tracking down exactly what was slowing the game down. Microsoft, as it turns out, does not offer a profiler for the .NET platform on Mac OS X. The version of Visual Studio (Community Edition) that is available for Macs is a rebranded Xamarin Studio...which is an improvement over MonoDevelop, what people tended to use with Unity in the past, but it doesn't have nearly the same feature set as the full Visual Studio for Windows. As far as I can tell, there isn't such a tool for Macs or Linux at all, aside from JetBrains' offering in their commercial Rider IDE.

Oh well. I tend to use print-debugging anyway, so it's not like I can't easily devise a more manual approach...

Fortunately, C\# has a convenient [Stopwatch](https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.stopwatch) class in the `System.Diagnostics` package. It's simple enough to wrap function calls in `Start()` and `Stop()` invocations, printing out the elapsed time.

{% highlight csharp %}{% raw %}
using System.Diagnostics;
var watch = new Stopwatch();
watch.Start();
//do thing
watch.Stop();
Console.WriteLine($"Did Thing in {watch.ElapsedMilliseconds}ms");
{% endraw %}{% endhighlight %}

I already had a good idea about potential slowdowns anyway, so I wrapped timings around a few key functions and ran the server. My findings were a little surprising though.


### The Data
When the server started up and the zones loaded, my suspicions were confirmed about the $$\mathcal{O}(n^2)$$ function that connects the polygons up into a graph to pathfind on. The time spent on that step grows very quickly as more objects are added. It only runs once on startup though, so that wasn't my culprit for the lengthy delays when the paths were drawn.

{% highlight plain %}{% raw %}
Neighbor generation for 401 triangles: 58ms
Neighbor generation for 3051 triangles: 3288ms
{% endraw %}{% endhighlight %}

Next, I kicked off a the `FindPath()` method and watched the results.

{% highlight plain %}{% raw %}
Raycasting for 3051 triangles: 0ms
Raycasting for 3051 triangles: 1ms
Path refinement for 3051 triangles: 0ms
Total pathfinding time for 3051 triangles: 2ms
{% endraw %}{% endhighlight %}

Wait, that can't be right. On the larger zone, my pathfinding is still lightning fast!

As it turns out, the apparent sluggishness was actually a result of drawing all of the gizmos on the client. When the gizmo lines for the triangle boundaries are disabled, pathfinding happens immediately on the larger zone.


### Speeding up the Start Time
Since I didn't have to worry about the performance of the pathfinding itself, I decided to work on improving the sluggish graph building step, since that could get to be annoying as more zones are added.

I evaluated a few approaches, chasing that linear growth rate...because that's just what you do. I was stuck on the idea of using a dictionary to do fast lookups of vertices, so I could trade a bit of temporary memory usage for an $$\mathcal{O}(n)$$ algorithm. Sadly, that didn't work out since I ran into snags no matter which approach I took.

1. If I used the vertex indices from the OBJ file as my dictionary key, triangles would still not show as neighbors because the OBJ file is perfectly fine with having multiple vertex indices that just so happen to have the exact same coordinates. So Triangle A might have vertices 37 and 38 forming an edge against Triangle B, but the vertices it has are 47 and 49, despite having the exact same coordinates.

2. Vector3 objects as dictionary keys are straight up not going to work because floating point numbers are a huge pain. Two Vector3s constructed at different times (e.g. the two triangles in the previous example) are distinct objects with unique HashCodes, so the `Contains()` method in a dictionary won't be able to find one when given another. You can't make a custom IEqualityComparer either, even though you could easily implement an `Equals()` method that checks if vector distance is less than a very small number, because that requires implementing a custom HashCode function. As far as I'm aware, it's actually not possible to make a reliable hash that provides the same value for floating point numbers that are *close* to each other but not binary equivalents.

In the end, I thought of a solution that's good but not perfect. The *inner loop* of the original algorithm gets transplanted into the place where the OBJ parser instantiates the new triangle object. So the number of iterations of that inner loop increases as more triangles are parsed, but the total iterations are far lower than before. It ends up being about half what the original function had.

I also found an unexpected optimization for the vector equality helper function. Instead of using the built-in vector distance method, `return Vector3.DistanceSquared(a, b) < 0.001`, I did the math longhand and it actually cut a whole second off of the time.

{% highlight plain %}{% raw %}
private bool VEQ(Vector3 a, Vector3 b) {
    return (a.X - b.X) * (a.X - b.X) +
           (a.Y - b.Y) * (a.Y - b.Y) +
           (a.Z - b.Z) * (a.Z - b.Z) < 0.001;
}
{% endraw %}{% endhighlight %}

I'm not sure what Microsoft's function is doing under the hood, since an additional function call shouldn't have that kind of overhead...so that was an interesting finding, which I just tried out of curiosity. `VEQ(...)` is called a total of 12 times in each iteration of the neighbor generation, so it definitely had potential to add up.

That change and the loop reduction together bring the execution time down to 1135ms from 3288ms. I'm definitely happy with that. If it adds up down the line, I can always revisit it again later, rather than going further down the premature optimization rabbit hole now. The way the classes are structured, the loading process is also a potential candidate for [Parallel.Foreach](https://docs.microsoft.com/en-us/dotnet/standard/parallel-programming/how-to-write-a-simple-parallel-foreach-loop).

The important thing is that the part which will be run frequently over the life of the program, the pathfinding, is nice and fast.