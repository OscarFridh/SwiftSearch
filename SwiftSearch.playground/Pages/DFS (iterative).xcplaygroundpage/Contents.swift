/*:
 [Previous](@previous)
 # Iterative DFS
 Of course, there are many ways to solve a programming task. Let's implement the [DFS algorithm](https://en.wikipedia.org/wiki/Depth-first_search) algorithm again, this time usign an iterative approach!
 
 ![Pseudo code](dfs.png)
 */

import PlaygroundSupport


func search(for target: String, in node: Node) -> Node? {
    var stack = Stack()
    stack.push(node)
    while !stack.isEmpty {
        let v = stack.pop()
        if v.value == target {
            return v
        }
        if !v.visited {
            v.visited = true
            for neighbor in v.neighbors {
                stack.push(neighbor)
            }
        }
    }
    return nil
}


// 🐒
let view = View(target: "x", searchAlgorithm: search, speed: 1)
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
 If we finish the while loop, the target could not be found and we should return nil
 */





func exampleSearch(for target: String, in node: Node) -> Node? {
    var stack = Stack()
    stack.push(node)
    while !stack.isEmpty {
        let v = stack.pop()
        if v.value == target {
            return v
        }
        if !v.visited {
            v.visited = true
            for neighbor in v.neighbors {
                stack.push(neighbor)
            }
        }
    }
    return nil
}



