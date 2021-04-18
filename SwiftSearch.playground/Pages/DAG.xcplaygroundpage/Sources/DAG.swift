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
        scene.speed = CGFloat(speed)
        presentScene(scene)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// One uniform API for all pages
public protocol Node: class {
    var value: String { get }
    var neighbors: [Node] { get }
}

// Convenience for level 1 & 3
public extension Node {
    var neighbor: Node? {
        neighbors.first
    }
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
        .init(id: "a", value: "A", neighbors: ["b", "d"]),
        .init(id: "b", value: "B", neighbors: ["c"]),
        .init(id: "c", value: "C", neighbors: []),
        .init(id: "d", value: "D", neighbors: ["e", "f"]),
        .init(id: "e", value: "E", neighbors: []),
        .init(id: "f", value: "F", neighbors: []),
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
        } else {
            for neighbor in node.neighbors {
                if let node = correctSearch(for: target, in: neighbor) {
                    return node
                }
            }
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

class Scene: SKScene {
    static func create(target: String, searchAlgorithm: @escaping (String, Node) -> Node?) -> SKScene {
        let scene = Scene(fileNamed: "scene")!
        let level = Level1(targetValue: target)
        scene.searchResult = level.search(using: searchAlgorithm)
        scene.graph = level.graph
        scene.childNode(withName: "graph")?.children.compactMap { $0 as? SKSpriteNode }.forEach { node in
            scene.setupNodeSprite(circle: node)
        }
        scene.backgroundColor = .white
        return scene
    }
    
    private var graph: Graph!
    private var searchResult: Level1.SearchResult! {
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
    
    override func didMove(to view: SKView) {
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
        
        guard !revealed else { return }
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

