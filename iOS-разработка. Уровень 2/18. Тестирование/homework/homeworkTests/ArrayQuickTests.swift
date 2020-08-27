import XCTest
import Quick
import Nimble
@testable import homework

class ArrayQuickTests: QuickSpec {
    override func tearDown() {
    
    }

    override func spec() {
        describe("ArrayQuickTests") {
            it("result") {
                // Bubble sort
                expect(TestArray().first.bubbleSort()).to(equal([1, 2, 4, 5, 8]))
                // Selection sort
                expect(TestArray().second.selectionSort()).to(equal([11, 12, 22, 25, 64]))
                // Insertion sort (Descending)
                expect(TestArray().third.insertionSortDesc()).to(equal([1, 2, 3, 4, 5, 6, 7, 8, 9]))
                // Insertion sort (Ascending)
                expect(TestArray().third.insertionSortAsc()).to(equal([9, 8, 7, 6, 5, 4, 3, 2, 1]))
                // Reversed sort
                expect(TestArray().fourth.reversed()).to(equal([0, 2, 5, 9, 1, 7]))
                // Ascending sort
                expect(TestArray().letters.sorted(by: >)).to(equal(["X", "Q", "M", "K", "B", "A"]))
                // Descending sort
                expect(TestArray().letters.sorted(by: <)).to(equal(["A", "B", "K", "M", "Q", "X"]))
            }
        }
    }
}
