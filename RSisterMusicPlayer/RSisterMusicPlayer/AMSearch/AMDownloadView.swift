//
//  AMDownloadView.swift
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/25.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

import UIKit

/// 重用标识符
let kDownloadCellReuseID = "kDownloadCellReuseID"

public class AMDownloadView: UIView
{
    var items: NSArray?
    var info: AMResultSongModel?
    var closeHandler: (() -> Void)?
    
    @IBOutlet weak var downOptionList: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    public class func downloadView(items:NSArray!, info:AMResultSongModel!) -> AMDownloadView{
        let downloadView = NSBundle.mainBundle().loadNibNamed("AMDownLoadView", owner: nil, options: nil).first as! AMDownloadView
        downloadView.items = items
        downloadView.info = info
        downloadView.downOptionList.dataSource = downloadView
        downloadView.downOptionList.delegate = downloadView
        downloadView.downOptionList.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: kDownloadCellReuseID)
        downloadView.downOptionList.separatorStyle = .None
    
        return downloadView
    }
    
    // MARK: - action method
    /// 关闭下载板
    @IBAction func closeDownLoadView(sender: AnyObject)
    {
        self.removeFromSuperview()
        
        guard let closeHandler = closeHandler else{
            return
        }
        
        closeHandler()
    }
    
}
extension AMDownloadView : UITableViewDelegate
{
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let item:AMAuditionListModel = items![indexPath.row] as! AMAuditionListModel;
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        let progressView :UIView = UIView(frame: (cell?.bounds)!);
        progressView.backgroundColor = UIColor.blueColor()
        cell!.addSubview(progressView)
        progressView.alpha = 0.5
        
        progressView.frame = CGRectMake(0, 0, 0, (cell?.bounds.size.height)!)
        
        AMNetEngine.downloadMusicWithURLStr(item.url, process:
        { (progress) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let completed = CGFloat(progress.completedUnitCount)
                let total = CGFloat(progress.totalUnitCount)
                let progressValue : CGFloat = completed / total
                
                let cellWidth = CGFloat(cell!.bounds.size.width * progressValue)
                
                progressView.frame = CGRectMake(0, 0, cellWidth, (cell?.bounds.size.height)!)
  
            })
        })
        { (sucess, resultObj, error) -> Void in
            // 存储音乐
            var path = (self.info?.name)! + "." + item.suffix
            path = path.documentFilePath()
            
            let data = resultObj as! NSData
            data.writeToFile(path as String, atomically: true)
            
            // 添加到数据库
            let music: AMMusic = AMMusic()
            music.musicName = self.info?.name
            music.musicPath =  (self.info?.name)! + "." + item.suffix
            music.singer = self.info?.singerName
            music.picURl = self.info?.picUrl
            music.lrcPath = ""
            
           let isSucess = AMStorageDataBase.defaultStorageDB().insertMusicListTableWithMusic(music)
            
            // 插入成功更新内存数据
            if isSucess {
                let musics:NSMutableArray = NSMutableArray(array: AMSession.currentSession().musics)
                musics.addObject(music)
                AMSession.currentSession().musics = musics as [AnyObject];
                
                NSNotificationCenter.defaultCenter().postNotificationName(kMusicListChangedNotification, object: nil)
                self.closeButton .sendActionsForControlEvents(.TouchUpInside)
            }
            
            print(isSucess,resultObj)
        }
    }
}

extension AMDownloadView: UITableViewDataSource
{
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items?.count ?? 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
       
        let cell = tableView .dequeueReusableCellWithIdentifier(kDownloadCellReuseID, forIndexPath: indexPath)
        
        guard let items = items else{
            return cell
        }
        let item:AMAuditionListModel = items[indexPath.row] as! AMAuditionListModel;
        
        let size = ((Float(item.size)/1024.0)/1024.0)
        var description: String = String(format:"%0.2f",size)
        
        description = " / " + description + "M"
        description += "(" + item.suffix + ")"
        description = item.typeDescription + description
        
        cell.selectionStyle = .None
        cell.textLabel?.text = description
        cell.backgroundColor = tableView.backgroundColor
        cell.textLabel?.textColor = UIColor(white: 0.8, alpha: 0.9)
        
        return cell
    }
}