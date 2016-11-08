//
//  StartScreenViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    var screenSize:CGRect!
    var screenWidth:CGFloat!
    var screenHeight: CGFloat!
    var button:UIButton?
    var label: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        // Add Label
        let label = UILabel()
        label.text = "Hangman"
        label.textAlignment = .center
        label.frame = CGRect(x:screenWidth/4.0,y:screenHeight/5.0,width:screenWidth/2.0, height:screenHeight/5.0)
        self.view.addSubview(label)
        
        // Add Button
        let button = UIButton()
        button.setTitle("Start New Game", for: .normal)
        button.frame = CGRect(x:screenWidth/4.0,y:screenHeight*2.0/5.0,width:screenWidth/2.0, height:screenHeight/5.0)
        button.addTarget(self, action: "startGame", for: UIControlEvents.touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(button)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func startGame(){
        let game = GameViewController()
        print("click")
        button?.removeFromSuperview()
        label?.removeFromSuperview()
        navigationController?.pushViewController(game, animated: true)
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
