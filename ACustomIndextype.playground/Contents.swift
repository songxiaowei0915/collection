import Foundation

enum Node<Element> {
    case end
    indirect case node(Element, next: Node<Element>)
}

extension Node {
    func insert(_ value: Element) -> Node {
        return .node(value, next: self)
    }
}

public struct ListIndex<Element>: CustomStringConvertible {
    fileprivate let node: Node<Element>
    fileprivate let tag: Int
    
    public var description: String {
        return "IndexTag: \(tag)"
    }
}

extension ListIndex: Comparable {
    public static func < <T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
        return lhs.tag > rhs.tag
    }
    
    public static func ==<T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
        return lhs.tag == rhs.tag
    }
}

struct List<Element>: Collection {
    typealias Index = ListIndex<Element>
    
    var startIndex: Index
    let endIndex: Index
    
    subscript(position: Index) -> Element {
        switch position.node {
        case .end:
            fatalError("out of range")
        case let .node(value, _):
            return value
        }
    }
    
    func index(after position: Index) -> Index {
        switch position.node {
        case .end:
            fatalError("out of range")
        case let .node(_, next):
            return Index(node: next, tag: position.tag - 1)
        }
    }
    
}

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        startIndex = Index(node: elements.reversed().reduce(.end) {
            $0.insert($1)}, tag: elements.count)
        
        endIndex = Index(node: .end, tag: 0)
    }
}

extension List {
    mutating func push(_ value: Element) {
        startIndex = Index(node: startIndex.node.insert(value), tag: startIndex.tag+1)
    }
    
    mutating func pop() -> Index {
        let ret = startIndex
        startIndex = index(after: startIndex)
        
        return ret
    }
}

extension List: CustomStringConvertible {
    var description: String {
        let value = self.map {
            String(describing: $0)
        }.joined(separator: ", ")
        
        return "List: \(value)"
    }
}

extension List {
    var count: Int {
        return startIndex.tag - endIndex.tag
    }
}

func == <T: Equatable>(lhs: List<T>, rhs: List<T>) -> Bool {
    return lhs.elementsEqual(rhs)
}

var list1: List = [1, 2, 3, 4, 5]
var list2: List = [1, 2, 3, 4, 5]

print(list1 == list2)



list1.forEach({
    print($0)
})

print(list1.contains(1))
print(list1.elementsEqual([1,2,3,4,5]))

print(list1.count)
print(list1.first)
print(list1.index(of: 5))

list1.push(11)
print(list1)
list1.pop()
print(list1)
