import Foundation

enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
}

extension List {
    func insert(_ value: Element) -> List {
        return .node(value, next: self)
    }
}

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) {
            $0.insert($1)
        }
    }
}

extension List {
    mutating func push(_ value: Element) {
        self = self.insert(value)
    }
    
    mutating func pop() -> Element? {
        switch self {
        case .end:
            return nil
        case let .node(value, next: node):
            self = node
            return value
        }
    }
}

let list1:List = [1, 2]
var list2:List = [1, 2]

var list3 = list2
var list4 = list2

list2.pop()
list2.pop()

list3.pop()
list3.push(11)

list3.pop()
list3.pop()
list4.pop()
list4.pop()
