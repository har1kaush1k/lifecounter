//
//  ViewController.swift
//  lifecounter
//
//  Created by Hari Kaushik on 1/29/19.
//  Copyright © 2019 Hari Kaushik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var fullStack: UIStackView!
  
  var players = 4
  
  var started = false
  
  @IBOutlet weak var player1_input: UITextField!
  @IBOutlet weak var player2_input: UITextField!
  @IBOutlet weak var player3_input: UITextField!
  @IBOutlet weak var player4_input: UITextField!
  @IBOutlet weak var player5_input: UITextField!
  @IBOutlet weak var player6_input: UITextField!
  @IBOutlet weak var player7_input: UITextField!
  @IBOutlet weak var player8_input: UITextField!
  
  @IBOutlet weak var endGame: UILabel!
  
  var history:[String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let viewController = segue.destination as? HistoryViewController {
        viewController.addHistoryItems(events: history)
    }
  }
  
  @IBAction func buttonClick(_ sender: UIButton) {
    if sender.tag == 0 {
      if(sender.titleLabel?.text == "Reset"){
        resetGame()
      } else if (sender.titleLabel?.text == "+ Player"){
        addPlayer()
      } else if (sender.titleLabel?.text == "- Player"){
        removePlayer()
      }
    } else {
      if !started {
        disableAddRemovePlayer()
        started = true
      }
      
      let buttonName = sender.titleLabel?.text
      if(buttonName == "-"){
        subtract(1, tag : sender.tag)
      } else if (buttonName == "+"){
        add(1, tag : sender.tag)
      } else if (buttonName == "Set") {
        setChange(sender.tag)
      } else {
        if buttonName?.prefix(1) == "-" {
          let change = Int(String(buttonName?.split(separator: "-")[0] ?? "0"))
          subtract(change ?? 0, tag: sender.tag)
        } else if buttonName?.prefix(1) == "+" {
          let change = Int(String(buttonName?.split(separator: "+")[0] ?? "0"))
          add(change ?? 0, tag: sender.tag)
        }
      }
    }
  }
  
  func setChange(_ tag: Int) {
    let b = fullStack.viewWithTag(tag)?.subviews.compactMap({ $0 as? UIButton })
    let change = fullStack.viewWithTag(tag)?.subviews.compactMap({ $0 as? UITextField })[0].text
    b?[2].setTitle("+\(change!)", for: .normal)
    b?[3].setTitle("-\(change!)", for: .normal)
  }
  
  func subtract(_ change: Int, tag:Int) {
    history.append("Player \(tag) lost \(change) life.")
    let life = fullStack.viewWithTag(tag)?.subviews.compactMap({ $0 as? UILabel })[1]
    let points = Int(String(life!.text!))! - change
    if points < 1 {
      endGame.isHidden = false;
    }
    life?.text = "\(points)"
  }
  
  func add(_ change: Int, tag:Int) {
    history.append("Player \(tag) gained \(change) life.")
    let life = fullStack.viewWithTag(tag)?.subviews.compactMap({ $0 as? UILabel })[1]
    let points = Int(String(life!.text!))! + change
    life?.text = "\(points)"
  }
  
  func addPlayer() {
    if players < 8 {
      players += 1
      fullStack.viewWithTag(players)?.isHidden = false
      history.append("Player \(players) added to game.")
    }
  }
  
  func removePlayer() {
    if players > 2 {
      fullStack.viewWithTag(players)?.isHidden = true
      history.append("Player \(players) removed to game.")
      players -= 1
    }
  }
  
  func disableAddRemovePlayer() {
    let buttons = fullStack.subviews[0]
    for button in buttons.subviews {
      let b = button as! UIButton
      if b.titleLabel?.text == "+ Player" || b.titleLabel?.text == "- Player" {
        b.isEnabled = false
      }
    }
  }
  
  func resetGame() {
    for view in fullStack.subviews {
      if view.tag > 0 {
        let life = view.subviews.compactMap({ $0 as? UILabel })[1]
        life.text = "20"
      } else if view.tag > 4 {
        view.isHidden = true
      } else {
        started = false
        let buttons = view.subviews
        for button in buttons {
          let b = button as! UIButton
          if b.titleLabel?.text == "+ Player" || b.titleLabel?.text == "- Player" {
            b.isEnabled = true
          }
        }
      }
    }
    endGame.isHidden = true
    history = []
  }
}

