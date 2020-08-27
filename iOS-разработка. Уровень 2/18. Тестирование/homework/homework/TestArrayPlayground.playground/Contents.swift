class TestArray {
    var first = [5,1,4,2,8] // Bubble sort
    var second = [64,25,12,22,11] // Selection sort
    var third = [6,5,3,1,8,7,2,4,9] // Insertion sort (Descending & Ascending)
    var fourth = [7,1,9,5,2,0] // Reversed
    let letters = ["K", "B", "Q", "A", "X", "M"] // Sort ascending & sort descending
    
    init() {
        print("Bubble sort:")
        print("Raw: \(first)")
        print("Result: \(first.bubbleSort())") // [0, 3, 5, 7, 9, 10]
        
        print("\nSelection sort:")
        print("Raw: \(second)")
        print("Result: \(second.selectionSort())") // [0, 1, 3, 5, 7, 8, 9, 10, 19]

        print("\nInsertion sort:")
        print("Raw: \(third)")
        print("Insertion sort (Descending): \(third.insertionSortDesc())") // [0, 1, 3, 5, 7, 8, 9, 10, 19]
        print("Insertion sort (Ascending): \(third.insertionSortAsc())") // [19, 10, 9, 8, 7, 5, 3, 1, 0]
        
        print("\nReversed sort:")
        print("Raw: \(fourth)")
        print("Result: \(Array(fourth.reversed()))")

        print("\nRaw: \(letters)")
        print("Ascending sort: \(letters.sorted(by: >))") // ["X", "Q", "M", "K", "B", "A"]
        print("Descending sort: \(letters.sorted(by: <))") // ["A", "B", "K", "M", "Q", "X"]
    }
}

//MARK: -- Bubble Sort
extension Array where Element: Comparable {
    /// https://en.wikipedia.org/wiki/Bubble_sort
    ///
    /// https://ru.wikipedia.org/wiki/Сортировка_пузырьком
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
}

//MARK: -- Selection Sort
extension Array where Element: Comparable {
    /// https://en.wikipedia.org/wiki/Selection_sort
    ///
    /// https://ru.wikipedia.org/wiki/Сортировка_выбором
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

print(TestArray())
