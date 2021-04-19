/*:
 [Previous](@previous)
 # Cycles
 When searching a graph with cycles it is important to avoid getting stuck in an infinate loop.
 In order to do this we mark nodes as discovered as we visit them.
 If a neighbor has already been discovered we can avoid visiting it again and thereby escape the cycle.
 
 Discovered nodes will be shown in purple.
 */

import PlaygroundSupport

func findPath(to target: String, from node: Node) -> [Node] {
    node.visited = true
    if node.value == target {
        return [node]
    } else if node.neighbor?.visited == false {
        let path = findPath(to: target, from: node.neighbor!)
        if path.count > 0 {
            return [node] + path
        }
    }
    return []
}


// The following emojis can be found: 🐒🙋🏻‍♂️🤖
let view = View.create(target: "x", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view


//: [Next](@next)
