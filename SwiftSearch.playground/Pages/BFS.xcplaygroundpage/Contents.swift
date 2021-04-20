/*:
 [Previous](@previous)
 # Breadth first search (BFS)
 
 Here's an implementation of the BFS algorithm.
 
 ![Pseudo code](bfs.png)
 (Pseudo code from [Wikipedia](https://en.wikipedia.org/wiki/Breadth-first_search))
 */

import PlaygroundSupport

func findPath(from node: Node, to emoji: String) throws -> [Node] {
    var q = [node]
    node.discovered = true
    while !q.isEmpty {
        let v = q.removeFirst()
        if try v.checkEmoji() == emoji {
            var path = [v]
            var n: Node = v
            while n.pred != nil {
                n = n.pred!
                path = [n] + path
            }
            return path
        }
        for next in v.neighbors {
            if !next.discovered {
                q.append(next)
                next.pred = v
                next.discovered = true
            }
        }
    }
    return []
}


// The following emojis can be found: 🕵️🤖😍🏆🐒🙋🏻‍♂️
let emoji = "🏆"
let searchResult = Level.search(for: emoji, using: findPath)
let view = View.create(searchResult: searchResult, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view
//: [Next](@next)

