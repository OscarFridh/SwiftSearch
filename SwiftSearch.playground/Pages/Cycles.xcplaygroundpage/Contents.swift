/*:
 [Previous](@previous)
 # Cycles
 When searching a graph with cycles it is important to avoid getting stuck in an infinite loop.
 In order to do this we mark nodes as discovered as we visit them.
 If a neighbor has already been discovered we can avoid visiting it again and thereby escaping the cycle.
 
 Discovered nodes are shown in purple.
 */

import PlaygroundSupport

func findPath(from node: Node, to emoji: String) -> [Node] {
    node.discovered = true
    if node.emoji == emoji {
        return [node]
    } else if node.neighbor?.discovered == false {
        let path = findPath(to: emoji, from: node.neighbor!)
        if path.count > 0 {
            return [node] + path
        }
    }
    return []
}


// The following emojis can be found: 🐒🙋🏻‍♂️🤖
let view = View.create(target: "🏆", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view

/*:
 If you try to find the path to an emoji that is not present, the algorithm ends up searching the entire graph before it returns. In that case there is no path to the target (represented by an empty array) and no path to show in green (or red) at the end.
 */

//: [Next](@next)
