/*:
 [Previous](@previous)
 # Cycles
 When searching a graph it is important to discover cycles in order to prevent infinate loop and unnecessary searcing.
 Solve this by marking each node as visited as they are being discovered. Fix this search algorithm from getting stuck in an infinate loop.
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


// 🐒
let view = View.create(target: "t", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view


//: [Next](@next)


//: ## Hints and solutions below ↓








/*:
 - callout(Hint):
 If a neighbor has already been visited, it should not be searched again.
 */


/*:
 - Experiment: Make sure that your code also works when searching for something that can be found
 */











func exampleFindPath(to target: String, from node: Node) -> [Node] {
    node.visited = true
    if node.value == target {
        return [node]
    } else if node.neighbor?.visited == false {
        let path = exampleFindPath(to: target, from: node.neighbor!)
        if path.count > 0 {
            return [node] + path
        }
    }
    return []
}



