/*:
 [Previous](@previous)
 # Directed Asyclic Graph (DAG)
 Now we will allow each node to have 0, 1 or multiple neighbors. Please fix the code below so that it works for this new requirement. Do not worry about cycles yet.
 */

import PlaygroundSupport


func search(for target: String, in node: Node) -> Node? {
    if node.value == target {
        return node
    } else {
        // Please fix this part!
        return nil
    }
}

let view = View(target: "F", searchAlgorithm: search, speed: 1)
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











func exampleSearch(for target: String, in node: Node) -> Node? {
    if node.value == target {
        return node
    } else {
        for neighbor in node.neighbors {
            if let node = exampleSearch(for: target, in: neighbor) {
                return node
            }
        }
        return nil
    }
}



