/*:
 [Previous](@previous)
 # Linked List
 
 We are given a list of nodes where each node hides an emoji.
 Our job is to find a path from a starting node to the emoji 🐒
 
 Please finish implementing the function below to do that recursively.
 */

import PlaygroundSupport

func findPath(to emoji: String, from node: Node) -> [Node] {
    if node.emoji == emoji {
        return [node]
    }
    
    /** TODO:
     If the node has a neighbor:
        Return a path starting with this node, followed by the remaining path returned from the neighbor.
     otherwise:
        We have reached the end of the list without finding the emoji, return []
     */
    
    return []
}


let searchResult = Level.search(for: "🐒", using: findPath)
let view = View.create(searchResult: searchResult, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view

//: Scroll down to see an example solution ↓















/*:
 Copy and paste to quickly see a solution.
 Replace the function above with the following:
 */

/*:
     func findPath(to emoji: String, from node: Node) -> [Node] {
         if node.emoji == emoji {
             return [node]
         }
         if let nextNode = node.neighbor {
              return [node] + findPath(to: emoji, from: nextNode)
         }
         return []
     }
 */

//: [Next](@next)
