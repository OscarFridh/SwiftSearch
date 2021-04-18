import Foundation
import SpriteKit

public class View: SKView {
    let target: String
    let searchAlgorithm: Level.SearchAlgorithm!
    public init(target: String, searchAlgorithm: @escaping Level.SearchAlgorithm, speed: Double = 1) {
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
            .init(id: "a", value: "A", neighbors: ["b", "d"]),
            .init(id: "b", value: "B", neighbors: ["c"]),
            .init(id: "c", value: "C", neighbors: []),
            .init(id: "d", value: "D", neighbors: ["e", "f"]),
            .init(id: "e", value: "E", neighbors: []),
            .init(id: "f", value: "F", neighbors: []),
        ])
        return Level(graph: graph, start: "a", targetValue: target, correctSearch: correctPath)
    }
    
    func correctPath(to target: String, from node: Node) -> [Node] {
        if node.value == target {
            return [node]
        } else {
            for neighbor in node.neighbors {
                let path = correctPath(to: target, from: neighbor)
                if path.count > 0 {
                    return [node] + path
                }
            }
        }
        return []
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
