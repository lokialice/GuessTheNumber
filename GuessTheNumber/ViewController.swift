//
//  ViewController.swift
//  GuessTheNumber
//
//  Created by Macbook Pro MD102 on 9/5/15.
//  Copyright (c) 2015 Loki. All rights reserved.
//

import UIKit

private extension ViewController{
    enum Comparison{
        case Smaller
        case Greater
        case Equals
    }
    func selectedNumber(number: Int) {
        switch compareNumber(number, otherNumber: secretNumber){
        case .Equals:
            var alert = UIAlertController(title: nil, message: "You won \(numberGuesses) guesses!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
        cmd in self.reset()
        self.txtNumber.text = " "
        }))
            self.presentViewController(alert, animated: true, completion: nil)
        case .Smaller:
            lowerBound = max(lowerBound,number)
            messagelbl.text = "You last guess was too low"
            txtNumber.text  = ""
            numberGuesses++
            renderRange()
            renderNumGuesses()
        case .Greater:
           upperBound = min(upperBound,number)
            messagelbl.text = "You last guess too high"
            txtNumber.text = ""
            numberGuesses++
            renderRange()
            renderNumGuesses()
        
        default:
            println("Try again!!!")
        }
    }
    
    func compareNumber(number: Int, otherNumber: Int) -> Comparison {
            if number < otherNumber {
                return .Smaller
            }else if number > otherNumber {
                return .Greater
            }
            return .Equals
    }
}
private extension ViewController{
            func extractSecretNumber() {
                let diff = upperBound - lowerBound
                let ranomNumber = Int(arc4random_uniform(UInt32(diff)))
                secretNumber = ranomNumber + Int(lowerBound)
            }
            func renderRange() {
                rangelbl.text  = "Guess a Number between \(lowerBound) and \(upperBound)"
            }
            func renderNumGuesses() {
                numberGuesseslbl.text = "Number of guesses: \(numberGuesses)"
            }
            func resetData() {
                lowerBound = 0
                upperBound = 100
                numberGuesses = 0
            }
            func resetMsg() {
                messagelbl.text = ""
            }
            func reset(){
            resetData()
            renderRange()
            renderNumGuesses()
            extractSecretNumber()
            resetMsg()
            }
}

class ViewController: UIViewController {

    private var lowerBound = 0
    private var upperBound = 100
    private var numberGuesses = 0
    private var secretNumber = 0
    
    @IBOutlet var rangelbl: UILabel!
    
    @IBOutlet var txtNumber: UITextField!
    
    @IBAction func btnOK(sender: UIButton) {
    let number = txtNumber.text.toInt()
                if let number = number {
                    selectedNumber(number)
                }else {
                    var alert = UIAlertController(title:nil, message: "Enter a number", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
    }
    
    @IBOutlet var numberGuesseslbl: UILabel!
    @IBOutlet var messagelbl: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtNumber.becomeFirstResponder()
        reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

