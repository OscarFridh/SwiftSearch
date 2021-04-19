/*:
 [Previous](@previous)
 # DFS vs BFS
 Let's compare the two algorithms and see how they perform on a larger graph!
 */

import PlaygroundSupport

// Det är bra att demonstrera var för sig (svårt att följa 2 st samtidigt --> Bespara mig själv lite jobb)
// Däremot kan det var a bra att byta ut A,B,C till emojis eftersom vi inte kopplar de till någon naturlig ordning


// BFS hittar den kortaste vägen! Därmed är det inte sagt att själva sökningen går snabbare.


// The following emojis can be found: 🕵️🤖😍🏆🐒🙋🏻‍♂️🎉🍀🌎🍕🏸🏄‍♂️👨🏻‍💻🎸🎹🏊‍♂️
let view = View.create(target: "🍀", searchAlgorithm: .bfs, speed: 2)
PlaygroundSupport.PlaygroundPage.current.liveView = view


//: [Next](@next)
