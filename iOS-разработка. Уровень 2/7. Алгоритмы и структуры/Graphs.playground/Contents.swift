import UIKit

class Edge<T, U> {
    var label: U
    var vertex: Vertex<T,U>
    
    init(label: U, vertex: Vertex<T,U>) {
        self.label = label
        self.vertex = vertex
    }
}

class Vertex<T, U> {
    var value: T
    var edges: [Edge<T,U>]
    
    init(value: T, edges: [Edge<T,U>]) {
        self.value = value
        self.edges = edges
    }
}
