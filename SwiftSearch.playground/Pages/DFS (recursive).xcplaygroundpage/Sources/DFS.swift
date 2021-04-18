import Foundation
import SpriteKit

extension View {
    
    static let graph = Graph(nodes: [
        .init(id: "a", value: "A", neighbors: ["b", "d"]),
        .init(id: "b", value: "B", neighbors: ["c"]),
        .init(id: "c", value: "C", neighbors: []),
        .init(id: "d", value: "D", neighbors: ["e", "f"]),
        .init(id: "e", value: "E", neighbors: []),
        .init(id: "f", value: "F", neighbors: ["a"]),
    ])
    
    static func correctPath(to target: String, from node: Node) -> [Node] {
        node.visited = true
        if node.value == target {
            return [node]
        }
        for neighbor in node.neighbors {
            if !neighbor.visited {
                let path = correctPath(to: target, from: neighbor)
                if path.count > 0 {
                    return [node] + path
                }
            }
        }
        return []
    }
    
    public static func create(target: String, searchAlgorithm: SearchAlgorithm, speed: Double) -> UIView {
        let level = Level(graph: graph, targetValue: target, correctSearch: correctPath)
        let searchResult = level.search(using: searchAlgorithm)
        return View.create(graph: level.graph, searchResult: searchResult, speed: speed)
    }
}
