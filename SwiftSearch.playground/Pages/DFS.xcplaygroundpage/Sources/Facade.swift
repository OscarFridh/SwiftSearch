import Foundation
import SpriteKit

public extension View {
    static func create(searchResult: SearchResult, speed: Double) -> UIView {
        return View.create(graph: .level, searchResult: searchResult, speed: speed)
    }
}

private extension Graph {
    static let level = Graph(nodes: [
        .init(id: "a", value: "🤖", neighbors: ["b", "e"]),
        .init(id: "b", value: "🙋🏻‍♂️", neighbors: ["c"]),
        .init(id: "c", value: "🕵️", neighbors: ["d"]),
        .init(id: "d", value: "🐒", neighbors: ["b"]),
        .init(id: "e", value: "😍", neighbors: ["f"]),
        .init(id: "f", value: "🏆", neighbors: ["a"]),
    ])
}

public extension Level {
    static func search(for emoji: String, using searchAlgorithm: SearchAlgorithm) -> SearchResult {
        let level = Level(graph: .level, targetValue: emoji)
        return level.search(using: searchAlgorithm)
    }
}
