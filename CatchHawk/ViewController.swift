//
//  ViewController.swift
//  CatchHawk
//
//  Created by Yılmaz Karaağaç on 12/26/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var timer = Timer()
    var currentScore = 0
    var counter = 10
    let screenSize: CGRect = UIScreen.main.bounds
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        initializeHighScore()
        timerLabel.text = "\(counter)"
        startTimer()
        setTapGestureToImageView()
    }
    
    @objc func setRemainTime() {
        setRandomLocationToImage()
        if counter > -1 {
            timerLabel.text = "\(counter)"
        }
        else {
            timer.invalidate()
            initializeHighScore()
            makeAlert()
            
        }
        counter -= 1
    }
    
    @objc func IncreaseScore() {
        if counter > 0 {
            currentScore += 1
            currentScoreLabel.text = "Score: \(currentScore)"
        }
    }
    
    func setRandomLocationToImage() {
        let randomX = CGFloat.random(in: CGFloat(10)...CGFloat((screenSize.width) - 10 - imageView1.bounds.size.width))
        let randomY = CGFloat.random(in: CGFloat(100)...CGFloat((screenSize.height) - 150 - imageView1.bounds.size.height))
        imageView1.transform = CGAffineTransform(translationX: randomX, y: randomY)
        imageView1.image = UIImage(named: "hawk")
    }
    
    func makeAlert() {
        let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
            //ok button clicked
            print("OK button clicked")
        }
        
        let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
            //replay button clicked
            self.counter = 10
            self.restartGame()
        }
        
        alert.addAction(okButton)
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func restartGame() {
        currentScore = 0
        currentScoreLabel.text = "Score: \(currentScore)"
        startTimer()
    }
    
    func initializeHighScore() {
        if let highScore = UserDefaults.standard.object(forKey: "highScore1") as? Int {
            if highScore < currentScore {
                setHighScore(score: currentScore)
            } else {
                setHighScore(score: highScore)
            }
            
        }
        else {
            UserDefaults.standard.set(0, forKey: "highScore1")
        }
    }
    
    func setHighScore(score: Int) {
        highScoreLabel.text = "High Score: \(score)"
        UserDefaults.standard.set(score, forKey: "highScore1")
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setRemainTime), userInfo: nil, repeats: true)
    }
    
    func setTapGestureToImageView() {
        imageView1.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IncreaseScore))
        imageView1.addGestureRecognizer(gestureRecognizer)
    }

}

