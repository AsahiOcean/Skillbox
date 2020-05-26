import UIKit

class TreeNode<T> {
    var value: T?
    
    var left: TreeNode<T>?
    var right: TreeNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

let top = TreeNode(value: 8)
let left = TreeNode(value: 3)
let rigth = TreeNode(value: 10)
top.left = left
top.right = rigth
