//
//  QuotesViewController.swift
//  Quotes
//
//  Created by Kipp Dunn on 9/6/22.
//

import Cocoa

class QuotesViewController: NSViewController {
    
    @IBOutlet var textLabel: NSTextField!

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do view setup here.
//    }
    let quotes = Quote.all

    var currentQuoteIndex: Int = 0 {
      didSet {
        updateQuote()
      }
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      currentQuoteIndex = 0
    }

    func updateQuote() {
      textLabel.stringValue = String(describing: quotes[currentQuoteIndex])
    }


}

// MARK: Actions

extension QuotesViewController {
  @IBAction func previous(_ sender: NSButton) {
      currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count
  }

  @IBAction func next(_ sender: NSButton) {
      currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
  }

  @IBAction func quit(_ sender: NSButton) {
      NSApplication.shared.terminate(sender)
  }
}

extension QuotesViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> QuotesViewController {
    //1.
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    //2.
    let identifier = NSStoryboard.SceneIdentifier("QuotesViewController")
    //3.
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? QuotesViewController else {
      fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}

