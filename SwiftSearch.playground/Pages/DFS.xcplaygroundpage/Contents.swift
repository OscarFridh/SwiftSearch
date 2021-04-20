/*:
 [Previous](@previous)
 # Depth first search (DFS)
 
 Now let's allow each node to have multiple neighbors.
 We will end up implementing the DFS algorithm.
 
 ![Pseudo code](dfs.png)
 (Pseudo code from [Wikipedia](https://en.wikipedia.org/wiki/Depth-first_search))
 
 Scroll down to see an example solution ↓
 */

import PlaygroundSupport


func findPath(from node: Node, to emoji: String) throws -> [Node] {
    node.discovered = true
    if try node.checkEmoji() == emoji {
        return [node]
    }
    for nextNode in node.neighbors {
        if nextNode.discovered == false {
            let remainingPath = try findPath(from: nextNode, to: emoji)
            if remainingPath.count > 0 {
                return [node] + remainingPath
            }
        }
    }
    return []
}

/*:
 - callout(Hint): Replace the second if statement with a for loop
 */



// The following emojis can be found: 🕵️🤖😍🏆🐒🙋🏻‍♂️
let emoji = "😍"
let searchResult = Level.search(for: emoji, using: findPath)
let view = View.create(searchResult: searchResult, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view


/*:
 ## Scenario explained
 We start searching from 🤖
 
 We continue to 🙋🏻‍♂️ followed by 🕵️ and 🐒
 
 We do not continue from 🐒 to 🙋🏻‍♂️ since 🙋🏻‍♂️ has already been discovered.
 
 🐒 does not have any other neighbors so we return [] and back up from the recursion to 🕵️ followed by 🙋🏻‍♂️ and 🤖
 
 We continue from 🤖 to its next neighbor 😍
 
 😍 is the target so we return the path [😍] back to 🤖 and retreive [🤖, 😍] as our path
 
 */



/*:
 Copy and paste to quickly see a solution.
 Replace the function above with the following:
 */

/*:
     func findPath(from node: Node, to emoji: String) throws -> [Node] {
         node.discovered = true
         if try node.checkEmoji() == emoji {
             return [node]
         }
         for nextNode in node.neighbors {
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
