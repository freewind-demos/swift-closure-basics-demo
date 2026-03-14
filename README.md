# Swift 闭包基础 Demo

## 简介

展示 Swift 闭包的基本用法：定义、参数、尾随闭包。

## 启动和使用

```bash
cd swift-closure-basics-demo
swift run
```

## 教程

### 闭包语法

```swift
{ (参数) -> 返回类型 in
    // 代码
}
```

### 简写形式

- 使用 `$0`, `$1` 等代替参数名
- 单表达式可省略 `return`

### 尾随闭包

如果闭包是最后一个参数，可以写在括号外：
```swift
numbers.map { $0 * 2 }
```
