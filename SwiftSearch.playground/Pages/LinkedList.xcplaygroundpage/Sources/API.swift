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
        let level = Level1(start: "a", targetValue: target)
        let searchResult = level.search(using: searchAlgorithm)
        let scene = Scene.create(graph: level.graph, searchResult: searchResult)
        scene.speed = CGFloat(speed)
        presentScene(scene)
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


// MARK: Model

// Detta skiljer sig givetvis från bana till bana! (graph, start, correctSearch)
struct Level1 {
    
    typealias SearchAlgorithm = (String, Node) -> Node?
    
    let graph = Graph(nodes: [
        .init(id: "a", value: "🙋🏻‍♂️", neighbors: ["b"]),
        .init(id: "b", value: "🤖", neighbors: ["c"]),
        .init(id: "c", value: "🐒", neighbors: []),
    ])
    
    let start: String
    let targetValue: String
    private var correctNodeId: String?
    
    init(start: String = "a", targetValue: String) {
        self.start = start
        self.targetValue = targetValue
        let (_, nodeId) = search(using: correctSearch)
        self.correctNodeId = nodeId
    }
    

    
    private func correctSearch(for target: String, in node: Node) -> Node? {
        if node.value == target {
            return node
        } else if let neighbor = node.neighbors.first {
            return correctSearch(for: target, in: neighbor)
        } else {
            return nil
        }
    }
    
    func search(using searchAlgorithm: SearchAlgorithm) -> SearchResult {
        let (events, nodeId) = search(using: searchAlgorithm)
        let correct = (nodeId == correctNodeId)
        return SearchResult(searchEvents: events, nodeId: nodeId, correct: correct)
    }
    
    private func search(using searchAlgorithm: SearchAlgorithm) -> (searchEvents: [String], nodeId: String?) {
        var searchEvents = [String]()
        let searchNodes = SearchNode.create(from: graph) { event in
            searchEvents.append(event)
        }
        let node = searchAlgorithm(targetValue, searchNodes[start]!) as? SearchNode
        return (searchEvents, node?.id)
    }
    
    private class SearchNode: Node {
        static func create(from graph: Graph, observer: ((String) -> ())?) -> [String: SearchNode] {
            var searchNodes = [String: SearchNode]()
            for node in graph.nodes.values {
                let searchNode = SearchNode(node: node)
                searchNodes[node.id] = searchNode
                searchNode.observer = observer
            }
            for (source, destinations) in graph.edges {
                searchNodes[source]!.neighbors = destinations.map { searchNodes[$0]! }
            }
            return searchNodes
        }
        
        let node: Graph.Node
        
        var id: String {
            node.id
        }
        
        var value: String {
            observer?(id)
            return node.value
        }
        var neighbors = [Node]()
        var observer: ((String) -> ())?
        
        init(node: Graph.Node) {
            self.node = node
        }
    }
}

// MARK: View

