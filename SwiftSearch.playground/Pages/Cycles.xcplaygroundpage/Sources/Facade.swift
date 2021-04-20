import Foundation
import SpriteKit

public extension View {
    static func create(searchResult: SearchResult, speed: Double) -> UIView {
        return View.create(graph: .level, searchResult: searchResult, speed: speed)
    }
}

// Convenience for level 1 & 3
public extension Node {
    var neighbor: Node? {
        neighbors.first
    }
}

private extension Graph {
    static let level = Graph(nodes: [
        .init(id: "a", value: "🙋🏻‍♂️", neighbors: ["b"]),
        .init(id: "b", value: "🤖", neighbors: ["c"]),
        .init(id: "c", value: "🐒", neighbors: ["a"]),
    ])
}

public extension Level {
    static func search(for emoji: String, using searchAlgorithm: SearchAlgorithm) -> SearchResult {
        let level = Level(graph: .level, targetValue: emoji)
        return level.search(using: searchAlgorithm)
    }
}
