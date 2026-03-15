# Swift 闭包基础 Demo

## 简介

本 demo 展示 Swift 闭包的基本用法：定义、参数、尾随闭包。闭包是 Swift 中的**一等公民**，广泛用于函数式编程、异步回调、集合操作等场景。

## 基本原理

### 什么是闭包？

闭包是**自包含的代码块**，可以捕获和保存其定义范围内的变量。简单来说，闭包就是"可以保存状态的函数"。

```swift
// 闭包的完整语法
let greeting = {
    print("Hello, Closure!")
}
greeting()  // 输出: Hello, Closure!
```

### 闭包 vs 函数

闭包和函数的主要区别：

| 特性 | 函数 | 闭包 |
|------|------|------|
| 有名字 | 有 | 可以没有 |
| 捕获变量 | 不捕获 | 可以捕获 |
| 作为参数 | 可以 | 可以 |
| 作为返回值 | 可以 | 可以 |

### 闭包的本质

闭包本质上是一个**捕获了外部变量的函数**。当闭包创建时，它会"捕获"其作用域中的变量：

```swift
func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}

let counter = makeCounter()
print(counter())  // 1
print(counter())  // 2
print(counter())  // 3
```

这里的闭包捕获了 `count` 变量，每次调用都会记住之前的值。

---

## 启动和使用

### 环境要求

- Swift 5.0+
- macOS 或 Linux

### 安装和运行

```bash
cd swift-closure-basics-demo
swift run
---

## 教程

### 闭包基本语法

```swift
// 最简单的闭包（无参数无返回值）
let greeting = {
    print("Hello, Closure!")
}
greeting()
```

带参数的闭包：

```swift
let add: (Int, Int) -> Int = { a, b in
    return a + b
}
print("3 + 5 = \(add(3, 5))")
```

闭包语法结构：
```swift
{ (参数) -> 返回类型 in
    // 闭包体
}
```

### 闭包类型

闭包类型用箭头表示：

```swift
// (Int, Int) -> Int 表示接受两个 Int 参数，返回 Int 的闭包
let multiply: (Int, Int) -> Int = { a, b in
    a * b
}
```

### 简写形式

Swift 提供了多种简写形式：

**1. 省略类型推断**

```swift
// 上下文可以推断类型
let multiply = { (a: Int, b: Int) -> Int in
    a * b
}
```

**2. 使用 $0, $1, $2...**

```swift
// $0 表示第一个参数，$1 表示第二个参数
let multiply2: (Int, Int) -> Int = { $0 * $1 }
print("4 * 6 = \(multiply2(4, 6))")
```

**3. 单表达式省略 return**

```swift
let square = { (x: Int) -> Int in
    x * x  // 单表达式可以省略 return
}
```

### 闭包作为参数

闭包可以作为函数参数：

```swift
func operate(on a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

let result = operate(on: 10, b: 5, operation: { $0 - $1 })
print("10 - 5 = \(result)")
```

### 尾随闭包

如果闭包是函数的**最后一个参数**，可以写在括号外面：

```swift
let numbers = [1, 2, 3, 4, 5]

// 不使用尾随闭包
let doubled = numbers.map({ $0 * 2 })

// 使用尾随闭包（更简洁）
let doubled2 = numbers.map { $0 * 2 }
print("翻倍: \(doubled2)")
```

**注意**：尾随闭包让代码更易读，特别适合 `map`、`filter`、`reduce` 等集合操作。

### 捕获值

闭包可以"捕获"其定义范围内的变量：

```swift
func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}

let counter = makeCounter()
print("计数器: \(counter()), \(counter()), \(counter())")
// 输出: 计数器: 1, 2, 3
```

**原理**：
- `makeCounter()` 返回一个闭包
- 这个闭包捕获了 `count` 变量
- 每次调用闭包时，都会修改同一个 `count`

---

## 关键代码详解

### 闭包的捕获机制

```swift
func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}
```

Swift 的闭包通过**捕获列表**捕获变量：
- `count` 是值类型（Int），闭包会捕获它的当前值
- 但实际上，Swift 会把 `count` 包装成引用类型，以保持状态

### 闭包的内存管理

闭包会持有它捕获的变量：
- 如果闭包被释放，捕获的变量也会被释放
- 这可能导致**循环引用**（后续在高级部分会讲）

---

## 总结

闭包是 Swift 非常重要的特性：

1. **一等公民** — 闭包可以作为参数、返回值、变量存储
2. **捕获值** — 闭包可以捕获外部变量，保持状态
3. **简洁语法** — 多种简写形式（$0、尾随闭包）
4. **函数式编程** — map、filter、reduce 都依赖闭包

闭包的使用场景：
- 集合操作（map、filter、reduce）
- 异步回调
- 事件处理
- 延迟执行
- 函数工厂
