//
//  HistoryController.swift
//  lifecounter
//
//  Created by Hari Kaushik on 2/2/19.
//  Copyright © 2019 Hari Kaushik. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

  @IBOutlet weak var container: UIStackView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

      // Do any additional setup after loading the view.
  }
  
  override func loadView() {
    super.loadView()
  }
  var allEvents:[String] = []
  var y = 0
  var itemDescription:String = ""

  @IBAction func dismissModal(_ sender: UIButton) {
    dismiss(animated: false, completion: nil)
  }
  
  func addHistoryItems(events: [String]){
    allEvents = events
    for item in events {
      addHistoryItem(event: item, test: y)
      y += 20
    }
  }
  func addHistoryItem(event: String, test:Int) {
    if self.view.subviews.count == 0 {
      ()
    }
    let item = UILabel(frame: CGRect(x: 0, y: test, width: 200, height: 21))
    item.text = event
    container.addSubview(item)
  }
}
