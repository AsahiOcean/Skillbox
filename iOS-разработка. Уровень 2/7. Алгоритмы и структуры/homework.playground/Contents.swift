import UIKit
/*
Реализуйте класс linked list, работающий только со строками. Сделайте в нем функцию поиска строки.
Реализуйте класс для бинарного дерева поиска, работающее только со строками. Сделайте в нем функцию поиска.
Реализуйте класс для графа со станциями метро, где ребра хранят в себе длительность переезда между двумя станциями. Сделайте в нем поиск пути (любым способом) с одной станции на другую.
Реализуйте функцию сортировки массива еще двумя способами, кроме рассказанных на уроке.
*/
//MARK: -- 1) Реализуйте класс linked list, работающий только со строками. Сделайте в нем функцию поиска строки.

//MARK: Linked List - это ЛИНЕЙНАЯ последовательность(структура) "узлов", где каждый из которых может содержать значение(я) и ссылки на следующие и/или предыдущие узлы
//MARK: Linked List: ...<->[1]<->[2]<->[3]<->[4]<->[5]<->...

class LinkedListNode<T> {
    var key: T
    var next: LinkedListNode<T>?
    var prev: LinkedListNode<T>?
    
    init(_ value: T) {
        self.key = value
    }
}

class LinkedList<T: Equatable> {
    
    typealias Node = LinkedListNode<T>
    
    var node0: Node?
    var first: Node? { node0 }
    
    var show: String {
        var arr = "["
        guard var node = node0 else {
            return arr + "]"
        }
        while let next = node.next {
            arr += "\(node.key), "
            node = next
        }
        arr += "\(node.key)"
        return arr + "]"
    }
    
    var last: Node? {
        guard var node = node0 else { return nil }
        while let next = node.next { node = next }
        return node
    }
    
    var count: Int {
        guard var node = node0 else { return 0 }
        var counter = 1
        while let next = node.next {
            counter += 1
            node = next
        }
        return counter
    }
    func add(_ value: T) {
        let new = Node(value)
        if let ex = last {
            new.prev = ex
            ex.next = new
        } else {
            node0 = new
        }
    }
    
    func insert(_ value: T) {
        if node0?.key == nil {
            node0?.key = value
      } else {
        var ex = node0
            while ex?.next != nil {
            ex = ex?.next!
        }
        let new = Node(value)
        new.key = value
        ex?.next = new
      }
    }
    
    func search(_ query: T?) -> Bool {
        while node0 != nil {
            if node0?.key == query {
                return true
            }
            node0 = node0?.next
        }
        return false
    }
}

let list = LinkedList<String>()
list.add("q")       // ⟵┐
list.count          // 1 │
list.add("w")       //   │
list.count          // 2 │
list.add("e")       //   │
list.add("r")       //   │  //  ⟵┐
list.first?.key     // q ┘  //    │
list.add("t")               //    │
list.insert("x")            //    │
list.add("y")       // ⇠┐   //    │
list.last?.key      //  ┘   //    │
list.show                   //    │
list.search("r")            // ---┘

//MARK: -- 2) Реализуйте класс для бинарного дерева поиска, работающее только со строками. Сделайте в нем функцию поиска.

//MARK: -- Бинарное дерево - это рекурсивная структура данных, где каждая последующая ветка от начала отсчета(N) хранит значения таким образом, что элемент, хранящийся в левом поддереве N, меньше или равен N, а элементы, хранящиеся в правом поддереве N , больше или равны N. При этом дочерние элементы родителя ничего не знаю о родителе своего родителя
// (т.е. значения после 3 ничего не знаю о 8)
// * * * * * * * * * * * * * * * * * * * *
//MARK:          [8]
//MARK:         /   \
//MARK:      [3]     [10]
//MARK:     /   \        \
//MARK:  [1]     [6]      [14]
//MARK:         /   \         \
//MARK:      [4]     [7]       [20]
//MARK:                       /    \
//MARK:                   [18]      [25]
// * * * * * * * * * * * * * * * * * * * *

class BinaryTree<String> {
    
    var head: String        //MARK:        [head]
    var left: BinaryTree?   //MARK:        /    \
    var right: BinaryTree?  //MARK:   [left]    [right]
    
    init(value: String,
         left: BinaryTree? = nil,
         right: BinaryTree? = nil) {
         self.head = value
         self.left = left
         self.right = right
    }
}
class BinaryTreeString<String: Comparable & CustomStringConvertible> {
    
    var searchPath: [String] = []

    var head: BinaryTree<String>?
    
    func node(_ value: String) {
        let node = BinaryTree(value: value)
        if let head = self.head {
            self.nextNode(head, node)
        } else {
            self.head = node
        }
    }
    
    func nextNode(_ value: BinaryTree<String>, _ node: BinaryTree<String>) {
        if value.head > node.head {
            if let left = value.left {
                self.nextNode(left, node)
            } else {
                value.left = node
            }
        } else {
            if let right = value.right {
                self.nextNode(right, node)
            } else {
                value.right = node
            }
        }
    }
}
extension BinaryTreeString {
// Если задано дерево с различными элементами, прямой или обратный обход вместе с центрированным обходом достаточны для описания дерева
    func traversal() {
        print("\nПрямой (preorder) обход дерева [ корень -> левый узел -> правый узел ]")
        self.preorder(self.head); print("|| F, B, A, D, C, E, G, I, H. -> bit.ly/2TMSs6t")
        print("\nЦентрированный или симметричный (inorder) обход дерева [A,B->...Z] [ левый узел -> корень -> правый узел ]")
        self.inorder(self.head); print("|| A, B, C, D, E, F, G, H, I. -> bit.ly/2X6coU0")
        print("\nОбратный (posnodeBrder) обход дерева [ левый узел -> правый узел -> корень ]")
        self.posorder(self.head); print("|| A, C, E, D, B, H, I, G, F. -> bit.ly/3ccck9o")
        print() // \n
    }

    //MARK: Прямой обход (NLR): [ корень -> левый узел -> правый узел ]
    func preorder(_ root: BinaryTree<String>?) {
        guard let _ = root else { return }
        if root.debugDescription != "nil" { // Проверяю, не является ли текущий узел пустым или nil
            print("\(root!.head)", terminator: " ") // Вывод данных корня (или текущего узла)
            self.preorder(root?.left) // Обходим левое поддерево рекурсивно, вызвав функцию прямого обхода
            self.preorder(root?.right) // Обходим правое поддерево рекурсивно, вызвав функцию прямого обхода
        }
    }
    
    //MARK: Центрированный или симметричный обход (LNR): [ левый узел -> корень -> правый узел ]
    func inorder(_ root: BinaryTree<String>?) {
        if root.debugDescription != "nil" { // Проверяю, не является ли текущий узел пустым или nil
            self.inorder(root?.left) // Обходим левое поддерево рекурсивно, вызвав функцию центрированного обхода
            print("\(root!.head)", terminator: " ") // Вывод данных корня (или текущего узла)
            self.inorder(root?.right) // Обходим правое поддерево рекурсивно, вызвав функцию центрированного обхода
            //MARK: P.S. В двоичном дереве поиска центрированный обход извлекает данные в отсортированном порядке
        }
    }
    
    //MARK: Обратный обход (LRN): [ левый узел -> правый узел -> корень ]
    func posorder(_ root: BinaryTree<String>?) {
        if root.debugDescription != "nil" { // Проверяю, не является ли текущий узел пустым или nil
        self.posorder(root?.left) // Обходим левое поддерево рекурсивно, вызвав функцию обратного обхода
        self.posorder(root?.right) // Обходим правое поддерево рекурсивно, вызвав функцию обратного обхода
        print("\(root!.head)", terminator: " ") // Вывод данных корня (или текущего узла)
        }
    }
}
extension BinaryTreeString {

    func search(_ query: String) {
        self.finder(self.head, query)
    }
    
    private func finder(_ head: BinaryTree<String>?, _ query: String) {
        
        guard let root = head else {
            print("x x x Узел '\(query)' НЕ НАЙДЕН! x x x") // NOT FOUND
            return
        }
        
        self.searchPath.append(root.head)
        print("\(self.searchPath) узел '\(root.head)' -> Ищу: '\(query)'")
        
        if query > root.head {
            self.finder(root.right, query)
        } else if query < root.head {
            self.finder(root.left, query)
        } else {
            print("= = = Узел '\(root.head)' найден = = =\n") // SUCCESS
            self.searchPath.removeAll()
        }
    }
}
let tree = BinaryTreeString<String>()

tree.node("F")
tree.node("B")
tree.node("A")
tree.node("D")
tree.node("C")
tree.node("E")
tree.node("G")
tree.node("I")
tree.node("H")
tree.traversal()

// * * * * * * * * * * * * * * * * * * * *
//MARK:          [F]
//MARK:         /   \
//MARK:      [B]     [G]
//MARK:     /   \       \
//MARK:   [A]   [D]      [I]
//MARK:        /   \     /
//MARK:      [C]   [E] [H]
// * * * * * * * * * * * * * * * * * * * *

tree.search("C")

// * * * * * * * * * * * * * * * * * * * *
//MARK:    С >? [F]    // поиск по алфавиту
//MARK:       //   \
//MARK: С >? [B]    [G]
//MARK:     /  \\      \
//MARK:  [A] С>?[D]     [I]
//MARK:        //  \    /
//MARK:  win! [C]  [E] [H]
// * * * * * * * * * * * * * * * * * * * *

tree.search("N")

// * * * * * * * * * * * * * * * * * * * *
//MARK:    N >? [F]    // поиск по алфавиту
//MARK:        /   \\
//MARK:      [B]  N >?[G]
//MARK:     /   \       \\
//MARK:  [A]    [D]   N >?[I]
//MARK:        /   \      / \\
//MARK:     [C]    [E]  [H]   [fail] node = nil
// * * * * * * * * * * * * * * * * * * * *

//MARK: Материал с урока
/*
        class TreeNode<T,U> {
            var value: T?
             
            var left: TreeNode<T,U>?
            var right: TreeNode<T,U>?
             
            init(value: T) {
                self.value = value
            }
        }

        let nodeBp = TreeNode(value: 8)
        let left = TreeNode(value: 3)
        let rigth = TreeNode(value: 10)
        nodeBp.left = left
        nodeBp.right = rigth
*/

//MARK: -- Реализуйте класс для графа со станциями метро, где ребра хранят в себе длительность переезда между двумя станциями. Сделайте в нем поиск пути (любым способом) с одной станции на другую.

// MARK: Вот материал из урока и задача ^
/*
class Edge<T, U> {
    var value: U
    var node: Node<T,U>
    
    init(value: U, node: Node<T,U>) {
        self.value = value
        self.node = node
    }
}
class Node<T, U> {
    var value: T
    var edges: [Edge<T,U>]
    
    init(value: T, edges: [Edge<T,U>]) {
        self.value = value
        self.edges = edges
    }
}
*/

//MARK: -- Алгоритм Дейкстры | Dijkstra's algorithm

class DijkstraNode<T: Equatable & Hashable>: Equatable, Hashable {
    var value: T
    var edges: [DijkstraEdge<T>] = []
    var visited: Bool = false
    var weight: Double = Double(Int.max) // расстояние до узла (по умолчанию: прибл. бесконечность)
    var prev: DijkstraNode<T>? // предыдущий(previous) узел

    init(_ value: T) { self.value = value }
    
    var hashValue: Int { get { self.value.hashValue } }
    func hash(into hasher: inout Hasher) { }
}

func == <T: Equatable> (lhs: DijkstraNode<T>, rhs: DijkstraNode<T>) -> Bool {
    guard lhs.value == rhs.value else { return false }
    return true
}

class DijkstraEdge<T: Equatable & Hashable>: Equatable, Hashable {
    var from: DijkstraNode<T>
    var to: DijkstraNode<T>
    var timeStr: String?
    var weight: Double
  
    //MARK: [A] <- - weight - -> [B]
    init(from: DijkstraNode<T>, to: DijkstraNode<T>, weight: Double) {
        self.weight = weight
        self.from = from
        self.to = to
        from.edges.append(self)
        self.timeStr = traveltime(weight)
    }

    var hashValue: Int {
        get { "\(self.from.value) -> \(self.to.value)".hashValue }
    }
    func hash(into hasher: inout Hasher) { }
}

func == <T: Equatable> (lhs: DijkstraEdge<T>, rhs: DijkstraEdge<T>) -> Bool {
    guard lhs.from.value == rhs.from.value else { return false }
    guard lhs.to.value == rhs.to.value else { return false }
    return true
}

class DijkstraGraph<T: Hashable & Equatable> {
    var nodes: [DijkstraNode<T>]
    
    init(nodes: [DijkstraNode<T>]) { self.nodes = nodes }
  
    static func path(graph: DijkstraGraph<T>, from: DijkstraNode<T>, to: DijkstraNode<T>) {

        var unvisited = Set<DijkstraNode<T>>(graph.nodes) // Сет для не посещенных узлов
        
        from.weight = 0.0 // Указать, что узел будет началом/нулевой километр/froming point
        
        // Назначить точкой отсчета
        var current: DijkstraNode<T> = from
        
        // Вычислить расстояние до самого последнего узла
        while (to.visited == false) {
          
        for edge in current.edges.filter({ edge -> Bool in
            return edge.to.visited == false
          }) {
            // Предположительное расстояние между текущим узлом и его соседом
            let tempDist = current.weight + edge.weight
                    
            if edge.to.weight > tempDist {
               edge.to.weight = tempDist
               edge.to.prev = current
            }
          }
          
          current.visited = true // Помечаю, что узел посещен
          
          unvisited.remove(current) // Удаляю узел из непосещенных узлов
          
          if let new = unvisited.sorted(by: { (A, B) -> Bool in
            A.weight < B.weight
          }).first {
            current = new
          } else { break }
        }
        DijkstraGraph.printPath(node: to)
  }
  
    static func printPath(node: DijkstraNode<T>) {
        if let previous = node.prev {
            DijkstraGraph.printPath(node: previous)
        } else {
            print("\nПоиск пути по алгоритму Дейкстры:")
        }
        print("\(node.prev?.value == nil ? "" : "-> ")«\(node.value)» [\(traveltime(node.weight))]", terminator: " ")
    }
}
///Date(timeIntervalSinceNow:(value * 60.0))
func traveltime(_ value: Double) -> String {
    let date = Date(timeIntervalSinceNow:(value * 60.0)) // value * 60min
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    dateFormatter.locale = Locale(identifier: "gb_GB") // "gb_GB" == hide AM/PM
    return dateFormatter.string(from: date)
}

//MARK: Названия узлов (станций)
let nodeA = DijkstraNode("A")
let nodeB = DijkstraNode("B")
let nodeC = DijkstraNode("C")
let nodeD = DijkstraNode("D")
let nodeE = DijkstraNode("E")

//MARK: Взаимосвязь узлов и расстояние(вес) между ними
let edgeAB = DijkstraEdge(from: nodeA, to: nodeB, weight: 3) //MARK: [A]< 1 >[C]<-----╮
let edgeBA = DijkstraEdge(from: nodeB, to: nodeA, weight: 3) //MARK:   \      ^       |
let edgeAC = DijkstraEdge(from: nodeA, to: nodeC, weight: 1) //MARK:    3     1       |
let edgeCA = DijkstraEdge(from: nodeC, to: nodeA, weight: 1) //MARK:     \    v       |
let edgeBC = DijkstraEdge(from: nodeB, to: nodeC, weight: 1) //MARK:      -->[B]      8
let edgeCB = DijkstraEdge(from: nodeC, to: nodeB, weight: 1) //MARK:          ^       |
let edgeBD = DijkstraEdge(from: nodeB, to: nodeD, weight: 2) //MARK:          2       |
let edgeDB = DijkstraEdge(from: nodeD, to: nodeB, weight: 2) //MARK:          v       v
let edgeDE = DijkstraEdge(from: nodeD, to: nodeE, weight: 1) //MARK:         [D]< 1 >[E]
let edgeED = DijkstraEdge(from: nodeE, to: nodeD, weight: 1) //MARK:
let edgeCE = DijkstraEdge(from: nodeC, to: nodeE, weight: 8) //MARK: Искусство маленьких шагов :)
let edgeEC = DijkstraEdge(from: nodeE, to: nodeC, weight: 8) //MARK:

let graph = DijkstraGraph(nodes: [nodeA, nodeB, nodeC, nodeD, nodeE]) //MARK: Создаю "карту" нодов
DijkstraGraph.path(graph: graph, from: nodeA, to: nodeE) //MARK: Рассчитать путь

//MARK: -- Алгоритм поиска в ширину | Breadth-first search | BFS | Breadth First Search

class BFSNode<T> {
    let current: T
    var neighbor: BFSNode<T>?
    
    init(_ current: T, neighbor: BFSNode<T>? = nil ) {
        self.current = current
        self.neighbor = neighbor
    }
}

class BFSQueue<T> { //MARK: == Linked List
    
    var current: BFSNode<T>?
    
    var last: BFSNode<T>? {
        if var node = self.current {
            while let next = node.neighbor { node = next }
            return node
        } else {
            return nil
        }
    }
    
    var count: Int {
        if var node = self.current {
            var count: Int = 1
            while let next = node.neighbor {
                count += 1
                node = next
            }
            return count
        } else {
            return 0
        }
    }
    
    var isEmpty: Bool { self.current == nil }
        
    func append(_ node: T) {
        let node = BFSNode<T>(node)
        if let prev = last {
            prev.neighbor = node
        } else {
            self.current = node
        }
    }
    
    func removeFirst() -> T? {
        let first = self.current
        self.current = self.current?.neighbor
        return first?.current
    }
}

struct Node<T>: CustomStringConvertible, Hashable where T: Hashable {
    let value: T
    let index: Int
    var description: String { "\(self.value)" }
}

struct QueueBFS<T> {
    var queue = BFSQueue<T>()
    var isEmpty: Bool { self.queue.isEmpty }
    mutating func enqueue(_ node: T) { self.queue.append(node) }
    mutating func dequeue() -> T? { self.queue.removeFirst() }
}

struct BFSEdge<T>: CustomStringConvertible, Hashable where T: Hashable {
    let from: Node<T> // --╮
                     //    |<-╮
    let to: Node<T> // <---╯  | weight
    let weight: Double? // ---╯
    let time: String // ---╯ Date(timeIntervalSinceNow:(weight * 60.0)) // weight * 60min
    
    var description: String { "«\(self.from)» -[\(self.time)]-> «\(self.to)»" }
}

class EdgeList<T> where T: Hashable {
    let node: Node<T>
    var edges: [BFSEdge<T>] = []
    
    init(_ node: Node<T>) {
        self.node = node
    }
    
    func append(_ edge: BFSEdge<T>) {
        self.edges.append(edge)
    }
}

protocol BFSGraph {
    associatedtype Element: Hashable
    func edgesFrom(_ : Node<Element>) -> [BFSEdge<Element>]
}
enum Visited<Element: Hashable> {
    case node
    case edge(BFSEdge<Element>)
}

class BFS<T> where T: Hashable {
    
    var edgeList: [EdgeList<T>] = []
    private var effort = 0.0 // энергозатратность <---------------╮
                             //                                   |
    func directed(from: Node<T>, to: Node<T>, weight: Double?){ //|
        if from.index < edgeList.count {                        //|
            self.effort += weight! // <---------------------------╯
            let edge = BFSEdge<T>(from: from, to: to, weight: weight, time: traveltime(effort))
            self.edgeList[from.index].append(edge)
        } else {
            return
        }
    }
    
    func undirected(nodes: (Node<T>, Node<T>), weight: Double?) {
        let (from, to) = nodes
        if from.index < edgeList.count && to.index < edgeList.count {
            self.directed(from: from, to: to, weight: weight)
            self.directed(from: to, to: from, weight: weight)
        } else {
            return
        }
    }

    func breadthFirstSearch(from: Node<Element>, to: Node<Element>) -> [BFSEdge<Element>] {
        
        var queue: QueueBFS<Node<Element>> = QueueBFS()
        queue.enqueue(from)
        
        var visits: [Node<Element>: Visited<Element>] = [from: .node]
        
        while let visited = queue.dequeue() {
            if visited == to {
                var route: [BFSEdge<Element>] = []
                var node = to
                while let visit = visits[node],
                    case .edge(let edge) = visit {
                          route = [edge] + route
                          node = edge.from
                    }
                return route
            }
            let neightbourEdges = edgesFrom(visited)
            
            for edge in neightbourEdges {
                if visits[edge.to] == nil {
                   queue.enqueue(edge.to)
                   visits[edge.to] = .edge(edge)
                }
            }
        }
        return []
    }
}

extension BFS: BFSGraph {
    
    func node(_ value: T) -> Node<T> {
        
        let nodes = edgeList.filter {
            $0.node.value == value
        }
        
        if nodes.count == 0 {
            let node = Node<T>(value: value, index: edgeList.count)
            let newEdge = EdgeList<T>(node)
            self.edgeList.append(newEdge)
            return node
        } else {
            return nodes.last!.node
        }
    }
    
    func edge(from: Node<T>, to: Node<T>, weight: Double?) {
        undirected(nodes: (from, to), weight: weight)
    }
    
    func edgesFrom(_ node: Node<T>) -> [BFSEdge<T>] {
        if node.index < edgeList.count {
            return self.edgeList[node.index].edges
        } else {
            return []
        }
    }
}

let BFSgraph = BFS<String>()
var BFS_A = BFSgraph.node("A")
var BFS_B = BFSgraph.node("B")
var BFS_C = BFSgraph.node("C")
var BFS_D = BFSgraph.node("D")
var BFS_E = BFSgraph.node("E")

BFSgraph.edge(from: BFS_A, to: BFS_B, weight: 3) //MARK:   (6)----→[A]←(3)→[B]
BFSgraph.edge(from: BFS_A, to: BFS_C, weight: 5) //MARK:    |       ↑
BFSgraph.edge(from: BFS_C, to: BFS_D, weight: 1) //MARK:    |      (5)
BFSgraph.edge(from: BFS_A, to: BFS_D, weight: 6) //MARK:    ↓       ↓
BFSgraph.edge(from: BFS_C, to: BFS_E, weight: 1) //MARK:   [D]←(1)→[C]←(1)→[E]

print("\n\nПоиск в ширину (BFS):")
print(BFSgraph.breadthFirstSearch(from: BFS_B, to: BFS_E))

//MARK: -- Поиск в глубину | Depth-first search | DFS | Depth First Search

struct DFSNode<T: Hashable>: Hashable, CustomStringConvertible {
    var value: T
    var weight: Double
    var time: String
    var description: String { "\(self.value) \(self.time)" }
}

class DFS<T: Hashable>: DFSGraph {
  
    var edgesDict: [DFSNode<T>: [DFSEdge<T>]] = [:]
    
    func directed(from: DFSNode<T>, to: DFSNode<T>, weight: Double?) {
        let edge = DFSEdge(from: from, to: to, weight: weight)
        self.edgesDict[from]?.append(edge)
    }
    
    func undirected(nodes: (DFSNode<T>, DFSNode<T>), weight: Double?) {
        let (from, to) = nodes
        self.directed(from: from, to: to, weight: weight)
        self.directed(from: to, to: from, weight: weight)
    }
  
    func node(_ value: T, weight: Double) -> DFSNode<T> {
        let node = DFSNode(value: value, weight: weight, time: traveltime(Double(self.edgesDict.count) + weight))

        if self.edgesDict[node] == nil {
            self.edgesDict[node] = []
        }
        return node
    }
  
    func edge(from: DFSNode<T>, to: DFSNode<T>, weight: Double? = 0) {
        undirected(nodes: (from, to), weight: weight)
    }
  
    func weight(from: DFSNode<T>, to: DFSNode<T>) -> Double? {
        guard let edges = self.edgesDict[from] else { return nil }
        for edge in edges {
            if edge.to == to {
                edge.weight
            }
        }
        return nil
    }

    func edges(from: DFSNode<T>) -> [DFSEdge<T>]? {
        return self.edgesDict[from]
    }
}

struct DFSEdge<T: Hashable> {
    var from: DFSNode<T>
    var to: DFSNode<T>
    let weight: Double?
}

protocol DFSGraph {
    associatedtype Element: Hashable
  
    func node(_ data: Element, weight: Double) -> DFSNode<Element>
    func edge(from: DFSNode<Element>, to: DFSNode<Element>, weight: Double?)
    func weight(from: DFSNode<Element>, to: DFSNode<Element>) -> Double?
    func edges(from: DFSNode<Element>) -> [DFSEdge<Element>]?
}

struct DFSReturn<T>: CustomStringConvertible {
    var array: [T] = []
    mutating func push(_ element: T) { self.array.append(element) }
    mutating func peek() -> T? { self.array.last }
    mutating func pop() -> T? { self.array.popLast() }
    
    var description: String {
        let top = "-----------\n"
        let bottom = "\n-----------\n"
        return top + self.array.map{"\($0)"}.joined(separator: "\n") + bottom
    }
}

func depthFirstSearch(graph: DFS<String>, from: DFSNode<String>, to: DFSNode<String>) -> DFSReturn<DFSNode<String>> {
    var visited = Set<DFSNode<String>>()
    var output = DFSReturn<DFSNode<String>>()
    
    output.push(from)
    visited.insert(from)
  
    while let node = output.peek(), node != to {
        guard let neighbours = graph.edges(from: node), neighbours.count > 0 else {
            continue
    }
    
    for edge in neighbours {
        if !visited.contains(edge.to) {
            visited.insert(edge.to)
            output.push(edge.to)
            print(output.description)
                if output.array.last == to {
                    print("Приехали! Finish!")
                    break
                }
            break
          }
    }
  }
  return output
}

let DFSgraph = DFS<String>()
let DFS_S = DFSgraph.node("S", weight: 1)
let DFS_A = DFSgraph.node("A", weight: 2)
let DFS_B = DFSgraph.node("B", weight: 3)
let DFS_C = DFSgraph.node("C", weight: 4)
let DFS_D = DFSgraph.node("D", weight: 5)
let DFS_F = DFSgraph.node("F", weight: 6)
let DFS_G = DFSgraph.node("G", weight: 7)
let DFS_E = DFSgraph.node("E", weight: 8)

DFSgraph.edge(from: DFS_S, to: DFS_A) //MARK:           [S]
DFSgraph.edge(from: DFS_A, to: DFS_B) //MARK:            |
DFSgraph.edge(from: DFS_A, to: DFS_D) //MARK:        ╭--[A]--╮
DFSgraph.edge(from: DFS_A, to: DFS_C) //MARK:       [B]  |  [C]
DFSgraph.edge(from: DFS_B, to: DFS_D) //MARK:        ╰--[D]
DFSgraph.edge(from: DFS_D, to: DFS_G) //MARK:          / |
DFSgraph.edge(from: DFS_D, to: DFS_F) //MARK:       [G] [F]
DFSgraph.edge(from: DFS_F, to: DFS_E) //MARK:            |
                                      //MARK:           [E]
print("\n\nПоиск в глубину (DFS):")
depthFirstSearch(graph: DFSgraph, from: DFS_S, to: DFS_G)

//MARK: -- Алгоритм A* | AStar | A*

protocol AStarGraph {
    associatedtype Element: Hashable
    
    func node(_ value: Element) -> AStarNode<Element>
    func edge(from: AStarNode<Element>, to: AStarNode<Element>, weight: Double?)
    func edges(from: AStarNode<Element>) -> [AStarEdge<Element>]?
}

class AStar<T: Hashable>: AStarGraph {

    var edgesDict: [AStarNode<T>: [AStarEdge<T>]] = [:]
    var effort = 0.0
    
    func directed(from: AStarNode<T>, to: AStarNode<T>, weight: Double?) {
        let edge = AStarEdge(from: from, to: to, weight: weight)
        self.edgesDict[from]?.append(edge)
        self.effort = Double(edgesDict.count)
    }
    
    func undirected(nodes: (AStarNode<T>, AStarNode<T>), weight: Double?) {
        let (from, to) = nodes
        self.directed(from: from, to: to, weight: weight)
        self.directed(from: to, to: from, weight: weight)
    }
    
    func node(_ value: T) -> AStarNode<T> {
        let node = AStarNode(value: value)
        
        if self.edgesDict[node] == nil {
            self.edgesDict[node] = []
        }
        return node
    }
    
    func edge(from: AStarNode<T>, to: AStarNode<T>, weight: Double?) {
        self.undirected(nodes: (from, to), weight: weight)
    }

    func edges(from: AStarNode<T>) -> [AStarEdge<T>]? {
        return self.edgesDict[from]
    }
}

struct AStarEdge<T: Hashable>: Hashable {
    var from: AStarNode<T>
    var to: AStarNode<T>
    let weight: Double?

// extension
    var hashValue: Int {
        "\(self.from)\(self.to)\(self.weight ?? 0)".hashValue
    }
    static func ==(lhs: AStarEdge<T>, rhs: AStarEdge<T>) -> Bool {
        lhs.self.from == rhs.self.from &&
        lhs.self.to == rhs.self.to &&
        lhs.self.weight == rhs.self.weight
    }
    func hash(into hasher: inout Hasher) { }
}

struct AStarNode<T: Hashable> : Hashable, CustomStringConvertible {
    var value: T

// extension
    var hashValue: Int { "\(self.value)".hashValue }
    static func ==(lhs: AStarNode, rhs: AStarNode) -> Bool {
        lhs.self.value == rhs.self.value
    }
    func hash(into hasher: inout Hasher) { }
    var description: String {
        return "\(self.value)" + " \(traveltime(1.0))"
    }
}

func aStarSearch<T>(from: AStarNode<T>, to: AStarNode<T>, graph: AStar<T>, heuristic: [T:Double]) {
    print("\nПоиск алгоритмом A* (AStar)")
    let path = aStar(from: from, to: to, graph: graph, heuristic: heuristic)
    print(path)
}

func aStar<T>(from: AStarNode<T>, to: AStarNode<T>, graph: AStar<T>, heuristic: [T:Double]) -> DFSReturn<AStarNode<T>> {
    var visited = Set<AStarNode<T>>()
    var stack = DFSReturn<AStarNode<T>>()
    
    visited.insert(from)
    stack.push(from)
        
    while let node = stack.peek(), node != to {
        guard let neighbours = graph.edges(from: node), neighbours.count > 0 else {
            continue //break
        }
        
        var edges = [(node: AStarNode<T>, f: Double)]()
        
        for edge in neighbours {
            let current = edge.to
            if !visited.contains(current) {
                visited.insert(current)
                edges.append((node: current, f: funcAStar(g: edge.weight, h: heuristic[current.value])))
            }
        }
        if let minF = edges.sorted(by: {$0.f < $1.f}).first {
            stack.push(minF.node)
        }
    }
    return stack
}

// g — стоимость пути от начальной вершины, а не от предыдущей, как в жадном алгоритме.
func funcAStar(g: Double?, h: Double?) -> Double {
    return (g ?? 0) + (h ?? 0)
}

var heuristicTable: [String: Double] {
    return ["A": 366,
            "B": 253,
            "C": 74,
            "D": 380,
            "E": 178,
            "F": 0,
            "G": 98,
            "H": 160,
            "I": 193]
}

let astar = AStar<String>()
let AStar_A = astar.node("A")
let AStar_B = astar.node("B")
let AStar_C = astar.node("C")
let AStar_D = astar.node("D")
let AStar_E = astar.node("E")
let AStar_F = astar.node("F") // <--
let AStar_G = astar.node("G")
let AStar_H = astar.node("H")
let AStar_I = astar.node("I")

astar.edge(from: AStar_A, to: AStar_C, weight: 75)
astar.edge(from: AStar_C, to: AStar_D, weight: 71)
astar.edge(from: AStar_D, to: AStar_B, weight: 151)
astar.edge(from: AStar_D, to: AStar_E, weight: 100)
astar.edge(from: AStar_A, to: AStar_B, weight: 140)
astar.edge(from: AStar_B, to: AStar_E, weight: 99)
astar.edge(from: AStar_B, to: AStar_I, weight: 80)
astar.edge(from: AStar_I, to: AStar_G, weight: 97)
astar.edge(from: AStar_H, to: AStar_I, weight: 146)
astar.edge(from: AStar_H, to: AStar_G, weight: 138)
astar.edge(from: AStar_G, to: AStar_F, weight: 101)
astar.edge(from: AStar_E, to: AStar_F, weight: 211)

aStarSearch(from: AStar_A, to: AStar_F, graph: astar, heuristic: heuristicTable)

// MARK: -- Реализуйте функцию сортировки массива еще двумя способами, кроме рассказанных на уроке.

// MARK: Материал с урока
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
[0,7,5,3,9,10].bubbleSort() // [0, 3, 5, 7, 9, 10]
[1,0,8,7,5,3,9,10,19].selectionSort() // [0, 1, 3, 5, 7, 8, 9, 10, 19]

//MARK: Еще примеры

extension Array where Element: Comparable {
    func insertionSort() -> [Element] {
        var array = self
        for x in 1..<array.count {
            var y = x
            while y > 0 && array[y] < array[y - 1] {
                array.swapAt(y - 1, y)
                y -= 1
            }
        }
        return array
    }
}

let array = [1,0,8,7,5,3,9,10,19].insertionSort()

func BucketSort(list: inout [Int], max: Int) {
    var count = Array<Bool>(repeating: false, count: max + 1)
    
    for i in list { count[i] = true }
    
    var index = 0
    for i in count.indices {
        if count[i] {
            list[index] = i
            index += 1
        }
    }
}
var BS = [7,1,9,5,2,0]
BucketSort(list: &BS, max: BS.max()!) // [0, 1, 2, 5, 7, 9]

func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
  guard array.count > 1 else { return array }
  let midIndex = array.count / 2
  let leftArr = mergeSort(Array(array[0..<midIndex]))
  let rightArr = mergeSort(Array(array[midIndex..<array.count]))
  return merge(lPile: leftArr, rPile: rightArr)
}
func merge<T: Comparable>(lPile: [T], rPile: [T]) -> [T] {
  var lIndex = 0
  var rIndex = 0
  var ordered = [T]()
  if ordered.capacity < lPile.count + rPile.count {
    ordered.reserveCapacity(lPile.count + rPile.count)
  }

  while true {
    guard lIndex < lPile.endIndex else {
      ordered.append(contentsOf: rPile[rIndex..<rPile.endIndex])
      break
    }
    guard rIndex < rPile.endIndex else {
      ordered.append(contentsOf: lPile[lIndex..<lPile.endIndex])
      break
    }
    
    if lPile[lIndex] < rPile[rIndex] {
      ordered.append(lPile[lIndex])
      lIndex += 1
    } else {
      ordered.append(rPile[rIndex])
      rIndex += 1
    }
  }
  return ordered
}

let array1 = [2, 1, 5, 4, 3]
let sortedArray = mergeSort(array1) // [1, 2, 3, 4, 5]
let array2 = ["D", "E", "A", "C", "B"]
let sortedArray2 = mergeSort(array2) // ["A", "B", "C", "D", "E"]
