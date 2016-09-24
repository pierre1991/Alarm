//
//  TimerViewController.swift
//  Alarm
//
//  Created by Pierre on 9/15/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: Properties
    var countdownTimer = CountdownTimer()
    
    var isPaused = false
    
    
    //MARK: IBOutlets
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!

    @IBOutlet weak var pickerStackView: UIStackView!
    @IBOutlet weak var hourPickerView: UIPickerView!
    @IBOutlet weak var minutePickerView: UIPickerView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
        
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layoutIfNeeded()
        
        minutePickerView.selectRow(1, inComponent: 0, animated: false)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.updateTimerView), name: NSNotification.Name.init(rawValue: CountdownTimer.kSecondsTick), object: countdownTimer)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.timerComplete), name: NSNotification.Name.init(rawValue: CountdownTimer.kTimerComplete), object: countdownTimer)
        
        
        hourPickerView.tintColor = .white
        minutePickerView.tintColor = .white
    }

    
    //MARK: IBActions
    @IBAction func startButtonTapped(_ sender: AnyObject) {
        if !countdownTimer.isOn {
        	startTimer()
        } else if countdownTimer.isOn {
            countdownTimer.pauseTimer()
            startButton.setTitle("resume", for: .normal)
        }
    }

    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        if countdownTimer.isOn {
            countdownTimer.stopTimer()
            switchToPickerView()
        }
    }
    
    
    //MARK: PickerView Protocol Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == hourPickerView {
            return 24
        } else if pickerView == minutePickerView {
            return 60
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: String(row), attributes: [NSForegroundColorAttributeName:UIColor.white])
    }
    
    

    //MARK: Helper Functions
    func startTimer() {
        if countdownTimer.isOn {
            countdownTimer.stopTimer()
            switchToPickerView()
        } else {
            switchToTimerLabelView()
            
            let hours = hourPickerView.selectedRow(inComponent: 0)
            let minutes = minutePickerView.selectedRow(inComponent: 0) + (hours * 60)
            let totalSecondsSet = TimeInterval(minutes * 60)
            
            countdownTimer.setTimer(seconds: totalSecondsSet, totalSeconds: totalSecondsSet)
            updateTimerView()
            countdownTimer.startTimer()
        }
    }
    
    func updateTimerLabel() {
        timerLabel.text = countdownTimer.timeString
    }
    
    func timerComplete() {
        switchToTimerLabelView()
    }
    
    func updateTimerView() {
        updateTimerLabel()
        updateProgressView()
    }
    
    func switchToTimerLabelView() {
        pickerStackView.isHidden = true
        
        timerLabel.isHidden = false
        
        progressView.setProgress(0.0, animated: true)
        progressView.isHidden = false
        
        startButton.setTitle("Pause", for: .normal)
    }
    
    func switchToPickerView() {
        pickerStackView.isHidden = false
        
        timerLabel.isHidden = true
        
        progressView.isHidden = true
        
        startButton.setTitle("Start", for: .normal)
    }
    
    
    //MARK: Progress View
    func updateProgressView() {
        let secondsElapsed = countdownTimer.totalSeconds - countdownTimer.seconds
        let progress = Float(secondsElapsed) / Float(countdownTimer.totalSeconds)
        
        progressView.setProgress(progress, animated: true)
    }

}
