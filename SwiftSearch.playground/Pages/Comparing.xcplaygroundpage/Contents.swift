/*:
 [Previous](@previous)
 
 # DFS vs BFS
 Let's see DFS in action again and compare it to another algorithm called BFS.
 
 Run this page once for both algorithms.
 */

import PlaygroundSupport

// Change this to see bfs in action
let searchAlgorithm = Algorithm.dfs


let searchResult = Level.search(for: "🤖", using: searchAlgorithm)
let view = View.create(searchResult: searchResult, speed: 1.5)
PlaygroundSupport.PlaygroundPage.current.liveView = view

/*:
 >The BFS algorithm finds the shortest path
 
 This is because it explores nodes ordered by distance to the starting point.
*/

/*:
 >A shorter path does not mean that we find the emoji faster.
*/


//: [Next](@next)
