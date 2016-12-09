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

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let pathToBtnSound = Bundle.main.path(forResource: "btn", ofType: "wav")
		let soundURL = URL(fileURLWithPath: pathToBtnSound!)
		
		do {
			try btnSound = AVAudioPlayer(contentsOf: soundURL)
		} catch let err as NSError {
			print(err.debugDescription)
		}
	}
	
	@IBAction func numberPressed(sender: UIButton) {
		playSound()
	}
	
	func playSound() {
		if btnSound.isPlaying {
			btnSound.stop()
		}
		btnSound.play()
	}
}

