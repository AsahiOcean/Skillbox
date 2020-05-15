import Foundation

struct Emotion {
    var name = ""
    var power = 0
}

func + (left: Emotion, right: Emotion) -> Emotion {
    return Emotion(name: left.name  + " " + right.name, power: left.power + right.power)
}

let newEmotion = Emotion(name: "Happy", power: 10) + Emotion(name: "Joy", power: 7)
newEmotion.name
newEmotion.power

infix operator ~>
func ~>(left: Emotion, right: Emotion) -> Emotion {
    return Emotion(name: right.name, power: left.power + right.power)
}

let newEmotion2 = Emotion(name: "Happy", power: 10) ~> Emotion(name: "Joy", power: 7)
newEmotion2.name
newEmotion2.power

postfix operator ^
postfix func ^(value: Int) -> Int {
    return value * value
}

7^
(7^)^

prefix operator *
prefix func *(value: Int) -> Int {
    return value * value
}
*7
*(*7)
