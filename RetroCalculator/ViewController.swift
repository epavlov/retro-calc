//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Eugene on 12/7/16.
//  Copyright © 2016 Ievgenii Pavlov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	var btnSound: AVAudioPlayer!
	
	var runningNumber = ""
	var leftValString = ""
	var rightValString = ""
	var result = ""
	
	enum Operation: String {
		case Divide = "/"
		case Multiply = "*"
		case Subtract = "-"
		case Add = "+"
		case Empty = "Empty"
	}
	
	var currentOperation = Operation.Empty
	
	@IBOutlet weak var resultLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Get path to the button sound
		let pathToBtnSound = Bundle.main.path(forResource: "btn", ofType: "wav")
		let soundURL = URL(fileURLWithPath: pathToBtnSound!)
		
		// If sound file exist, create AVAudioPlayer object with path to audio file
		do {
			try btnSound = AVAudioPlayer(contentsOf: soundURL)
		} catch let err as NSError {
			// Swallow
			print(err.debugDescription)
		}
	}
	
	/**
		IBAction to play audio sound attached to every 'number' buttons
		- parameter sender: UIButton
	*/
	@IBAction func numberPressed(sender: UIButton) {
		playSound()
		
		runningNumber += "\(sender.tag)"
		resultLabel.text = runningNumber
	}
	
	/**
		Function to play button tap sound
		
		- returns: void()
	*/
	func playSound() {
		if btnSound.isPlaying {
			btnSound.stop()
		}
		btnSound.play()
	}
	
	@IBAction func onDividePressed(sender: AnyObject) {
		processOperation(operation: .Divide)
	}
	
	@IBAction func onMultiplyPressed(sender: AnyObject) {
		processOperation(operation: .Multiply)
	}
	
	@IBAction func onSubtractPressed(sender: AnyObject) {
		processOperation(operation: .Subtract)
	}
	
	@IBAction func onAddPressed(sender: AnyObject) {
		processOperation(operation: .Add)
	}
	
	@IBAction func onEqualPressed(sender: AnyObject) {
		processOperation(operation: currentOperation)
	}
	
	@IBAction func onClearPressed(sender: AnyObject) {
		playSound()
		resetCalc()
	}
	
	/**
	Main calc logic
	- parameter operation: pressed operation
	- returns: void()
	*/
	func processOperation(operation: Operation) {
		playSound()
		
		if currentOperation != Operation.Empty {
			if runningNumber != "" {
				// Number button was tapped
				rightValString = runningNumber
				runningNumber = ""
				
				switch currentOperation {
				case Operation.Multiply:
					result = "\(Double(leftValString)! * Double(rightValString)!)"
					break
				case Operation.Divide:
					if rightValString == "0" {
						resetCalc()
						resultLabel.text = "Err: division by 0"
					} else {
						result = "\(Double(leftValString)! / Double(rightValString)!)"
					}
					break
				case Operation.Subtract:
					result = "\(Double(leftValString)! - Double(rightValString)!)"
					break
				case Operation.Add:
					result = "\(Double(leftValString)! + Double(rightValString)!)"
					break
				default: break // swallow
				}
				
				if resultLabel.text != "Err: division by 0" {
					leftValString = result
					resultLabel.text = result
				}
			}
			if resultLabel.text != "Err: division by 0" { currentOperation = operation }
		} else {
			// This is the first time an operation has been pressed
			leftValString = runningNumber
			runningNumber = ""
			currentOperation = operation
		}
	}
	
	/**
	Function to clear calc and reset all values
	
	- returns: void()
	*/
	func resetCalc() {
		resultLabel.text = "0"
		result = ""
		runningNumber = ""
		leftValString = ""
		rightValString = "";
		currentOperation = Operation.Empty
	}
}

