//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var screenSize:CGRect!
    var screenWidth:CGFloat!
    var screenHeight: CGFloat!
    var currentPhrase: UILabel!
    var incorrectGuesses: UILabel!
    var guesses = [Character(" ")]
    var input:UITextField!
    var button: UIButton!
    var phrase: String!
    var incorrect = 0
    var PIC: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Leave Game", style: .plain, target: self, action: #selector(reset))
        //
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        PIC = UIImageView()
        PIC.image = UIImage(named: "hangman1.gif")
        PIC.backgroundColor = UIColor.white
        PIC.frame = CGRect(x:screenWidth/4.0,y:screenHeight/10.0, width:screenWidth/2.0, height:screenWidth/2.0)
        self.view.addSubview(PIC)
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        incorrectGuesses = UILabel()
        incorrectGuesses.frame = CGRect(x:0,y: screenHeight/2.0 ,width: screenWidth,height:screenHeight/5.0)
        incorrectGuesses.backgroundColor = UIColor.blue
        incorrectGuesses.textColor = UIColor.white
        incorrectGuesses.text  = "Incorrect Guess:"
        self.view.addSubview(incorrectGuesses)
        
        
        currentPhrase = UILabel()
        currentPhrase.frame = CGRect(x:0, y:screenHeight/3.0, width:screenWidth, height:screenHeight/6.0)
        var text:String = ""
        for guess:Character in guesses {
            for c in (phrase?.characters)! {
                if c == " " {
                    text += " "
                } else if (guess == c) {
                    text += String(guess)
                } else {
                    text += "-"
                }
                
            }
        }
        currentPhrase.textColor = UIColor.red
        currentPhrase.text = text
        currentPhrase.textAlignment = .center
        currentPhrase.backgroundColor = UIColor.green
        print(text)
        self.view.addSubview(currentPhrase)
        
        //Input UIText
        input = UITextField()
        input.frame = CGRect(x:0, y:screenHeight*6.0/8.0, width:screenWidth, height:screenHeight/6.0)
        self.view.addSubview(input)
        input.backgroundColor = UIColor.lightGray
        
        //Guess Button
        button = UIButton()
        button.frame = CGRect(x:0, y:screenHeight*7.0/10.0, width:screenWidth, height:screenHeight/12.0)
        button.setTitle("Guess", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: "updateNewGuess", for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
        
//        // Add Label
//        let label = UILabel()
//        label.text = "Hangman g"
//        label.frame = CGRect(x:screenWidth/4.0,y:screenHeight/5.0,width:screenWidth/2.0, height:screenHeight/5.0)
//        self.view.addSubview(label)
//        
//        // Add Button
//        let button = UIButton()
//        button.setTitle("Start New Game", for: .normal)
//        button.frame = CGRect(x:screenWidth/4.0,y:screenHeight*2.0/5.0,width:screenWidth/2.0, height:screenHeight/5.0)
////        button.addTarget(<#T##target: Any?##Any?#>, action: Selector, for: UIControlEvents.touchUpInside)
//        button.setTitleColor(UIColor.black, for: .normal)
//        self.view.addSubview(button)
    }
    
    func updateNewGuess() {
        var winState = true
        if String(describing: input.text!).characters.count > 1 {
            let alert = UIAlertController(title: "Guess must only be One Character", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.input.text = ""
            return
        }
        
        guesses.append(Character((input.text?.uppercased())!))
        var newtext:String = ""
        if phrase.contains((input.text?.uppercased())!) == false {
            incorrectGuesses.text? += " " + String(guesses[guesses.count-1])
            incorrect += 1
            
        }
        for c in (phrase?.characters)! {
            var match = false
            for guess:Character in guesses {
                if match {
                    continue
                }
                if c == " " {
                    newtext += " "
                    match = true
                } else if (guess == c) {
                    newtext += String(guess)
                    match = true
                }
            }
            if !match {
                newtext += "-"
                winState = false
            }
        }
        if winState {
            let alert = UIAlertController(title: "You Win!!", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // Remove UI Text field add button
            input.removeFromSuperview()
            button.removeFromSuperview()
            let f = button.frame
            button = UIButton()
            button.frame = f
            button.setTitle("Start Over", for: .normal)
            button.addTarget(self, action: "reset", for: UIControlEvents.touchUpInside)
            self.view.addSubview(button)
            return
        }
        PIC.image = UIImage(named: "hangman\(incorrect+1).gif")
        currentPhrase.text = newtext
        if incorrect == 6 {
            let alert = UIAlertController(title: "You Lose!!", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // Remove UI Text field add button
            input.removeFromSuperview()
            button.removeFromSuperview()
            let f = button.frame
            button = UIButton()
            button.frame = f
            button.setTitle("Start Over", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = UIColor.cyan
            button.addTarget(self, action: "reset", for: UIControlEvents.touchUpInside)
            self.view.addSubview(button)
            return
        }
    }
    func reset() {
        navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
