/*:
 [Previous](@previous)
 # Cycles
 When searching a graph it is important to discover cycles in order to prevent infinate loop and unnecessary searcing.
 Solve this by marking each node as visited as they are being discovered. Fix this search algorithm from getting stuck in an infinate loop.
 */

import PlaygroundSupport


func search(for target: String, in node: Node) -> Node? {
    node.visited = true
    if node.value == target {
        return node
    } else if node.neighbor?.visited == false {
        return search(for: target, in: node.neighbor!)
    } else {
        return nil
    }
}


// 🐒
let view = View(target: "d", searchAlgorithm: search, speed: 1)
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











func exampleSearch(for target: String, in node: Node) -> Node? {
    node.visited = true
    if node.value == target {
        return node
    } else if node.neighbor?.visited == false {
        return exampleSearch(for: target, in: node.neighbor!)
    } else {
        return nil
    }
}



