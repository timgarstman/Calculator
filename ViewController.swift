//
//  ViewController.swift
//  Calculator
//
//  Created by Tim Garstman on 24-11-15.
//  Copyright © 2015 Tim Garstman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //Display van de rekenmachine
    @IBOutlet weak var display: UILabel!
    
    //Geschiedenis van de rekenmachine
    @IBOutlet weak var history: UILabel!                    //history

    
    //Variable instellen voor het typen van de gebruiker
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    
    //link naar CalculatorBrian
    var brain = CalculatorBrain()
    
    
    //Toevoegen van een cijfer
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
            history.text = history.text! + digit            //history
        } else {
            display.text = digit
            history.text = digit                            //history
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    
    //Uitvoeren van een operator
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
                history.text = history.text! + operation    //history
            } else {
                displayValue = 0
            }
        }
    }
    
    
    //Klik op enter
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    
    //Toevoegen van een decimaal
    @IBAction func dot(sender: UIButton) {
        if (display.text!.rangeOfString(".") != nil) {
            return
        } else{
            display.text = display.text! + "."
        }
    }
    
    //Rekenmachine leeg maken
    @IBAction func Clear(sender: UIButton) {
        displayValue = 0
        brain.clear()
        enter()
    }
    
    
    
    //Het getal kan getallen na de decimaal bevatten = double
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
   


}