import SpriteKit

public class View: SKView {
    let target: String
    let searchAlgorithm: (String, Node) -> Node?
    public init(target: String, searchAlgorithm: @escaping (String, Node) -> Node?, speed: Double = 1) {
        self.target = target
        self.searchAlgorithm = searchAlgorithm
        super.init(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
        showsFPS = true
        showsNodeCount = true
        let scene = SKScene(fileNamed: "scene")
        presentScene(scene)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public protocol Node: class {
    var value: String? { get }
    var neighbor: Node? { get }
}
