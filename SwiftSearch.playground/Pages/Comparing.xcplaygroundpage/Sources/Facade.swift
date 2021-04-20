import Foundation
import SpriteKit

public extension View {
    static func create(searchResult: SearchResult, speed: Double) -> UIView {
        return View.create(graph: .level, searchResult: searchResult, speed: speed)
    }
}

private extension Graph {
    static let level = Graph(nodes: [
        .init(id: "a", value: "🍕", neighbors: ["b", "d", "f"]),
        .init(id: "b", value: "😍", neighbors: ["c"]),
        .init(id: "c", value: "🏆", neighbors: []),
        .init(id: "d", value: "🙋🏻‍♂️", neighbors: ["e"]),
        .init(id: "e", value: "🎸", neighbors: []),
        .init(id: "f", value: "🎹", neighbors: ["g"]),
        .init(id: "g", value: "🏊‍♂️", neighbors: []),
    ])
}

public extension Level {
    static func search(for emoji: String, using searchAlgorithm: SearchAlgorithm) -> SearchResult {
        let level = Level(graph: .level, targetValue: emoji)
        return level.search(using: searchAlgorithm)
    }
    
    static func search(for emoji: String, using searchAlgorithm: Algorithm) -> SearchResult {
        let level = Level(graph: .level, targetValue: emoji)
        let map: [Algorithm: SearchAlgorithm] = [
            .dfs: dfs,
            .bfs: bfs
        ]
        return level.search(using: map[searchAlgorithm]!)
    }
}

public enum Algorithm {
    case dfs
    case bfs
}
