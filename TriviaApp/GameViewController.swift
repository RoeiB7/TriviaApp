//
//  GameViewController.swift
//  TriviaApp
//
//  Created by Roei Berko on 21/05/2022.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var leftHeart: UIImageView!
    @IBOutlet weak var middleheart: UIImageView!
    @IBOutlet weak var rightHeart: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var gameNumber: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBOutlet weak var upperLeftAnswer: UIButton!
    @IBOutlet weak var lowerLeftAnswer: UIButton!
    @IBOutlet weak var upperRightAnswer: UIButton!
    @IBOutlet weak var lowerRightAnswer: UIButton!
    
    var question: Questions?
    var gameNum: Int = 0
    var score: Int = 0
    var mistakes: Int = 0
    var MAX_ROUNDS: Int = 0
    let MAX_MISTAKES: Int = 3

    
    struct Questions: Codable{
        let data: [Question]
    }
  
    struct Question: Codable {
        let optionalAnswers: [String]
        let imgURL: String
        let rightAnswer: String

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        MAX_ROUNDS = (question?.data.count)!
        startRound()
        
    }
    
    private func startRound(){
        if(mistakes == MAX_MISTAKES || gameNum == MAX_ROUNDS){
            NotificationCenter.default.post(name: Notification.Name("score"), object: String(score))
            dismiss(animated: true, completion: nil)
        }else{
            logoImage.image = Downloader.downloadImageWithURL(url: (question?.data[gameNum].imgURL)!)
          
            upperLeftAnswer.setTitle(question?.data[gameNum].optionalAnswers[0], for: .normal)
            upperRightAnswer.setTitle(question?.data[gameNum].optionalAnswers[1], for: .normal)
            lowerLeftAnswer.setTitle(question?.data[gameNum].optionalAnswers[2], for: .normal)
            lowerRightAnswer.setTitle(question?.data[gameNum].optionalAnswers[3], for: .normal)


        }
    }
    @IBAction func upperLeftClicked(_ sender: Any) {
        if(upperLeftAnswer.currentTitle == question?.data[gameNum].rightAnswer){
            score += 1
            gameNum += 1
            self.progressBar.setProgress(Float(Float(gameNum) / Float(MAX_ROUNDS)), animated: true)
            gameNumber.text = String(gameNum)
            startRound()
        }else{
            mistakes += 1
            gameNum += 1
            self.progressBar.setProgress(Float(Float(gameNum) / Float(MAX_ROUNDS)), animated: true)
            gameNumber.text = String(gameNum)
            if(mistakes == 1){
                rightHeart.isHidden = true
            }else if(mistakes == 2){
                middleheart.isHidden = true
            }else{
                leftHeart.isHidden = true
            }
            startRound()
        }
    }
    @IBAction func lowerLeftClicked(_ sender: Any) {
        if(lowerLeftAnswer.currentTitle == question?.data[gameNum].rightAnswer){
            score += 1
            gameNum += 1
            self.progressBar.setProgress(Float(Float(gameNum) / Float(MAX_ROUNDS)), animated: true)
            gameNumber.text = String(gameNum)
            startRound()
        }else{
            mistakes += 1
            gameNum += 1
            self.progressBar.setProgress(Float(Float(gameNum) / Float(MAX_ROUNDS)), animated: true)
            gameNumber.text = String(gameNum)
            if(mistakes == 1){
                rightHeart.isHidden = true
            }else if(mistakes == 2){
                middleheart.isHidden = true
            }else{
                leftHeart.isHidden = true
            }
            startRound()
        }
    }
    @IBAction func upperRightClicked(_ sender: Any) {
        if(upperRightAnswer.currentTitle == question?.data[gameNum].rightAnswer){
            score += 1
            gameNum += 1
            self.progressBar.setProgress(Float(Float(gameNum) / Float(MAX_ROUNDS)), animated: true)
            gameNumber.text = String(gameNum)
            startRound()
        }else{
            mistakes += 1
            gameNum += 1
            self.progressBar.setProgress(Float(Float(gameNum) / Float(MAX_ROUNDS)), animated: true)
            gameNumber.text = String(gameNum)
            if(mistakes == 1){
                rightHeart.isHidden = true
            }else if(mistakes == 2){
                middleheart.isHidden = true
            }else{
                leftHeart.isHidden = true
            }
            startRound()
        }
    
    }
    @IBAction func lowerRightClicked(_ sender: Any) {
        if(lowerRightAnswer.currentTitle == question?.data[gameNum].rightAnswer){
            score += 1
            gameNum += 1
            self.progressBar.setProgress(Float(Float(gameNum) / Float(MAX_ROUNDS)), animated: true)
            gameNumber.text = String(gameNum)
            startRound()
        }else{
            mistakes += 1
            gameNum += 1
            self.progressBar.setProgress(Float(Float(gameNum) / Float(MAX_ROUNDS)), animated: true)
            gameNumber.text = String(gameNum)
            if(mistakes == 1){
                rightHeart.isHidden = true
            }else if(mistakes == 2){
                middleheart.isHidden = true
            }else{
                leftHeart.isHidden = true
            }
            startRound()
        }
    }
    
    
    private func parseJSON(){
        guard let path = Bundle.main.path(
            forResource: "questions",
            ofType: "json")
        else{
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do{
            let jsonData = try Data(contentsOf: url)
            question = try JSONDecoder().decode(Questions.self, from: jsonData)
        }
        catch{
            print("Error: \(error)")
        }
    }
    
}

class Downloader {
    
    class func downloadImageWithURL(url: String) -> UIImage! {
        
        let date = NSData(contentsOf: URL(string: url)!)
        return UIImage(data: date! as Data)
    }
}


