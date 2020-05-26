import UIKit

extension Array where Element: Comparable {
    func bubbleSort() -> [Element] {
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

// массив отсортирован по возрастанию
[0,7,5,3,9,10].bubbleSort()

[1,0,8,7,5,3,9,10,19].selectionSort()
