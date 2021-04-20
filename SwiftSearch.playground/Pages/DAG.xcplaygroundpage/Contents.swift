/*:
 [Previous](@previous)
 # Directed Asyclic Graph (DAG)
 
 Now we will allow each node to have 0, 1 or multiple neighbors.
 We do however not tolerate any neighbors that would cause cycles.
 Our search algorithm will go all the way down a branch, then back up just enough to continue all the way down another branch, and so on...
 
 Please update the search function so that it can continue to explore multiple neighbors.
 
 Scroll down to see an example solution ↓
 */
import PlaygroundSupport

func findPath(from node: Node, to emoji: String) throws -> [Node] {
    if try node.checkEmoji() == emoji {
        return [node]
    }
    if let nextNode = node.neighbors.first {
        let path = try findPath(from: nextNode, to: emoji)
        if path.count > 0 {
            return [node] + path
        }
    }
    return []
}

/*:
 - callout(Hint): Replace the second if statement with a for loop
 */


// The following emojis can be found: 🕵️🤖😍🏆🐒🙋🏻‍♂️
let emoji = "🏆"
let searchResult = Level.search(for: emoji, using: findPath)
let view = View.create(searchResult: searchResult, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view














/*:
 Copy and paste to quickly see a solution.
 Replace the function above with the following:
 */

/*:
     func findPath(from node: Node, to emoji: String) throws -> [Node] {
         if try node.checkEmoji() == emoji {
             return [node]
         }
         for nextNode in node.neighbors {
             let path = try findPath(from: nextNode, to: emoji)
             if path.count > 0 {
                 return [node] + path
             }
         }
         return []
     }
 */


//: [Next](@next)


