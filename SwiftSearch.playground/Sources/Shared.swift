import Foundation
import SpriteKit

// MARK: Model

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
    public let searchEvents: [SearchEvent]
    public let path: [String]
    public let correct: Bool
    
    public init(searchEvents: [SearchEvent], path: [String], correct: Bool) {
        self.searchEvents = searchEvents
        self.path = path
        self.correct = correct
    }
}

public enum SearchEvent {
    case check(String)
    case discovered(String, Bool)
}

public typealias SearchAlgorithm = (Node, String) -> [Node]

/// Handles searching
public struct Level {
    
    public let graph: Graph
    let start: String
    let targetValue: String
    
    public init(graph: Graph, start: String = "a", targetValue: String) {
        self.graph = graph
        self.start = start
        self.targetValue = targetValue
    }
    
    public func search(using searchAlgorithm: SearchAlgorithm) -> SearchResult {
        let (events, path) = search(using: searchAlgorithm)
        let (_, correctPath) = search(using: dfs)
        let correct = validate(path: path, correctPath: correctPath)
        return SearchResult(searchEvents: events, path: path, correct: correct)
    }
    
    private func validate(path: [String], correctPath: [String]) -> Bool {
        
        guard path.first == correctPath.first else {
            print("Start of path is \(path.first ?? "nil") but should be \(start)")
            return false
        }
        guard path.last == correctPath.last else {
            print("End of path is \(path.last ?? "nil") but should be \(correctPath.last ?? "nil")")
            return false
            
        }
        
        if correctPath.count > 0 {
            for i in 0..<path.count-1 {
                let from = path[i]
                let to = path[i+1]
                guard graph.edges[from]?.contains(to) == true else {
                    print("There is no edge from \(from) to \(to)")
                    return false
                }
            }
        }
        
        return true
    }
    
    private func search(using searchAlgorithm: SearchAlgorithm) -> (searchEvents: [SearchEvent], path: [String]) {
        var searchEvents = [SearchEvent]()
        let searchNodes = Node.create(from: graph) { event in
            searchEvents.append(event)
        }
        let path = searchAlgorithm(searchNodes[start]!, targetValue).map { $0.id }
        return (searchEvents, path)
    }
}

/// API exposed to user. Responsible for capturing search events triggered by the algorithm so that they can be used by the view and animated later.
public class Node {
    static func create(from graph: Graph, observer: ((SearchEvent) -> ())?) -> [String: Node] {
        var searchNodes = [String: Node]()
        for node in graph.nodes.values {
            let searchNode = Node(node: node)
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
    
    public var emoji: String {
        observer?(.check(id))
        return node.value
    }
    
    private var _discovered: Bool = false
    public var discovered: Bool {
        get {
            return _discovered
        } set {
            observer?(.discovered(id, newValue))
            _discovered = newValue
        }
    }
    
    public var pred: Node?
    
    public var neighbors = [Node]()
    var observer: ((SearchEvent) -> ())?
    
    init(node: Graph.Node) {
        self.node = node
    }
}

public struct Stack {
    private var items = [Node]()
    
    public init() {}
    
    public mutating func push(_ item: Node) {
        items.append(item)
    }
    
    public mutating func pop() -> Node {
        return items.removeLast()
    }
    
    public var isEmpty: Bool {
        return items.isEmpty
    }
}

/// Complete implementation that can be used in DFS vs BFS as well as for validation
public func dfs(from node: Node, to target: String) -> [Node] {
    node.discovered = true
    if node.emoji == target {
        return [node]
    }
    for neighbor in node.neighbors {
        if !neighbor.discovered {
            let path = dfs(from: neighbor, to: target)
            if path.count > 0 {
                return [node] + path
            }
        }
    }
    return []
}

/// Complete implementation that can be used in DFS vs BFS as well as for validation
public func bfs(from node: Node, to target: String) -> [Node] {
    var q = [node]
    node.discovered = true
    while !q.isEmpty {
        let v = q.removeFirst()
        if v.emoji == target {
            var path = [v]
            var n: Node = v
            while n.pred != nil {
                n = n.pred!
                path = [n] + path
            }
            return path
        }
        for next in v.neighbors {
            if !next.discovered {
                q.append(next)
                next.pred = v
                next.discovered = true
            }
        }
    }
    return []
}


// MARK: View

public class View: SKView {
    public static func create(graph: Graph, searchResult: SearchResult, speed: Double = 1) -> UIView {
        let view = View(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
        view.showsFPS = true
        view.showsNodeCount = true
        let scene = Scene.create(graph: graph, searchResult: searchResult)
        scene.speed = CGFloat(speed)
        view.presentScene(scene)
        return view
    }
    
}

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
    private var searchEventsQueue = [SearchEvent]()
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
        animateSearchEvents() {
            self.highlightPath()
        }
    }
    
    private func animateSearchEvents(completion completedFullAnimation: (() -> ())? = nil) {
        guard searchEventsQueue.count > 0 else {
            completedFullAnimation?()
            return
        }
        let completion = {
            self.animateSearchEvents(completion: completedFullAnimation)
        }
        let searchEvent = searchEventsQueue.removeFirst()
        switch searchEvent {
        case .check(let nodeId):
            nodeSprites[nodeId]!.check(completion: completion)
        case .discovered(let nodeId, let discovered):
            nodeSprites[nodeId]!.markAsDiscovered(discovered, completion: completion)
        }
    }
    
    private func highlightPath(completion: (() -> ())? = nil) {
        let pathNodes: [NodeSprite] = searchResult.path.compactMap { self.nodeSprites[$0] }
        let otherNodes = graph.nodes.values.filter { !searchResult.path.contains($0.id) }.compactMap { self.nodeSprites[$0.id] }
        
        // Fade out other nodes and arrows
//        for n in otherNodes {
//            n.run(.fadeOut(withDuration: 0.5))
//        }
//        childNode(withName: "edges")?.run(.fadeOut(withDuration: 0.5))
        
        // Animate the selected path
        NodeSprite.highlight(pathNodes, correct: searchResult.correct, completion: completion)
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
        circle.color = .initialCircle
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
    
    func markAsDiscovered(_ discovered: Bool, completion: (() -> ())? = nil) {
        circle.color = discovered ? .discoveredCircle : .initialCircle
        completion?()
    }
    
    static func highlight(_ path: [NodeSprite], correct: Bool, completion: (() -> ())? = nil) {
        guard path.count > 0 else {
            completion?()
            return
        }
        for (i, node) in path.enumerated() {
            node.run(.sequence([
                .wait(forDuration: Double(i)/5),
                .run {
                    node.circle.color = correct ? .correctCircle : .incorrectCircle
                },
                .scale(to: 1.5, duration: 0.2),
                .scale(to: 1, duration: 0.2),
                .run {
                    let isLastNode = (i == path.count-1)
                    if isLastNode {
                        completion?()
                    }
                }
            ]))
        }
    }
}

extension UIColor {
    static let initialCircle = UIColor.systemBlue
    static let discoveredCircle = UIColor.systemPurple
    static let correctCircle = UIColor.systemGreen
    static let incorrectCircle = UIColor.systemRed
}
