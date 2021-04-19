import Foundation
import SpriteKit

extension View {
    
    static let graph = Graph(nodes: [
        .init(id: "a", value: "🤖", neighbors: ["b", "d"]),
        .init(id: "b", value: "🙋🏻‍♂️", neighbors: ["c"]),
        .init(id: "c", value: "🕵️", neighbors: []),
        .init(id: "d", value: "🐒", neighbors: ["e", "f"]),
        .init(id: "e", value: "😍", neighbors: []),
        .init(id: "f", value: "🏆", neighbors: ["a"]),
    ])
    
    public static func create(target: String, searchAlgorithm: SearchAlgorithm, speed: Double) -> UIView {
        let level = Level(graph: graph, targetValue: target) // TODO: Skicka in en flagga att göra exakt path validation mot bfs!
        let searchResult = level.search(using: searchAlgorithm)
        return View.create(graph: level.graph, searchResult: searchResult, speed: speed)
    }
}
