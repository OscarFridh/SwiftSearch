import Foundation
import SpriteKit

extension View {
    
    static let graph = Graph(nodes: [
        .init(id: "a", value: "🙋🏻‍♂️", neighbors: ["b"]),
        .init(id: "b", value: "🤖", neighbors: ["c"]),
        .init(id: "c", value: "🐒", neighbors: ["a"]),
    ])
    
    static func correctPath(to target: String, from node: Node) -> [Node] {
        node.visited = true
        if node.value == target {
            return [node]
        } else if node.neighbor?.visited == false {
            let path = correctPath(to: target, from: node.neighbor!)
            if path.count > 0 {
                return [node] + path
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

// Convenience for level 1 & 3
public extension Node {
    var neighbor: Node? {
        neighbors.first
    }
}
