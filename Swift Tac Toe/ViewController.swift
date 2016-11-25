//
//  ViewController.swift
//  Swift Tac Toe
//
//  Created by KOemxe on 11/20/16.
//  Copyright © 2016 KOemxe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var ticTacImg1: UIImageView!
    @IBOutlet var ticTacImg2: UIImageView!
    @IBOutlet var ticTacImg3: UIImageView!
    @IBOutlet var ticTacImg4: UIImageView!
    @IBOutlet var ticTacImg5: UIImageView!
    @IBOutlet var ticTacImg6: UIImageView!
    @IBOutlet var ticTacImg7: UIImageView!
    @IBOutlet var ticTacImg8: UIImageView!
    @IBOutlet var ticTacImg9: UIImageView!

    @IBOutlet var ticTacButton1: UIButton!
    @IBOutlet var ticTacButton2: UIButton!
    @IBOutlet var ticTacButton3: UIButton!
    @IBOutlet var ticTacButton4: UIButton!
    @IBOutlet var ticTacButton5: UIButton!
    @IBOutlet var ticTacButton6: UIButton!
    @IBOutlet var ticTacButton7: UIButton!
    @IBOutlet var ticTacButton8: UIButton!
    @IBOutlet var ticTacButton9: UIButton!
    
    @IBOutlet var resetButton: UIButton!
    
    @IBOutlet var userMessage: UILabel!
    
    var plays = Dictionary<Int,Int>()
    var done = false
    var aiDeciding = false
    
    
    @IBAction func UIButtonClicked(_
        sender : UIButton) {
        userMessage.isHidden = true
        if !(plays[sender.tag] != nil) && !aiDeciding && !done {
            setImageForSpot(spot:sender.tag, player:1)
        }
        
        checkForWin()
        aiTurn()
    }
    
    func setImageForSpot(spot:Int,player:Int) {
        var playerMark = player == 1 ? "X" : "O"
        plays[spot] = player
        switch spot {
        case 1:
            ticTacImg1.image = UIImage(named: playerMark)
        case 2:
            ticTacImg2.image = UIImage(named: playerMark)
        case 3:
            ticTacImg3.image = UIImage(named: playerMark)
        case 4:
            ticTacImg4.image = UIImage(named: playerMark)
        case 5:
            ticTacImg5.image = UIImage(named: playerMark)
        case 6:
            ticTacImg6.image = UIImage(named: playerMark)
        case 7:
            ticTacImg7.image = UIImage(named: playerMark)
        case 8:
            ticTacImg8.image = UIImage(named: playerMark)
        case 9:
            ticTacImg9.image = UIImage(named: playerMark)
        default:
            ticTacImg5.image = UIImage(named: playerMark)
        }
    }
    
    @IBAction func resetButtonClicked(_
        sender:UIButton) {
        done = false
        resetButton.isHidden = true
        userMessage.isHidden = true
        reset()
    }
    
    func reset() {
        plays = [:]
        ticTacImg1.image = nil
        ticTacImg2.image = nil
        ticTacImg3.image = nil
        ticTacImg4.image = nil
        ticTacImg5.image = nil
        ticTacImg6.image = nil
        ticTacImg7.image = nil
        ticTacImg8.image = nil
        ticTacImg9.image = nil
    }
    
    func checkForWin(){
        var whoWon = ["I":0,"you":1]
        for(key,value) in whoWon{
            if(plays[7] == value && plays[8] == value && plays[9] == value ) || //across bottom
            (plays[4] == value && plays[5] == value && plays[6] == value ) || //across middle
            (plays[1] == value && plays[2] == value && plays[3] == value ) || //across top
            (plays[1] == value && plays[5] == value && plays[9] == value ) || //top left to bottom right
            (plays[3] == value && plays[5] == value && plays[7] == value ) || //top right to bottom left
            (plays[1] == value && plays[4] == value && plays[7] == value ) || //down on the left
            (plays[3] == value && plays[6] == value && plays[9] == value ) || //down on the right
            (plays[2] == value && plays[5] == value && plays[8] == value ) { //down on the middle
                userMessage.isHidden = false
                userMessage.text = "Looks like \(key) won!"
                resetButton.isHidden = false
                done = true
        }
        }
    }
    
    func checkBottom(value:Int) -> (location:String,pattern:String) {
        return ("bottom",checkFor(value: value, inList: [7,8,9]))
    }
    
    func checkMiddleAcross(value:Int) -> (location:String,pattern:String) {
        return ("middleAcross",checkFor(value: value, inList: [4,5,6]))
    }
    
    func checkTop(value:Int) -> (location:String,pattern:String) {
        return ("top",checkFor(value: value, inList: [1,2,3]))
    }
    
    func checkLeft(value:Int) -> (location:String,pattern:String) {
        return ("left",checkFor(value: value, inList: [1,4,7]))
    }
    
    func checkRight(value:Int) -> (location:String,pattern:String) {
        return ("right",checkFor(value: value, inList: [3,6,9]))
    }
    
    func checkMiddleDown(value:Int) -> (location:String,pattern:String) {
        return ("middleDown",checkFor(value: value, inList: [2,5,8]))
    }
    
    func checkDiagLeftRight(value:Int) -> (location:String,pattern:String) {
        return ("diagLeftRight",checkFor(value: value, inList: [1,5,9]))
    }
    
    func checkDiagRightLeft(value:Int) -> (location:String,pattern:String) {
        return ("diagRightLeft",checkFor(value: value, inList: [3,5,7]))
    }
    
    func checkFor(value:Int, inList:[Int]) -> String {
        var conclusion = ""
        for cell in inList {
            if plays[cell] == value {
                conclusion += "1"
            }
            else{
                conclusion += "0"
            }
        }
        return conclusion
    }
    
    func rowCheck(value:Int) -> (location:String, pattern:String)? {
        var acceptableFinds = ["011","110","101"]
        var findFuncs = [checkTop,checkBottom,checkLeft,checkRight,checkMiddleAcross,checkMiddleDown,checkDiagLeftRight,checkDiagRightLeft]
        for algorithm in findFuncs {
            var algorithmResults = algorithm(value)
            var match = acceptableFinds.index(of: algorithmResults.pattern)
            if (match != nil) {
                return algorithmResults
            }
        }
        return nil
    }
    
    func isOccupied(spot:Int) -> Bool {
        return (plays[spot] != nil)
    }
    
    func aiTurn(){
        if done {
            return
        }
        
        aiDeciding = true
        
        //Does the computer have two in a row?
        if let result = rowCheck(value:0) {
            var whereToPlayResult = whereToPlay(location: result.location,pattern:result.pattern)
            if !isOccupied(spot: whereToPlayResult){
                setImageForSpot(spot: whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
        }
        
        //Does the player have two in a row?
        if let result = rowCheck(value:1) {
            var whereToPlayResult = whereToPlay(location: result.location,pattern:result.pattern)
            if !isOccupied(spot: whereToPlayResult){
                setImageForSpot(spot: whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
        }
        
        // is center available?
        if !(isOccupied(spot: 5)) {
            setImageForSpot(spot: 5, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        func firstAvailable(isCorner:Bool) -> Int? {
            var spots = isCorner ? [1,3,7,9] : [2,4,6,8]
            for spot in spots {
                if !isOccupied(spot: spot) {
                    return spot
                }
            }
            return nil
        }
        
        // is corner available?
        if let cornerAvailable = firstAvailable(isCorner: true){
            setImageForSpot(spot: cornerAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        // is a side available?
        if let sideAvailable = firstAvailable(isCorner: false){
            setImageForSpot(spot: sideAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        userMessage.isHidden = false
        userMessage.text = "So this was a tie!"
        
        resetButton.isHidden = false
        
        aiDeciding = false
    }
    
    func whereToPlay(location:String,pattern:String) ->Int {
        var leftPattern = "011"
        var rightPattern = "110"
        var middlePattern = "101"
        
        switch location {
        case "top":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern {
                return 3
            }else {
                return 2
            }
        case "bottom":
            if pattern == leftPattern{
                return 7
            }else if pattern == rightPattern {
                return 9
            }else {
                return 8
            }
        case "left":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern {
                return 7
            }else {
                return 4
            }
        case "right":
            if pattern == leftPattern{
                return 3
            }else if pattern == rightPattern {
                return 9
            }else {
                return 6
            }
        case "middleAcross":
            if pattern == leftPattern{
                return 4
            }else if pattern == rightPattern {
                return 6
            }else {
                return 5
            }
        case "middleDown":
            if pattern == leftPattern{
                return 2
            }else if pattern == rightPattern {
                return 8
            }else {
                return 5
            }
        case "diagLeftRight":
            if pattern == leftPattern{
                return 1
            }else if pattern == rightPattern {
                return 9
            }else {
                return 5
            }
        case "diagRightLeft":
            if pattern == leftPattern{
                return 3
            }else if pattern == rightPattern {
                return 7
            }else {
                return 5
            }
        default:
            return 4
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
