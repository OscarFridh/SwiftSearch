/*:
 [Previous](@previous)
 # Depth first search (DFS)
 Now let's use our new knowledge from DAG and Cycles to implement the [DFS algorithm](https://en.wikipedia.org/wiki/Depth-first_search) reccursively!
 
 ![Pseudo code](dfs.png)
 */

import PlaygroundSupport


func findPath(to target: String, from node: Node) -> [Node] {
    node.visited = true
    if node.value == target {
        return [node]
    }
    for neighbor in node.neighbors {
        if !neighbor.visited {
            let path = findPath(to: target, from: neighbor)
            if path.count > 0 {
                return path + [node] + path
            }
        }
    }
    return []
}


// 🐒
let view = View.create(target: "E", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view


//: [Next](@next)


//: ## Hints and solutions below ↓













func exampleFindPath(to target: String, from node: Node) -> [Node] {
    node.visited = true
    if node.value == target {
        return [node]
    }
    for neighbor in node.neighbors {
        if !neighbor.visited {
            let path = exampleFindPath(to: target, from: neighbor)
            if path.count > 0 {
                return [node] + path
            }
        }
    }
    return []
}


/*:
 - Experiment: Make sure that your code also works when searching for something that can be found
 */


/*:
 - callout(Challenge):
 The DFS algorithm can also be implemented iteratively using a stack...
 */
