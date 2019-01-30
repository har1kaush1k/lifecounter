//
//  ViewController.swift
//  lifecounter
//
//  Created by Hari Kaushik on 1/29/19.
//  Copyright © 2019 Hari Kaushik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var player1_count: UILabel!
  
  @IBOutlet weak var player2_count: UILabel!
  
  @IBOutlet weak var player3_count: UILabel!
  
  @IBOutlet weak var player4_count: UILabel!
  
  @IBOutlet weak var result: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func buttonClick(_ sender: UIButton) {
    var label:UILabel = player1_count
    var player:String = "Player 1"
    var change:Int = 0
    if(sender.tag >= 0 && sender.tag <= 3) {
      change = 1
    } else if(sender.tag >= 4 && sender.tag <= 7) {
      change = -1
    } else if(sender.tag >= 8 && sender.tag <= 11) {
      change = 5
    } else if(sender.tag >= 12 && sender.tag <= 15) {
      change = -5
    }
    
    if(sender.tag % 4 == 0) {
      label = player1_count
      player = "Player 1"
    } else if(sender.tag % 4 == 1) {
      label = player2_count
      player = "Player 2"
    } else if(sender.tag % 4 == 2) {
      label = player3_count
      player = "Player 3"
    } else if(sender.tag % 4 == 3) {
      label = player4_count
      player = "Player 4"
    }
    
    label.text = String(Int(label.text!)! + change)
    
    if(Int(label.text!)! <= 0 && result.text!.contains("loses") == false){
      result.text = player + " loses !"
    }
  }
  
  @IBAction func reset(_ sender: UIButton) {
    player1_count.text = "20"
    player2_count.text = "20"
    player3_count.text = "20"
    player4_count.text = "20"
    result.text = ""
  }
  
}

