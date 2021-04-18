import Foundation
import SpriteKit

extension View {
    
    static let graph = Graph(nodes: [
        .init(id: "a", value: "🙋🏻‍♂️", neighbors: ["b"]),
        .init(id: "b", value: "🤖", neighbors: ["c"]),
        .init(id: "c", value: "🐒", neighbors: []),
    ])
    
    public static func create(target: String, searchAlgorithm: SearchAlgorithm, speed: Double) -> UIView {
        let level = Level(graph: graph, targetValue: target)
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
