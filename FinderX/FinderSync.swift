//
//  FinderSync.swift
//  FinderX
//
//  Created by mylhyz on 2024/6/13.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {
    
    override init() {
        super.init()
        
//        NSLog("FinderSync() launched from %@", Bundle.main.bundlePath as NSString)
        
        let mountedVolumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: [])
        // Set up the directory we are syncing.
        FIFinderSyncController.default().directoryURLs = Set(mountedVolumes ?? [])
        
        // Set up images for our badge identifiers. For demonstration purposes, this uses off-the-shelf images.
//        FIFinderSyncController.default().setBadgeImage(NSImage(named: NSImage.colorPanelName)!, label: "Status One" , forBadgeIdentifier: "One")
//        FIFinderSyncController.default().setBadgeImage(NSImage(named: NSImage.cautionName)!, label: "Status Two", forBadgeIdentifier: "Two")
    }
    
    // MARK: - Primary Finder Sync protocol methods
    
    override func beginObservingDirectory(at url: URL) {
        // The user is now seeing the container's contents.
        // If they see it in more than one view at a time, we're only told once.
//        NSLog("beginObservingDirectoryAtURL: %@", url.path as NSString)
    }
    
    
    override func endObservingDirectory(at url: URL) {
        // The user is no longer seeing the container's contents.
//        NSLog("endObservingDirectoryAtURL: %@", url.path as NSString)
    }
    
//    override func requestBadgeIdentifier(for url: URL) {
//        NSLog("requestBadgeIdentifierForURL: %@", url.path as NSString)
//        
//        // For demonstration purposes, this picks one of our two badges, or no badge at all, based on the filename.
//        let whichBadge = abs(url.path.hash) % 3
//        let badgeIdentifier = ["", "One", "Two"][whichBadge]
//        FIFinderSyncController.default().setBadgeIdentifier(badgeIdentifier, for: url)
//    }
    
    // MARK: - Menu and toolbar item support
    
//    override var toolbarItemName: String {
//        return "FinderSy"
//    }
//    
//    override var toolbarItemToolTip: String {
//        return "FinderSy: Click the toolbar item for a menu."
//    }
//    
//    override var toolbarItemImage: NSImage {
//        return NSImage(named: NSImage.cautionName)!
//    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        // Produce a menu for the extension.
        let menu = NSMenu(title: "")
        
        if menuKind == FIMenuKind.contextualMenuForContainer {
//            menu.addItem(withTitle: "Finder空白处右键", action: #selector(sampleAction(_:)), keyEquivalent: "")
        } else if menuKind == FIMenuKind.contextualMenuForItems {
//            menu.addItem(withTitle: "Finder文件上右键", action: #selector(sampleAction(_:)), keyEquivalent: "")
            menu.addItem(withTitle: "拷贝路径", action: #selector(copyPath(_:)), keyEquivalent: "")
        } else if menuKind == FIMenuKind.contextualMenuForSidebar {
//            menu.addItem(withTitle: "Finder侧边栏右键", action: #selector(sampleAction(_:)), keyEquivalent: "")
        } else if menuKind == FIMenuKind.toolbarItemMenu {
//            menu.addItem(withTitle: "Finder顶栏", action: #selector(sampleAction(_:)), keyEquivalent: "")
        }
        
        return menu
    }
    
    @IBAction func copyPath(_ sender:AnyObject?){
        // 选中单个文件时才进行处理
        if let items = FIFinderSyncController.default().selectedItemURLs(), items.count == 1 {
            let fileURL = items[0]
            var isDirectory: ObjCBool = false
            
            if FileManager.default.fileExists(atPath: fileURL.path, isDirectory: &isDirectory) {
                if isDirectory.boolValue {
                    print("选中的是一个文件夹。")
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    let stringToCopy = fileURL.path()
                    pasteboard.setString(stringToCopy, forType: .string)
                } else {
                    print("选中的是一个文件。")
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    let stringToCopy = fileURL.path()
                    pasteboard.setString(stringToCopy, forType: .string)
                }
            } else {
                print("选中的路径不存在。")
            }
        } else {
            print("没有选中任何项，或者选中了多个项。")
        }
    }
    
//    @IBAction func sampleAction(_ sender: AnyObject?) {
//        let target = FIFinderSyncController.default().targetedURL()
//        let items = FIFinderSyncController.default().selectedItemURLs()
//        
//        let item = sender as! NSMenuItem
//        NSLog("sampleAction: menu item: %@, target = %@, items = ", item.title as NSString, target!.path as NSString)
//        for obj in items! {
//            NSLog("    %@", obj.path as NSString)
//        }
//    }

}

