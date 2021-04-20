/*:
 [Previous](@previous)
 
 # On a larger gaph
 Finally, let's compare and see how the two algorithms perform on a larger graph!
 
 
 Run this page twice, change the search algorithm to be used in between.
 
 */

import PlaygroundSupport

let emoji = "🍀"
let searchResult = Level.search(for: emoji, using: .dfs)
let view = View.create(searchResult: searchResult, speed: 2)
PlaygroundSupport.PlaygroundPage.current.liveView = view

/*:
 - Experiment: Search for another emoji
 
 The following ones can be found: 🕵️🤖😍🏆🐒🙋🏻‍♂️🎉🍀🌎🍕🏸🏄‍♂️👨🏻‍💻🎸🎹🏊‍♂️
 */

/*:
 ## Conclusion
 If we need to find the shortest path between two nodes in this type of graph, use BFS.
 BFS is able to always find the shortest path due to the nature of how it searches.
 If we do not need to find the shortest path, DFS works just as well.
*/

/*:
 >A shorter path does not mean that we find the emoji faster.
*/



//: [Next](@next)
