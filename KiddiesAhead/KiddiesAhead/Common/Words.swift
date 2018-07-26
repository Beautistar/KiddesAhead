//
//  Words.swift
//  KiddiesAhead
//
//  Created by sts on 3/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import Foundation



enum WORDS : String, EnumCollection {
    
    // alphabet 0 ~
    case a          // 0
    case b
    case c
    case d
    case e
    case f
    case g
    case h
    case i
    case j
    case k
    case l
    case m
    case n
    case o
    case p
    case q
    case r
    case s
    case t
    case u
    case v
    case w
    case x
    case y
    case z
    
    // greeting 26 ~
    case hello
    case bye
    case well_done
    
    // weather 29 ~
    case sun
    case rain
    case cloud
    case hot
    case snow
    case windy
    case storm
    case cold
    
    // color 37 ~
    case red
    case white
    case pink
    case green
    case orange
    case black
    case blue
    case brown
    case gray
    case purple
    case yellow
    case beige

    // clothing 49 ~
    case boots
    case coat
    case dress
    case gloves
    case hat
    case jacket
    case jumper
    case pajamas
    case trousers
    case scarf
    case shirt
    case shoes
    case shorts
    case skirt
    case socks
    case sweater
    case t_shirt

    // family 66 ~
    case father
    case mother
    case grandfather
    case grandmother
    case brother
    case sister
    case baby
    
    // furniture    73 ~
    case bath_tub
    case bed
    case dinner_table_
    case hairbrush
    case sink
    case soap
    case sofa
    case stairs
    case toothbrush
    case toothpaste
    case tv
    case rug
    case window
    case chair
    case wardrobe
    
    // fruit 88 ~
    case apple
    case banana
    case cherries
    case grapefruit
    case grapes
    case lemon
    case melon
    case orange_
    case pear
    case pineapple
    case strawberry

    // animal   99 ~
    case bird
    case cat
    case chicken
    case dog
    case duck
    case fish
    case frog
    case hamster
    case horse
    case mouse
    case pig
    case rabbit
    case sheep
    case turtle
    case fox
    case goat
    case squirrel
    case monkey
    case kangaroo
    case giraffe
    case panda
    case lion
    case tiger
    case elephant
    case snake
    case alligator
    case koala
    case bear
    case zebra
    case hippo
    case rhino
    case seal
    case whale
    case shark
    case walrus
    case penguin
    
    // transportation 135 ~
    case airplane
    case bicycle
    case boat
    case bus
    case car
    case helicopter
    case motorcycle
    case taxi
    case train
    case truck

    // food 145 ~
    case bread
    case broccoli
    case cake
    case lollipop
    case carrot
    case cheese
    case chicken_
    case chocolate
    case cookie
    case corn
    case cucumber
    case egg
    case fish_
    case chips
    case ham
    case hamburger
    case hot_dog
    case ice_cream
    case jelly
    case lettuce
    case milk
    case nuts
    case onion
    case orange_juice
    case pancake
    case peas
    case pizza
    case salad
    case sandwich
    case sausage
    case spaghetti
    case toast
    case tomato
    case water
    case potatoes
    case rice

    // shape 181 ~
    case circle
    case square
    case triangle
    case rectangle
    case star
    case heart
    
    // body part 187 ~
    case arm
    //case back_
    //case belly_button
    case ear
    case elbow
    case eye
    case face
    case finger
    case foot
    case hair
    case hand
    case head
    case hips
    case knee
    case leg
    case lips
    //case mouth
    case neck
    case nose
    case shoulder
    case teeth
    case toe
    case tongue
    //case tummy

    // feeling 211 ~
    // feeling 207 ~
    case angry
    case bored
    case fine
    case great
    case happy
    case sad
    case scared
    case sick
    case tired

    // occupation 216 ~
    case chef
    case doctor
    case firefighter
    case judge
    case lifeguard
    case nurse
    case police_officer
    case postman
    case teacher
    
    // classroom 225 ~
    case book
    case chair_
    case classroom_
    case clock
    case colour_pencil
    case computer
    case crayon
    case desk
    case glue
    case paper
    case pen
    case pencil_case
    case pencil
    case ruler
    case schoolbag
    case scissors
    case stamp
    case sticker
    case table

    
    // number 244 ~
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case eleven
    case twelve
    case thirteen
    case fourteen
    case fifteen
    case sixteen
    case seventeen
    case eighteen
    case nineteen
    case twenty
    case twenty_one
    case twenty_two
    case twenty_three
    case twenty_four
    case twenty_five
    case twenty_six
    case twenty_seven
    case twenty_eight
    case twenty_nine
    case thirty
    case thirty_one
    case thirty_two
    case thirty_three
    case thirty_four
    case thirty_five
    case thirty_six
    case thirty_seven
    case thirty_eight
    case thirty_nine
    case forty
    case forty_one
    case forty_two
    case forty_three
    case forty_four
    case forty_five
    case forty_six
    case forty_seven
    case forty_eight
    case forty_nine
    case fifty
    case fifty_one
    case fifty_two
    case fifty_three
    case fifty_four
    case fifty_five
    case fifty_six
    case fifty_seven
    case fifty_eight
    case fifty_nine
    case sixty
    case sixty_one
    case sixty_two
    case sixty_three
    case sixty_four
    case sixty_five
    case sixty_six
    case sixty_seven
    case sixty_eight
    case sixty_nine
    case seventy
    case seventy_one
    case seventy_two
    case seventy_three
    case seventy_four
    case seventy_five
    case seventy_six
    case seventy_seven
    case seventy_eight
    case seventy_nine
    case eighty
    case eighty_one
    case eighty_two
    case eighty_three
    case eighty_four
    case eighty_five
    case eighty_six
    case eighty_seven
    case eighty_eight
    case eighty_nine
    case ninety
    case ninety_one
    case ninety_two
    case ninety_three
    case ninety_four
    case ninety_five
    case ninety_six
    case ninety_seven
    case ninety_eight
    case ninety_nine
    case one_hundred
    
    //case max    // 344
}

let NUMBER_STRING = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
     "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
     "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
     "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
     "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
     "51", "52", "53", "54", "55", "56", "57", "58", "59", "60",
     "61", "62", "63", "64", "65", "66", "67", "68", "69", "70",
     "71", "72", "73", "74", "75", "76", "77", "78", "79", "80",
     "81", "82", "83", "84", "85", "86", "87", "88", "89", "90",
     "91", "92", "93", "94", "95", "96", "97", "98", "99", "100"
    
]

func categoryValues(category : Int) -> [WORDS] {
    
    //let category_start = [0, 26, 29, 37, 49, 66, 73, 88, 99, 135, 145, 181, 187, 211, 220, 229, 248, 348]
    let category_start = [0, 26, 29, 37, 49, 66, 73, 88, 99, 135, 145, 181, 187, 207, 216, 225, 244, 344]
    
    var values = [WORDS]()
    
    for i in category_start[category]..<category_start[category+1] {
        values.append(WORDS.allValues[i])
    }
    
    return values
}

func indexOfWord(word : WORDS) -> Int {
    
    if let index = WORDS.allValues.index(of: word) {
        return index
    }
    
    return -1
}


public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var allValues: [Self] { get }
}

public extension EnumCollection {
    
    public static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    public static var allValues: [Self] {
        return Array(self.cases())
    }
}
























