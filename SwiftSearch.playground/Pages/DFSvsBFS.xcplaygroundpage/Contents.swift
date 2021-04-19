/*:
 [Previous](@previous)
 # DFS vs BFS
 Let's compare the two algorithms and see how they perform on a larger graph!
 */

import PlaygroundSupport


let searchAlgorithms = [dfs, bfs]

// Det är bra att demonstrera var för sig (svårt att följa 2 st samtidigt --> Bespara mig själv lite jobb)
// Däremot kan det var a bra att byta ut A,B,C till emojis eftersom vi inte kopplar de till någon naturlig ordning


// BFS hittar den kortaste vägen! Därmed är det inte sagt att själva sökningen går snabbare.


// TODO: Enum overloading snyggare!
let view = View.create(target: "J", searchAlgorithm: searchAlgorithms[1], speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view


//: [Next](@next)
