/*:
 [Previous](@previous)
 # Depth first search (DFS)
 
 Let's combine our knowledge about DAG and Cycles to implement the DFS algorithm.
 Each node is allowed to have 0, 1 or multiple neighbors and there may be cycles in the graph.
 
 ![Pseudo code](dfs.png)
 (Pseudo code from [Wikipedia](https://en.wikipedia.org/wiki/Depth-first_search))
 
 Scroll down to see an example solution ↓
 */

import PlaygroundSupport


func findPath(from node: Node, to emoji: String) -> [Node] {
    // Please feel free to copy & paste the solution if you are short on time!
    return []
}


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
     func findPath(from node: Node, to emoji: String) -> [Node] {
         node.discovered = true
         if node.emoji == emoji {
             return [node]
         }
         for neighbor in node.neighbors {
             if !neighbor.discovered {
                 let path = findPath(from: neighbor, to: emoji)
                 if path.count > 0 {
                     return [node] + path
                 }
             }
         }
         return []
     }
 */


//: [Next](@next)
