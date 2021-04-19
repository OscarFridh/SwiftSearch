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

func findPath(to emoji: String, from node: Node) -> [Node] {
    if node.emoji == emoji {
        return [node]
    }
    if let nextNode = node.neighbors.first {
        let path = findPath(to: emoji, from: nextNode)
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
let searchResult = Level.search(for: "🏆", using: findPath)
let view = View.create(searchResult: searchResult, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view














/*:
 Copy and paste to quickly see a solution.
 Replace the function above with the following:
 */

/*:
     func findPath(to emoji: String, from node: Node) -> [Node] {
         if node.emoji == emoji {
             return [node]
         }
         for nextNode in node.neighbors {
             let path = findPath(to: emoji, from: nextNode)
             if path.count > 0 {
                 return [node] + path
             }
         }
         return []
     }
 */


//: [Next](@next)


