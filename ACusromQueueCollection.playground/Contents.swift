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

var numberQueue:FIFOQueue = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

//for i in 1 ... 10 {
//    numberQueue.push(i)
//}

for number in numberQueue {
    print(number)
}

var numberArray = [Int]()
numberArray.append(contentsOf: numberQueue)
print(numberArray)

numberQueue.isEmpty
numberQueue.count
numberQueue.first

print(numberQueue.map { $0 * 2 })
print(numberQueue.filter { $0 % 2 == 0})
print(numberQueue.reduce(0, +))
