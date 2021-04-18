import Foundation
import SpriteKit

// MARK: Model

// One uniform API for all pages
public protocol Node: class {
    var value: String { get }
    var neighbors: [Node] { get }
    var visited: Bool { get set }
}

/// Used to model a graph of nodes
public struct Graph {
    
    public struct Node {
        public let id: String
        public let value: String
        public let neighbors: [String]
        
        public init(id: String, value: String, neighbors: [String]) {
            self.id = id
            self.value = value
            self.neighbors = neighbors
        }
    }
    
    public let nodes: [String: Node]
    public let edges: [String: [String]]
    
    public init(nodes list: [Node]) {
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

/// The result after executing a search algorithm that is used as input to views
public struct SearchResult {
    public let searchEvents: [String]
    public let nodeId: String?
    public let correct: Bool
    
    public init(searchEvents: [String], nodeId: String?, correct: Bool) {
        self.searchEvents = searchEvents
        self.nodeId = nodeId
        self.correct = correct
    }
}

/// Handles searching
public struct Level {
    
    public typealias SearchAlgorithm = (String, Node) -> Node?
    
    public let graph: Graph
    let start: String
    let targetValue: String
    private var correctNodeId: String?
    
    public init(graph: Graph, start: String = "a", targetValue: String, correctSearch: SearchAlgorithm) {
        self.graph = graph
        self.start = start
        self.targetValue = targetValue
        let (_, nodeId) = search(using: correctSearch)
        self.correctNodeId = nodeId
    }
    
    public func search(using searchAlgorithm: SearchAlgorithm) -> SearchResult {
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
        
        private var _visited: Bool = false
        var visited: Bool {
            get {
                return _visited
            } set {
                // TODO: Notify observer!
                _visited = newValue
            }
        }
        
        var neighbors = [Node]()
        var observer: ((String) -> ())?
        
        init(node: Graph.Node) {
            self.node = node
        }
    }
}



// MARK: View

public class Scene: SKScene {
    // Kanske skulle skapa endast med Graph, SearchResult? --> Oberoende från sök alg!
    public static func create(graph: Graph, searchResult: SearchResult) -> SKScene {
        let scene = Scene(fileNamed: "scene")!
        scene.graph = graph
        scene.searchResult = searchResult
        scene.childNode(withName: "graph")?.children.compactMap { $0 as? SKSpriteNode }.forEach { node in
            scene.setupNodeSprite(circle: node)
        }
        scene.backgroundColor = .white
        return scene
    }
    
    private var graph: Graph!
    private var searchResult: SearchResult! {
        didSet {
            searchEventsQueue = searchResult.searchEvents
        }
    }
    private var searchEventsQueue = [String]()
    private var selectedNodeId: String?
    private var nodeSprites = [String: NodeSprite]()
    
    // Quick fix until I figure out how to load custom subclasses in editor into Playgrounds.
    private func setupNodeSprite(circle: SKSpriteNode) {
        let nodeId = circle.name!
        let position = circle.position
        let parent = circle.parent
        let sprite = NodeSprite(content: graph.nodes[nodeId]!.value)
        sprite.position = position
        sprite.setup(circle: circle)
        parent?.addChild(sprite)
        nodeSprites[nodeId] = sprite
    }
    
    public override func didMove(to view: SKView) {
        print(searchResult)
        animateSearchEvents()
    }
    
    private func animateSearchEvents() {
        guard searchEventsQueue.count > 0 else {
            return
        }
        let completion = {
            self.animateSearchEvents()
        }
        let searchEvent = searchEventsQueue.removeFirst()
        nodeSprites[searchEvent]!.check(completion: completion)
    }
    
}

class NodeSprite: SKNode {
    
    // State
    private var revealed = false
    private var content: String = ""
    
    // Child nodes
    private let transform = SKTransformNode()
    private var circle: SKSpriteNode!
    private var label: SKLabelNode!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init(content: String) {
        super.init()
        self.content = content
        setup()
    }
    
    private func setup() {
        addChild(transform)
    }
    
    // Quick fix until I figure out how to load custom subclasses in editor into Playgrounds.
    func setup(circle: SKSpriteNode) {
        self.circle = circle
        circle.removeFromParent()
        transform.addChild(circle)
        circle.position = .zero
        circle.color = .systemBlue
        label = (circle.childNode(withName: "label")! as! SKLabelNode)
        label.text = "?"
    }
    
    // OBS: SKAction.colorize fungerar inte om noden tags bort och flyttas runt mellan parents.
    // Tills vidare löser jag det utan att animera för att kunna gå vidare med viktigare saker!
    // Jag tror faktiskt att det blir tydligare utan animationer för sådant som algoritmen inte direkt påverkar!
    
    func check(completion: (() -> ())? = nil) {
        run(.sequence([
            .scale(to: 1.5, duration: 0.3),
            .wait(forDuration: 0.5),
            .run {
                self.reveal() {
                    self.run(.sequence([
                        SKAction.wait(forDuration: 0.3),
                        .scale(to: 1, duration: 0.3)
                    ])) {
                        completion?()
                    }
                }
            }
        ]))
    }
    
    private func reveal(completion: (() -> ())? = nil) {
        
        guard !revealed else {
            completion?()
            return
        }
        revealed = true
        
        let duration: Double = 0.5
        
        let action = SKAction.customAction(withDuration: duration) { (_, time) in
            let progress = (time / CGFloat(duration))
            if progress >= 0.5 {
                self.label.text = self.content
                self.label.yScale = -1
            }
            self.transform.xRotation = progress * .pi
        }
        
        run(action) {
            completion?()
        }
    }
}
