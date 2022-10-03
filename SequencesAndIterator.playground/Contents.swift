import Foundation

let numbers = [1, 2, 3, 4, 5]

//protocol Sequence {
//    associatedtype Iterator: IteratorProtocol
//
//    func makeIterator() -> Iterator
//}
//
//protocol IteratorProtocol {
//    associatedtype Element
//
//    mutating func next() -> Element?
//}

var begin = numbers.makeIterator()

while let number = begin.next() {
    print(number)
}

print("------------------------------------")

struct FiboIterator: IteratorProtocol {
    var state = (0, 1)
    
    mutating func next() -> Int? {
        let nextValue = state.0
        state = (state.1,state.0+state.1)
        
        return nextValue
    }
}

struct Fibonacci: Sequence {
    func makeIterator() -> FiboIterator {
        return FiboIterator()
    }
}

let fb = Fibonacci()
var fibIter = fb.makeIterator()

while let number = fibIter.next() {
    if number > 50 {break}
    print(number)
}



