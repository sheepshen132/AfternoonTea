import UIKit

/*
 * 嵌套
 * Character.Oriented.Back
 * Character.Other
 */
enum Character {
    case Args
    enum Varargs {
        case Length
        case Count
        case Weight
    }
    enum Oriented {
        case Front
        case Back
    }
    case Other
}

/*
 * 包含
 * let _ = StructModel(type: Character.Varargs.Weight)
 */
struct StructModel {
    let type: Character.Varargs
}

/*
 * 关联值
 */
enum Trade {
    case Buy(String, Int)
    case Sell(String, Int)
    case Hold(String, Bool)
    case Bring(Double, Float)
}
enum UseAction {
    case Open(url: NSURL)
    case Start(time: NSDate)
    case Walk(length: Int)
}

func ==(lhs: Trade, rhs: Trade) -> Bool {
    switch (lhs, rhs) {
    case let (.Buy(stock1, amount1), .Buy(stock2, amount2))
        where stock1 == stock2 && amount1 == amount2:
        return true
    case let (.Sell(stock1, amount1), .Sell(stock2, amount2))
        where stock1 == stock2 && amount1 == amount2:
        return true
    default: return false
    }
}

/*
 * 如果我们忽略关联值，则枚举的值就只能是整型，浮点型，字符串和布尔类型
 */
enum Test: Int {
    case First
    case Second = 2
    case Third = 3
}
enum Optional<T> {
    case First(Double)
    case Second(String)
    case Last
}
enum Either<T, T1> {
    case Left
    case Right(String)
    case All(String, Bool)
}

enum Switch {
    case On, Off, High
    mutating func next() {
        switch self {
        case .On:
            self = .Off
        case .Off:
            self = .High
        case .High:
            self = .On
        }
    }
}

/*
 * 自定义
 */
enum Devices: CGSize {
    case Iphone5s = "{{0, 0}, {375, 667}}"
    case Iphone6 = "{{0, 0}, {414, 736}}"
}

extension CGSize: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let rect = NSCoder.cgRect(for: value)
        self = rect.size
    }
}
