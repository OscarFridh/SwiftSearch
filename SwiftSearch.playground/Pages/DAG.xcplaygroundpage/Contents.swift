/*:
 [Previous](@previous)
 # Directed Asyclic Graph (DAG)
 Now we will allow each node to have 0, 1 or multiple neighbors. Please fix the code below so that it works for this new requirement. Do not worry about cycles yet.
 */

import PlaygroundSupport


func findPath(to target: String, from node: Node) -> [Node] {
    if node.value == target {
        return [node]
    } else {
        for neighbor in node.neighbors.reversed() {
            let path = findPath(to: target, from: neighbor)
            if path.count > 0 {
                return [node] + path
            }
        }
    }
    return []
}

let view = View(target: "F", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view


//: [Next](@next)


//: ## Hints and solutions below ↓








/*:
 - callout(Hint):
 We need to continue the search for all neighbors to a node.
 */


/*:
 - Experiment: Try searching in the opposite order by reversing the list of neighbors.
 */











func exampleFindPath(to target: String, from node: Node) -> [Node] {
    if node.value == target {
        return [node]
    } else {
        for neighbor in node.neighbors {
            let path = exampleFindPath(to: target, from: neighbor)
            if path.count > 0 {
                return [node] + path
            }
        }
    }
    return []
}



