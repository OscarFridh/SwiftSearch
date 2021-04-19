/*:
 [Previous](@previous)
 # Breadth first search (BFS)
 
 BFS explores nodes in a different order than DFS. First, every node one step away from the starting point is visited. Then every node two steps away from the starting point is visited, and so on... This enables the algorithm to always return the shortest possible path to the emoji. Let's see it in action!
 
 ![Pseudo code](bfs.png)
 (Pseudo code from [Wikipedia](https://en.wikipedia.org/wiki/Breadth-first_search))
 */

import PlaygroundSupport

func findPath(to target: String, from node: Node) -> [Node] {
    var q = [node]
    node.visited = true
    while !q.isEmpty {
        let v = q.removeFirst()
        if v.value == target {
            var path = [v]
            var n: Node = v
            while n.pred != nil {
                n = n.pred!
                path = [n] + path
            }
            return path
        }
        for next in v.neighbors {
            if !next.visited {
                q.append(next)
                next.pred = v
                next.visited = true
            }
        }
    }
    return []
}


// TODO: The following emojis can be found: ...
let view = View.create(target: "F", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view

//: [Next](@next)

