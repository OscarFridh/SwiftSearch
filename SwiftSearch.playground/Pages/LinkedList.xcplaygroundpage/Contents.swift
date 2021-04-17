/*:
 [Previous](@previous)
 # Linked List
 You are given a list of nodes. Each node hides an emoji and your job is to find out which node that is hiding a certain emoji 🐒.
 Every node except the last node in the list points to the following node as its neighbor.
 
 Please implement the following function and run your code to see how it works.
 */

import PlaygroundSupport


func search(for target: String, in node: Node) -> Node? {
    return nil
}

let view = View(target: "🐒", searchAlgorithm: search, speed: 1)
// TODO: Set live view here!


//: [Next](@next)


//: ## Hints and solutions below ↓

























/*:
 - callout(Hint):
 I have provided example solutions at the end of each page. Feel free to scroll down and have a look.
 */


/*:
 - Experiment: Try searching for other emojis in the list and make sure that your code works even for emojis that are not present in the list.
 */


func exampleSearch(for target: String, in node: Node) -> Node? {
    if node.value == target {
        return node
    } else if let neighbor = node.neighbor {
        return exampleSearch(for: target, in: neighbor)
    } else {
        return nil
    }
}



