/*:
 [Previous](@previous)
 # Depth first search (DFS)
 
 Let's combine our knowledge about DAG and Cycles to implement the DFS algorithm.
 Each node is allowed to have 0, 1 or multiple neighbors and there may be cycles in the graph.
 
 ![Pseudo code](dfs.png)
 (Pseudo code from [Wikipedia](https://en.wikipedia.org/wiki/Depth-first_search))
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
                return [node] + path
            }
        }
    }
    return []
}

/*:
 - Experiment: Try returning the wrong path on the way back from the recursion
 
 For example: return [node] + path + [node]
 */

// TODO: The following emojis can be found: ...
let view = View.create(target: "E", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view

/*:
 - callout(Challenge):
 Implement the DFS algorithm  iteratively using a stack
 */

/*:
 The DFS algorithm was unable to find the shortest path to the emoji. We will fix this with the next algorithm.
 */


//: [Next](@next)


