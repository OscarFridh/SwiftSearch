/*:
 [Previous](@previous)
 # Breadth first search (BFS)
 As you might have noticed, the DFS will not necessarily find the shortest path. There is another search algorithm that will always find the shortest path, let's implement the BFS algorithm next
 Now let's use our new knowledge from DAG and Cycles to implement the [BFS algorithm](https://en.wikipedia.org/wiki/Breadth-first_search) next!
 
 ![Pseudo code](bfs.png)
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


// 🐒
let view = View.create(target: "F", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view

//: [Next](@next)


//: ## Hints and solutions below ↓













func exampleFindPath(to target: String, from node: Node) -> [Node] {
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



