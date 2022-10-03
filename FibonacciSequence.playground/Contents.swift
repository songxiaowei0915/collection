import UIKit

struct FiboIterator: IteratorProtocol {
    var state = (0, 1)
    
    mutating func next() -> Int? {
        let nextValue = state.0
        state = (state.1,state.0+state.1)
        
        return nextValue
    }
}

func fiblIterrator() -> AnyIterator<Int> {
    var state = (0, 1)
    
    return AnyIterator{
        let nextValue = state.0
        state = (state.1,state.0+state.1)
        
        return nextValue
    }
}

struct Fibonacci: Sequence {
    typealias Element = Int
    
    func makeIterator() -> AnyIterator<Element> {
        return AnyIterator(FiboIterator())
    }
}

let fibo = Fibonacci()
var fiboIter1 = fibo.makeIterator()
var fiboIter2 = fiboIter1

print(fiboIter1.next()!)
print(fiboIter1.next()!)

print(fiboIter2.next()!)
print(fiboIter2.next()!)
print(fiboIter2.next()!)

print("-----------------------------")
let fiboSequence = AnySequence(fiblIterrator)
print(Array(fiboSequence.prefix(10)))

print("----------------------------")
let tenToOne = sequence(first: 10, next: {
    guard $0 != 1 else { return nil }
    return $0 - 1
})
print(Array(tenToOne))

print("------------------------")
let fibSeq = sequence(state: (0, 1), next: { (state: inout(Int, Int)) -> Int? in
    let nextValue = state.0
    state = (state.1,state.0+state.1)
    
    return nextValue
})

print(Array(fibSeq.prefix(8)))
