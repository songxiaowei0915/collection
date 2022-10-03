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

var iter = FiboIterator()

for _ in (1 ... 10) {
    print(iter.next()!)
}

print("----------------------------------")

let fibs = Fibonacci()
var fibsIter1 = fibs.makeIterator()
var fibsIter2 = fibs.makeIterator()

while let value = fibsIter1.next() {
    guard value < 10 else { break }
    print("iter1: \(value)")
}

print("=======")
while let value = fibsIter2.next() {
    guard value < 10 else { break }
    print("iter1: \(value)")
}

print("----------------------------------")

let fibo1 = Fibonacci().prefix(10)
let fibo2 = Fibonacci().prefix(10).suffix(5)

print(Array(fibo1))
print(Array(fibo2))

print("--------------------------------")
let fiboArray = fibo1.split(whereSeparator: { $0 % 2 == 0})
fiboArray.forEach {
    print(Array($0))
}
