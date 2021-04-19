import Foundation
import SpriteKit

extension View {
    
    static let graph = Graph(nodes: [
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
    
    public static func create(target: String, searchAlgorithm: SearchAlgorithm, speed: Double) -> UIView {
        let level = Level(graph: graph, targetValue: target)
        let searchResult = level.search(using: searchAlgorithm)
        print(searchResult.path)
        return View.create(graph: level.graph, searchResult: searchResult, speed: speed)
    }
}
