/*:
 [Previous](@previous)
 # Cycles
 Let's point the end to the start of the list so that it forms a loop.
 This causes our current algorithm to get stuck forever.
 
 In order to fix it we need to:
 1. Mark nodes as discovered when we visit them
 2. Avoid visiting nodes that have already been discovered
 
 Please fix the function below.
 
 Scroll down to see an example solution ↓
 */

import PlaygroundSupport




func findPath(from node: Node, to emoji: String) throws -> [Node] {
    if try node.checkEmoji() == emoji {
        return [node]
    }
    if let nextNode = node.neighbor {
        let remainingPath = try findPath(from: nextNode, to: emoji)
        if remainingPath.count > 0 {
            return [node] + remainingPath
        }
    }
    return []
}

/*:
 >Exceptions are only used to escape infinate loops
*/



// The following emojis can be found: 🐒🙋🏻‍♂️🤖
let emoji = "🏆"
let searchResult = Level.search(for: emoji, using: findPath)
let view = View.create(searchResult: searchResult, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view









/*:
 Copy and paste to quickly see a solution.
 Replace the function above with the following lines of code:
 */

/*:
     func findPath(from node: Node, to emoji: String) throws -> [Node] {
         node.discovered = true
         if try node.checkEmoji() == emoji {
             return [node]
         }
         if let nextNode = node.neighbor {
             if nextNode.discovered == false {
                 let remainingPath = try findPath(from: nextNode, to: emoji)
                 if remainingPath.count > 0 {
                     return [node] + remainingPath
                 }
             }
         }
         return []
     }
 */

//: [Next](@next)
