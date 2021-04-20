/*:
 [Previous](@previous)
 
 # A larger gaph
 Let's see DFS and BFS one more time in a larger graph.
 
 Run this page once for each algorithm.
 */

import PlaygroundSupport

// Change this to see BFS in action
let searchAlgorithm = Algorithm.dfs

let emoji = "🍀"
let searchResult = Level.search(for: emoji, using: searchAlgorithm)
let view = View.create(searchResult: searchResult, speed: 2)
PlaygroundSupport.PlaygroundPage.current.liveView = view

/*:
 - Experiment: Search for another emoji
 
 The following ones can be found: 🕵️🤖😍🏆🐒🙋🏻‍♂️🎉🍀🌎🍕🏸🏄‍♂️👨🏻‍💻🎸🎹🏊‍♂️
 */

/*:
 ## Conclusion
 * If we need to find the shortest path between two nodes in a graph we should use BFS instead of DFS.
 * If we do not need to find the shortest path, DFS works just as well.
*/



//: [Next](@next)
