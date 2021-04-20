import Foundation
import SpriteKit

public extension View {
    static func create(searchResult: SearchResult, speed: Double) -> UIView {
        return View.create(graph: .level, searchResult: searchResult, speed: speed)
    }
}

private extension Graph {
    static let level = Graph(nodes: [
        .init(id: "a", value: "👨🏻‍💻", neighbors: ["b"]),
        .init(id: "b", value: "🤖", neighbors: ["c", "k", "m"]),
        .init(id: "c", value: "🍕", neighbors: ["d"]),
        .init(id: "d", value: "😍", neighbors: ["e"]),
        .init(id: "e", value: "🏆", neighbors: ["f"]),
        .init(id: "f", value: "🙋🏻‍♂️", neighbors: ["g"]),
        .init(id: "g", value: "🎸", neighbors: ["h"]),
        .init(id: "h", value: "🎹", neighbors: ["i", "b"]),
        .init(id: "i", value: "🏊‍♂️", neighbors: ["j"]),
        .init(id: "j", value: "🍀", neighbors: ["p"]),
        .init(id: "k", value: "🕵️", neighbors: ["l"]),
        .init(id: "l", value: "🌎", neighbors: ["f"]),
        .init(id: "m", value: "🐒", neighbors: ["n"]),
        .init(id: "n", value: "🏄‍♂️", neighbors: ["o"]),
        .init(id: "o", value: "🏸", neighbors: ["j"]),
        .init(id: "p", value: "🎉", neighbors: ["g"]),
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
