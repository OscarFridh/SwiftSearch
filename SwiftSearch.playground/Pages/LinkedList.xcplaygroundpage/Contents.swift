/*:
 [Previous](@previous)
 # Linked List
 
 We are given a list of nodes where each node hides an emoji.
 Our task is to find the path leading from the start of the list to a certain emoji.
 We do this by recursively going down the list until we find the right emoji.
 Then the path can be retreived as we go back.
 
 A node's neighbor points to the next node in the list. We know that we have reached the end of the list when we come to a node that does not have a neighbor.
 */

import PlaygroundSupport

func findPath(to emoji: String, from node: Node) -> [Node] {
    if node.emoji == emoji {
        return [node]
    } else if let neighbor = node.neighbor {
        let path = findPath(to: emoji, from: neighbor)
        if path.count > 0 {
            return [node] + path
        }
    }
    return []
}

let view = View.create(target: "🐒", searchAlgorithm: findPath, speed: 1)
PlaygroundSupport.PlaygroundPage.current.liveView = view

/*:
 - Experiment: Search for another emoji
 
 The following ones can be found: 🐒🙋🏻‍♂️🤖
 */


/*:
 The path returned by the search algorithm is shown at the end of the animation. If the path is valid and leads to the right destination it is shown in green, otherwise it is shown in red.
 */




//: [Next](@next)
