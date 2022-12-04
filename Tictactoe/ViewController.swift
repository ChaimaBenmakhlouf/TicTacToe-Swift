//
//  ViewController.swift
//  Tictactoe
//
//  Created by Chaima Benmakhlouf on 04/03/2022.
//

import UIKit

class ViewController: UIViewController {
    var player1 = true
    var player2 = false
    
    var tabPlayer1: [Int] = []
    var tabPlayer2: [Int] = []
    
    var move = 0
    
    @IBOutlet weak var moveLabel: UILabel!
    
    @IBOutlet var buttonsCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonsCollection.forEach { button in
            button.setTitle("", for: .normal)
        }
    }


    @IBAction func buttonDidTap(_ sender: UIButton) {
        if player1 == true && player2 == false {
            setBox(button: sender, forPlayer: 1)
            tabPlayer1.append(sender.tag)
        } else if player2 == true && player1 == false {
            setBox(button: sender, forPlayer: 2)
            tabPlayer2.append(sender.tag)
        } else {
            print("error les 2 joueurs peuvent pas jouer en meme temps")
            return
        }
        move = move + 1
        moveLabel.text = String(move)
        checkVictory()
        changePlayerTurn()
    }
    
    private func setBox(button: UIButton, forPlayer player:Int) {
        if player == 1 {
            button.setImage(UIImage(named: "circle"), for: .normal)
            button.isEnabled = false
         
            
        } else if player == 2 {
            button.setImage(UIImage(named: "cross"), for: .normal)
            button.isEnabled = false
          
        } else {
            print("error le joueur \(player) n'existe pas")
        }
    }
    
    private func changePlayerTurn() {
        player1 = !player1
        player2 = !player2
    }
    
    private func checkVictory() {
        if player1DidWin() {
            presentWinner(player: 1)
        } else if player2DidWin() {
            presentWinner(player: 2)
        } else if move > 8 {
            alertDraw()
        }
    }
    
    private func player1DidWin() -> Bool {
        return checkArrayVictory(array: tabPlayer1)
    }
    
    private func player2DidWin() -> Bool {
        return checkArrayVictory(array: tabPlayer2)
    }
    
    private func presentWinner(player: Int) {
        let alertView = UIAlertController(title: "Victoire !", message: "Le joueur \(player) a gagné.", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Rejouez", style: .default, handler: { [weak self] _ in
            self?.playAgain()
        })
        //Add OK button to a dialog message
        alertView.addAction(confirmAction)
        // Present alert to user
        self.present(alertView, animated: true, completion: nil)
    }

    private func alertDraw() {
        let alertView = UIAlertController(title: "Match nul", message: "Tres bon combat, match nul", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Rejouez", style: .default, handler: { [weak self] _ in
            self?.playAgain()
        })
        //Add OK button to a dialog message
        alertView.addAction(confirmAction)
        // Present alert to user
        self.present(alertView, animated: true, completion: nil)
    }

    private func checkArrayVictory(array: [Int]) -> Bool {
        guard array.count >= 3 else {
            return false
        }
        if containsAll(array: array, subArray: [0, 1, 2]) {
            return true
        } else if containsAll(array: array, subArray: [3, 4, 5]) {
            return true
        } else if containsAll(array: array, subArray: [6, 7, 8]) {
            return true
        } else if containsAll(array: array, subArray: [0, 3, 6]) {
            return true
        } else if containsAll(array: array, subArray: [1, 4, 7]) {
            return true
        } else if containsAll(array: array, subArray: [2, 5, 8]) {
            return true
        } else if containsAll(array: array, subArray: [0, 4, 8]) {
            return true
        } else if containsAll(array: array, subArray: [2, 4, 6]) {
            return true
        }
        return false
    }
    
    private func playAgain() {
        tabPlayer1 = []
        tabPlayer2 = []
        move = 0
        moveLabel.text = String(move)
        player1 = true
        player2 = false
        for button in buttonsCollection {
            button.setImage(UIImage(), for: .normal)
            button.isEnabled = true
        }
    }
    
    func containsAll(array: [Int], subArray: [Int]) -> Bool {
        for element in subArray {
            if !array.contains(element) {
                return false
            }
        }
        return true
    }
}

