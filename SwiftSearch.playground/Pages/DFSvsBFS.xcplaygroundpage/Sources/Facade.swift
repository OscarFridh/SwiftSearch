import Foundation
import SpriteKit

extension View {
    
    static let graph = Graph(nodes: [
        .init(id: "a", value: "A", neighbors: ["b"]),
        .init(id: "b", value: "B", neighbors: ["c", "k", "m"]),
        .init(id: "c", value: "C", neighbors: ["d"]),
        .init(id: "d", value: "D", neighbors: ["e"]),
        .init(id: "e", value: "E", neighbors: ["f"]),
        .init(id: "f", value: "F", neighbors: ["g"]),
        .init(id: "g", value: "G", neighbors: ["h"]),
        .init(id: "h", value: "H", neighbors: ["i", "b"]),
        .init(id: "i", value: "I", neighbors: ["j"]),
        .init(id: "j", value: "J", neighbors: ["p"]),
        .init(id: "k", value: "K", neighbors: ["l"]),
        .init(id: "l", value: "L", neighbors: ["f"]),
        .init(id: "m", value: "M", neighbors: ["n"]),
        .init(id: "n", value: "N", neighbors: ["o"]),
        .init(id: "o", value: "O", neighbors: ["j"]),
        .init(id: "p", value: "P", neighbors: ["g"]),
    ])
    
    public static func create(target: String, searchAlgorithm: SearchAlgorithm, speed: Double) -> UIView {
        let level = Level(graph: graph, targetValue: target)
        let searchResult = level.search(using: searchAlgorithm)
        print(searchResult.path)
        return View.create(graph: level.graph, searchResult: searchResult, speed: speed)
    }
}
