# infinitary-combinatorics

This module provides robust combinatoric functions involving infinite lists.

### Why infinitary?

Suppose we want to take the 'Cartesian product' of two lists `xs` and `ys`, written `xs × ys`. A simple approach is the list comprehension `xs × ys = [ (x, y) | x <- xs, y <- ys]`.

The problem? This doesn't work as well as it could if `xs` and/or `ys` are infinite. If we take `["a","b"] × [1..]` the result is `[("a",1),("a",2),("a",3),...]`. No matter how far we evaluate the result we will never reach a pair with first element `"b"`. In mathematical terms, we would say the [order type](https://en.wikipedia.org/wiki/Order_type) of `["a","b"] × [1..]` is [ω⋅2](https://en.wikipedia.org/wiki/Ordinal_number).

With this in mind, it would be nice for our Cartesian product to satisfy the following property:

```order_preserving (×) ≡ ∀(x, y). x `elem` xs && y `elem` ys ↔ (x, y) `elem` xs × ys```

This doesn't hold for the above example, because

``"b" `elem` ["a","b"] && 4 `elem` [1..]`` is `True`, but ``("b", 4) `elem` ["a","b"] × [1..]`` is `⊥`.

In mathematical terms again, if `order_preserving (×)` holds and the order type of `xs` and `ys` are both at most ω, then the order type of `xs × ys` is at most ω.

This module contains combinatoric operations that each satisfy an analogous `order_preserving` property wherever possible. For example,

`["a","b"] × [1..] ≡ [("a",1),("a",2),("b",1),("a",3),("b",2),("a",4),("b",3),("a",5),...]`

``[0..] `pick` 3 ≡ [[0,0,0],[0,0,1],[1,0,0],[0,1,0],[1,0,1],[2,0,0],[0,0,2],[1,1,0],[2,0,1],...]``

