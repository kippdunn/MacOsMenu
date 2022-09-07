//
//  Process.swift
//  Quotes
//
//  Created by Kipp Dunn on 9/6/22.
//

import Foundation

public class Tasks {
  var wattage = 0.0
  var str = ""
  private let process = Process()


  public init() {

  }

  public func calc() {
    let fileName = "wattage"
    let scriptUrl = Bundle.main.url(forResource: fileName, withExtension: "sh")
    
    let home = FileManager.default.homeDirectoryForCurrentUser
    let path = home.appendingPathComponent("wattage.sh").absoluteString
    self.process.executableURL = scriptUrl
    let outputPipe = Pipe()
    self.process.standardOutput = outputPipe
    
    
    try? self.process.run()
    
    let output = outputPipe.fileHandleForReading.readDataToEndOfFile()
    self.str = String(decoding: output, as: UTF8.self)
    print(str)
  }
}
