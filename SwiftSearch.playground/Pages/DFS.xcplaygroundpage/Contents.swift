/*:
 [Previous](@previous)
 # Depth first search (DFS)
 
 Let's combine our knowledge about DAG and Cycles to implement the DFS algorithm.
 Each node is allowed to have 0, 1 or multiple neighbors and there may be cycles in the graph.
 
 ![Pseudo code](dfs.png)
 (Pseudo code from [Wikipedia](https://en.wikipedia.org/wiki/Depth-first_search))
 */

import PlaygroundSupport


func findPath(to emoji: String, from node: Node) -> [Node] {
    node.discovered = true
    if node.emoji == emoji {
        return [node]
    }
    for neighbor in node.neighbors {
        if !neighbor.discovered {
            let path = findPath(to: emoji, from: neighbor)
            if path.count > 0 {
                return [node] + path
            }
        }
    }
    return []
}

/*:
 - Experiment: Intentionally return the wrong path
 
 For example: return [node] + path + [node]
 */

// The following emojis can be found: 🕵️🤖😍🏆🐒🙋🏻‍♂️
let view = View.create(target: "😍", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view

/*:
 - callout(Challenge):
 Implement the DFS algorithm  iteratively using a stack
 */


//: [Next](@next)


