/*:
 [Previous](@previous)
 # Iterative DFS
 Of course, there are many ways to solve a programming task. Let's implement the [DFS algorithm](https://en.wikipedia.org/wiki/Depth-first_search) algorithm again, this time usign an iterative approach!
 
 ![Pseudo code](dfs.png)
 */

import PlaygroundSupport


func findPath(to target: String, from node: Node) -> [Node] {
    return []
}


// 🐒

let view = View.create(target: "x", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view


//: [Next](@next)


//: ## Hints and solutions below ↓




/*:
 - callout(Hint):
 You can use a Stack data structure that I have included for this task if you want.
 */

/*:
 - callout(Hint):
 Check a node right after it has been popped from the stack
 */

/*:
 - callout(Hint):
 In order to keep track of the previous nodes, we can make use of node.pred
 */


/*:
 - callout(Hint):
 If we finish the while loop, the target could not be found
 */





func exampleFindPath(to target: String, from node: Node) -> [Node] {
    return []
}



