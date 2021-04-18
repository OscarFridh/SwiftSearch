/*:
 [Previous](@previous)
 # Depth first search (DFS)
 Now let's use our new knowledge from DAG and Cycles to implement the [DFS algorithm](https://en.wikipedia.org/wiki/Depth-first_search) reccursively!
 
 ![Pseudo code](dfs.png)
 */

import PlaygroundSupport


func search(for target: String, in node: Node) -> Node? {
    node.visited = true
    if node.value == target {
        return node
    }
    for neighbor in node.neighbors {
        if !neighbor.visited, let node = search(for: target, in: neighbor) {
            return node
        }
    }
    return nil
}


// 🐒
let view = View(target: "x", searchAlgorithm: search, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view

/*:
 - Experiment: Make sure that your code also works when searching for something that can be found
 */


//: [Next](@next)


//: ## Hints and solutions below ↓













func exampleSearch(for target: String, in node: Node) -> Node? {
    node.visited = true
    if node.value == target {
        return node
    }
    for neighbor in node.neighbors {
        if !neighbor.visited, let node = exampleSearch(for: target, in: neighbor) {
            return node
        }
    }
    return nil
}



