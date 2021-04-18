/*:
 [Previous](@previous)
 # DFS vs BFS
 Let's compare the two algorithms and see how they perform on a larger graph!
 */

import PlaygroundSupport


let searchAlgorithms = [dfs, bfs]

let view = View.create(target: "J", searchAlgorithm: searchAlgorithms[1], speed: 1)
// TODO: Stack or change SKScene on completion with a custom delegate!
PlaygroundSupport.PlaygroundPage.current.liveView = view


//: [Next](@next)
