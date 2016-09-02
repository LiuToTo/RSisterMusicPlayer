//
//  AMMusicListCell.swift
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/5/4.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

import UIKit

public class AMMusicListCell : UITableViewCell
{
    var deleteHandler: (() -> Void)?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector("longPressAction:"))
        self.addGestureRecognizer(longPress)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func longPressAction(recognizer:UIGestureRecognizer){
        if (recognizer.state == UIGestureRecognizerState.Began) {
            let cell = recognizer.view as! AMMusicListCell
            cell.becomeFirstResponder()
            
            let deleteItem = UIMenuItem(title: "删除", action: Selector("deleteItemClick"))
            
            let menu = UIMenuController.sharedMenuController();
        
            menu.menuItems = [deleteItem]
            menu.setTargetRect(cell.frame, inView: cell.superview!)
    
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    @objc private func deleteItemClick() {
        print("delete")
        guard let deleteHandler = deleteHandler else{
            return
        }
        
        deleteHandler()
    }
    
    public override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    public override func canResignFirstResponder() -> Bool {
        return true
    }
    
    public override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == Selector("deleteItemClick") {
            return true
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
}