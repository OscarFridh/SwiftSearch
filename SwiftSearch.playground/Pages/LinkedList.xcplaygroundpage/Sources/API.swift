import Foundation
import SpriteKit

// MARK: API

public class View: SKView {
    let target: String
    let searchAlgorithm: (String, Node) -> Node?
    public init(target: String, searchAlgorithm: @escaping (String, Node) -> Node?, speed: Double = 1) {
        self.target = target
        self.searchAlgorithm = searchAlgorithm
        super.init(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
        showsFPS = true
        showsNodeCount = true
        let level = createLevel(target: target)
        let searchResult = level.search(using: searchAlgorithm)
        let scene = Scene.create(graph: level.graph, searchResult: searchResult)
        scene.speed = CGFloat(speed)
        presentScene(scene)
    }
    
    private func createLevel(target: String) -> Level {
        let graph = Graph(nodes: [
            .init(id: "a", value: "🙋🏻‍♂️", neighbors: ["b"]),
            .init(id: "b", value: "🤖", neighbors: ["c"]),
            .init(id: "c", value: "🐒", neighbors: []),
        ])
        return Level(graph: graph, start: "a", targetValue: target, correctSearch: correctSearch)
    }
    
    func correctSearch(for target: String, in node: Node) -> Node? {
        if node.value == target {
            return node
        } else if let neighbor = node.neighbors.first {
            return correctSearch(for: target, in: neighbor)
        } else {
            return nil
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Convenience for level 1 & 3
public extension Node {
    var neighbor: Node? {
        neighbors.first
    }
}
