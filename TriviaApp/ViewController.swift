//
//  ViewController.swift
//  TriviaApp
//
//  Created by Roei Berko on 20/05/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameScoreLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameScoreLBL.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("score"), object: nil)
    }
    
    @objc func didGetNotification(_ notification: Notification){
        let score = notification.object as! String?
        gameScoreLBL.isHidden = false
        gameScoreLBL.text = "Latest game score: " + score!
    }

    @IBAction func startGame(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "gameVC") as? GameViewController else{
            return
        }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
    
}

