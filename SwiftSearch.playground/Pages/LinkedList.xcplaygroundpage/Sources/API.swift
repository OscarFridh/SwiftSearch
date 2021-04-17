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

func search(in graph: Graph, start: String = "a", target: String, using searchAlgorithm: @escaping (String, Node) -> Node?) -> SearchResult {
    
    var searchEvents = [String]()
    let searchNodes = SearchNode.create(from: graph) { event in
        searchEvents.append(event)
    }
    
    let node = searchAlgorithm(target, searchNodes[start]!)
    let correct = (node as! SearchNode).node.value == target // Avoid triggering the observer again!
    
    return SearchResult(searchEvents: searchEvents, node: node, correct: correct)
}

class SearchNode: Node {
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

// MARK: View

class Scene: SKScene {
    static func create(target: String, searchAlgorithm: @escaping (String, Node) -> Node?) -> SKScene {
        let scene = Scene(fileNamed: "scene")!
        scene.searchAlgorithm = searchAlgorithm
        return scene
    }
    
    var searchAlgorithm: ( (String, Node) -> Node?)!
    let graph = Graph(nodes: [
        .init(id: "a", value: "a", neighbors: ["b"]),
        .init(id: "b", value: "b", neighbors: ["c"]),
        .init(id: "c", value: "c", neighbors: []),
    ])
    
    override func didMove(to view: SKView) {
        let searchResult = search(in: graph, target: "c", using: searchAlgorithm)
        print(searchResult)
        // TODO: Animate search result!
    }
    
}

