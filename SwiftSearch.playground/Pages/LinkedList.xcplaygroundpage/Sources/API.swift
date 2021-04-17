import Foundation

public struct View {
    let target: String
    let searchAlgorithm: (String, Node) -> Node?
    public init(target: String, searchAlgorithm: @escaping (String, Node) -> Node?, speed: Double = 1) {
        self.target = target
        self.searchAlgorithm = searchAlgorithm
    }
}

public protocol Node: class {
    var value: String? { get }
    var neighbor: Node? { get }
}
