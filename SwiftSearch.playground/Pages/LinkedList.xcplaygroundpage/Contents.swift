/*:
 [Previous](@previous)
 # Linked List
 
 We are given a list of nodes where each node hides an emoji.
 Our job is to find a path from a given node to a certain emoji 🐒
 
 Please finish implementing the function below.
 
 Scroll down to see an example solution ↓
 */
import PlaygroundSupport


func findPath(from node: Node, to emoji: String) throws -> [Node] {
     if try node.checkEmoji() == emoji {
         return [node]
     }
     if let nextNode = node.neighbor {
        /** TODO: Replace this with your code!
         1. Find the remaining path from `nextNode`
         2. If it was found (not empty),
            Return a path starting with `node`, followed by the remaining path
         */
     }
     return []
 }


let emoji = "🐒"
let searchResult = Level.search(for: emoji, using: findPath)
let view = View.create(searchResult: searchResult, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view













/*:
 Copy and paste to quickly see a solution.
 Replace the function above with the following lines of code:
 */

/*:
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
 */

//: [Next](@next)
