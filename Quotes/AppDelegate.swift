//
//  AppDelegate.swift
//  Quotes
//
//  Created by Kipp Dunn on 9/6/22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var eventMonitor: EventMonitor?
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover = NSPopover();

    func applicationDidFinishLaunching(_ aNotification: Notification) {
      if let button = statusItem.button {
        button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        button.action = #selector(togglePopover(_:))
      }
      popover.contentViewController = QuotesViewController.freshController()
      eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
        if let strongSelf = self, strongSelf.popover.isShown {
          strongSelf.closePopover(sender: event)
        }
      }
      let task = Tasks();
      task.calc()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    @objc func printQuote(_ sender: Any?) {
      let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
      let quoteAuthor = "Mark Twain"
      
      print("\(quoteText) — \(quoteAuthor)")
    }
    
    func constructMenu() {
      let menu = NSMenu()

      menu.addItem(NSMenuItem(title: "Print Quote", action: #selector(AppDelegate.printQuote(_:)), keyEquivalent: "P"))
      menu.addItem(NSMenuItem.separator())
      menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

      statusItem.menu = menu
    }
    
    @objc func togglePopover(_ sender: Any?) {
      if popover.isShown {
        closePopover(sender: sender)
      } else {
        showPopover(sender: sender)
      }
    }

    func showPopover(sender: Any?) {
      if let button = statusItem.button {
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
      }
      eventMonitor?.start()
    }

    func closePopover(sender: Any?) {
      popover.performClose(sender)
      eventMonitor?.stop()
    }


}

