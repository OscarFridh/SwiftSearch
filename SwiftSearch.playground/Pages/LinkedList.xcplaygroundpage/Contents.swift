/*:
 [Previous](@previous)
 # Linked List
 You are given a list of nodes. Each node hides an emoji and your job is to find the path to the node that is hiding a certain emoji 🐒.
 Every node except the last node in the list points to the following node as its neighbor.
 
 Please implement the following function and run your code to see how it works.
 */

import PlaygroundSupport


func findPath(to target: String, from node: Node) -> [Node] {
    if node.value == target {
        return [node]
    } else if let neighbor = node.neighbor {
        let path = findPath(to: target, from: neighbor)
        if path.count > 0 {
            return [node] + path
        }
    }
    return []
}

let view = View(target: "🐒", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view


//: [Next](@next)


//: ## Hints and solutions below ↓

























/*:
 - callout(Hint):
 I have provided example solutions at the end of each page. Feel free to scroll down and have a look.
 */


/*:
 - Experiment: Try searching for other emojis in the list and make sure that your code works even for emojis that are not present in the list.
 */


func exampleFindPath(to target: String, from node: Node) -> [Node] {
    if node.value == target {
        return [node]
    } else if let neighbor = node.neighbor {
        let path = exampleFindPath(to: target, from: neighbor)
        if path.count > 0 {
            return [node] + path
        }
    }
    return []
}



