/*:
 [Previous](@previous)
 # Directed Asyclic Graph (DAG)
 
 Now we will allow each node to have 0, 1 or multiple neighbors.
 We do however not tolerate any neighbors that would cause cycles.
 Our search algorithm will go all the way down a branch, then back up just enough to continue all the way down another branch, and so on...
 */

import PlaygroundSupport


func findPath(to emoji: String, from node: Node) -> [Node] {
    if node.emoji == emoji {
        return [node]
    } else {
        for neighbor in node.neighbors {
            let path = findPath(to: emoji, from: neighbor)
            if path.count > 0 {
                return [node] + path
            }
        }
    }
    return []
}

/*:
 - Experiment: Explore branches in reverse order by reversing the list of neighbors in the for loop.
 */


// The following emojis can be found: 🐒🙋🏻‍♂️🤖
let view = View.create(target: "F", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view


//: [Next](@next)


