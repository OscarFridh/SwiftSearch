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
        let scene = Scene.create(target: target, searchAlgorithm: searchAlgorithm)
        presentScene(scene)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public protocol Node: class {
    var value: String { get }
    var neighbor: Node? { get }
}


// MARK: Model

struct Graph {
    
    struct Node {
        let id: String
        let value: String
        let neighbors: [String]
    }
    
    let nodes: [String: Node]
    let edges: [String: [String]]
    
    init(nodes list: [Node]) {
        var dict = [String: Node]()
        var edges = [String: [String]]()
        for node in list {
            dict[node.id] = node
            edges[node.id] = node.neighbors
        }
        self.nodes = dict
        self.edges = edges
    }
}

struct SearchResult {
    let searchEvents: [String]
    let node: Node?
    let correct: Bool
}

struct Level1 {
    
    typealias SearchAlgorithm = (String, Node) -> Node?
    
    let graph = Graph(nodes: [
        .init(id: "a", value: "a", neighbors: ["b"]),
        .init(id: "b", value: "b", neighbors: ["c"]),
        .init(id: "c", value: "c", neighbors: []),
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
    
    struct SearchResult {
        let searchEvents: [String]
        let nodeId: String?
        let correct: Bool
    }
    
    private func correctSearch(for target: String, in node: Node) -> Node? {
        if node.value == target {
            return node
        } else if let neighbor = node.neighbor {
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
                searchNodes[source]!.neighbor = destinations.map { searchNodes[$0]! }.first
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
        var neighbor: Node?
        var observer: ((String) -> ())?
        
        init(node: Graph.Node) {
            self.node = node
        }
    }
}

// MARK: View

class Scene: SKScene {
    static func create(target: String, searchAlgorithm: @escaping (String, Node) -> Node?) -> SKScene {
        let scene = Scene(fileNamed: "scene")!
        let level = Level1(targetValue: target)
        scene.searchResult = level.search(using: searchAlgorithm)
        scene.graph = level.graph
        return scene
    }
    
    var graph: Graph!
    var searchResult: Level1.SearchResult!
    
    override func didMove(to view: SKView) {
        print(searchResult!)
        // TODO: Animate search result!
    }
    
}

