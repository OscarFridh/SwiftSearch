/*:
 [Previous](@previous)
 # Cycles
 When searching a graph with cycles it is important to avoid getting stuck in an infinite loop.
 In order to do this we mark nodes as discovered as we visit them.
 If a neighbor has already been discovered we can avoid visiting it again and thereby escaping the cycle.
 
 Discovered nodes are shown in purple.
 */

import PlaygroundSupport

// TODO: Ev. Förklara varför try behövs?

func findPath(from node: Node, to emoji: String) throws -> [Node] {
    node.discovered = true
    if try node.checkEmoji() == emoji {
        return [node]
    }
    if node.neighbor?.discovered == false {
        let path = try findPath(from: node.neighbor!, to: emoji)
        if path.count > 0 {
            return [node] + path
        }
    }
    return []
}


// The following emojis can be found: 🐒🙋🏻‍♂️🤖
let emoji = "🏆"
let searchResult = Level.search(for: emoji, using: findPath)
let view = View.create(searchResult: searchResult, speed: 1)
// TODO: view.colors.discoveredCircle = #colorliteral ...
PlaygroundSupport.PlaygroundPage.current.liveView = view
/*:
 If you try to find the path to an emoji that is not present, the algorithm ends up searching the entire graph before it returns. In that case there is no path to the target (represented by an empty array) and no path to show in green (or red) at the end.
 */

//: [Next](@next)
