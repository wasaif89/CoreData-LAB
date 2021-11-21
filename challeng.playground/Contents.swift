import UIKit


func LongWord(word: String) -> String {
    let wordsArr = word.components(separatedBy: " ")
    var maxL = 0
    for index in 0..<(wordsArr.count) {
        if wordsArr[index].count > maxL {
            maxL = wordsArr[index].count
        }
    }
    return "\(maxL)"
}
LongWord(word: "The weather is nice today")

