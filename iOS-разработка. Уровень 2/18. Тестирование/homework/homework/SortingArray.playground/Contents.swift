import UIKit

//MARK: -- Bubble Sort
extension Array where Element: Comparable {
    public func bubbleSort() -> [Element] {
        var array = self
        for i in (0..<array.count-1).reversed() {
            for j in (1..<(i+1)) {
                if array[j-1] > array[j] {
                    let temp = array[j-1]
                    array[j-1] = array[j]
                    array[j] = temp
                }
            }
        }
        return array
    }
}

var first = [5,1,4,2,8]
print("Bubble sort:")
print("Raw: \(first)")
print("Result: \(first.bubbleSort())") // [1, 2, 4, 5, 8]

//MARK: -- Selection Sort
extension Array where Element: Comparable {
    func selectionSort() -> [Element] {
        var array = self
        for i in array.indices {
            var minIndex = i
            for j in i+1..<array.count {
                if array[j] < array[minIndex] {
                    minIndex = j
                }
            }
            let temp = array[minIndex]
            array[minIndex] = array[i]
            array[i] = temp
        }
        return array
    }
}

var second = [64,25,12,22,11]
print("\nSelection sort:")
print("Raw: \(second)")
print("Result: \(second.selectionSort())") // [11, 12, 22, 25, 64]

//MARK: -- Insertion Sort
extension Array where Element: Comparable {
    /// Insertion Sort Method for Descending Order
    ///
    /// https://en.wikipedia.org/wiki/Insertion_sort
    ///
    /// https://ru.wikipedia.org/wiki/Сортировка_вставками
    func insertionSortDesc() -> Array<Element> {
        guard self.count > 1 else { return self }
    
        var output: Array<Element> = self
    
        for first in 0..<output.count {
            let key = output[first]
            var second = first
               
            while second > -1 {
                if key < output[second] {
                
                    output.remove(at: second + 1)
                    output.insert(key, at: second)
                }
            second -= 1
            }
        }
        return output
    }
    /// Insertion Sort Method for Ascending Order
    ///
    /// https://en.wikipedia.org/wiki/Insertion_sort
    ///
    /// https://ru.wikipedia.org/wiki/Сортировка_вставками
    func insertionSortAsc() -> Array<Element> {
        guard self.count > 1 else { return self }
    
        var output: Array<Element> = self
    
        for first in 0..<output.count {
            let key = output[first]
            var second = first
               
            while second > -1 {
                if key > output[second] {
                
                    output.remove(at: second + 1)
                    output.insert(key, at: second)
                }
            second -= 1
            }
        }
        return output
    }
}

var third = [6,5,3,1,8,7,2,4,9]
print("\nInsertion sort:")
print("Raw: \(third)")
print("Insertion sort (Descending): \(third.insertionSortDesc())") // [1, 2, 3, 4, 5, 6, 7, 8, 9]
print("Insertion sort (Ascending): \(third.insertionSortAsc())") // [9, 8, 7, 6, 5, 4, 3, 2, 1]

var fourth = [7,1,9,5,2,0]
print("\nReversed sort:")
print("Raw: \(fourth)")
print("Bucket sort: \(Array(fourth.reversed()))")

let letters = ["K", "B", "Q", "A", "X", "M"]
print("\nRaw: \(letters)")
print("Ascending sort: \(letters.sorted(by: >))") // ["X", "Q", "M", "K", "B", "A"]
print("Descending sort: \(letters.sorted(by: <))") // ["A", "B", "K", "M", "Q", "X"]
