// swift-closure-basics-demo.swift

// ============ 闭包基础 ============
let greeting = {
    print("Hello, Closure!")
}
greeting()

// ============ 带参数的闭包 ============
let add: (Int, Int) -> Int = { a, b in
    return a + b
}
print("3 + 5 = \(add(3, 5))")

// ============ 简写形式 ============
let multiply = { (a: Int, b: Int) -> Int in
    a * b
}
// 使用上下文类型推断
let multiply2: (Int, Int) -> Int = { $0 * $1 }
print("4 * 6 = \(multiply2(4, 6))")

// ============ 闭包作为参数 ============
func operate(on a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}
let result = operate(on: 10, b: 5, operation: { $0 - $1 })
print("10 - 5 = \(result)")

// ============ 尾随闭包 ============
let numbers = [1, 2, 3, 4, 5]
let doubled = numbers.map { $0 * 2 }
print("翻倍: \(doubled)")

// ============ 捕获值 ============
func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}
let counter = makeCounter()
print("计数器: \(counter()), \(counter()), \(counter())")
