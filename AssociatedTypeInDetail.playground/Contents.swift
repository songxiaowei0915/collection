import UIKit

protocol Queue {
    associatedtype Element
    
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
}

struct FIFOQueue<Element>: Queue, Collection {
    public var startIndex: Int { return 0}
    public var endIndex: Int {
        return operation.count + storage.count
    }
    
    public subscript(position: Int) -> Element {
        precondition((startIndex ..< endIndex).contains(position), "out of range")
        
        if position < operation.endIndex {
            return operation[operation.count-1 - position]
        }
        
        return storage[position - operation.count]
    }
    
    func index(after i: Int) -> Int {
        precondition(i < endIndex)
        
        return i + 1
    }
    
    
    fileprivate var operation: [Element] = []
    fileprivate var storage: [Element] = []
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    mutating func pop() -> Element? {
        if operation.isEmpty {
            operation = storage.reversed()
            storage.removeAll()
        }
        
        return operation.popLast()
    }
}

extension FIFOQueue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.init(operation: elements.reversed(),storage: [])
    }
}

extension FIFOQueue {
    var indices: CountableRange<Int> {
        return startIndex ..< endIndex
    }
}

var numberQueue: FIFOQueue = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

var i1 = numberQueue.makeIterator()

print(i1.next())

numberQueue.push(11)
(1 ... 10).forEach { _ in
    print(i1.next())
}

var i2 = numberQueue.makeIterator()
while let number = i2.next() {
    print(number)
}

print(numberQueue.endIndex - numberQueue.startIndex)

numberQueue.indices.forEach {
    print("\(type(of: $0))  \($0)")
}
