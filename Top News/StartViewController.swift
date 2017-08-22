//
//  StartViewController.swift
//  Top News
//
//  Created by Egor on 21.08.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll
import CoreData


class StartViewController: MainViewController {

    var refresher: UIRefreshControl!
    
    var sourceOfApi: [ApiObject]?
    var sourceIndex = -1
    var newsAlreadyFetched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Refreshing...")
        refresher.addTarget(self, action: #selector(StartViewController.pullToRefresh), for: .valueChanged)
        tableView.addSubview(refresher)
        
        tableView.infiniteScrollIndicatorMargin = 40
        
        tableView.addInfiniteScroll { [weak self] (tableView) in //problem here
            self?.loadData()
            self?.tableView.finishInfiniteScroll()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sourceOfApi = SourceOfAPI.sortByState()
        
        if !newsAlreadyFetched{
            loadData()
            newsAlreadyFetched = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Load data from API storage
    
    func loadData(){
        if let sourceArray = sourceOfApi{
            if ((sourceArray.count - 2) >= sourceIndex) && (sourceArray.count != 0){
                sourceIndex += 1
                NewsAPI.getNews(stringUrl: sourceArray[sourceIndex].url) { [weak self] (downloadedNews) in
                    if let news = downloadedNews{
                        
                        (self?.articles == nil) ? self?.articles = news : self?.articles?.append(contentsOf: news)
                        
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK: - Refresher func
    
    func pullToRefresh(){
        articles?.removeAll()
        sourceIndex = -1
        loadData()
        refresher.endRefreshing()
    }
    
    //MARK: - Unwind
    
    @IBAction func unwindToStartViewController(segue: UIStoryboardSegue){}
    
    //MARK: - Adding to Data Base
    
    @IBAction func toReadLaterButton(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? MainTableViewCell{
            if let indexPath = self.tableView.indexPath(for: cell){
                if let article = articles?[indexPath.row]{
                    updateArticlesDB(with: article)
                }
            }
        }
    }
    
    func updateArticlesDB(with article: Article){
        container?.performBackgroundTask{ (context) in
                _ = try? ArticleDB.findOrCreateArticle(with: article, context: context)
            
            try? context.save()
        }
    }
}
