//
//  MasterViewController.swift
//  Blog Reader
//
//  Created by Zlatko Jankovic on 1/12/16.
//  Copyright © 2016 Zlatko Jankovic. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
   


    override func viewDidLoad() {
        
        var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        let url = NSURL(string: "https://www.googleapis.com/blogger/v3/blogs/10861780/posts?key=AIzaSyCDtGYlKovhO_hVtgmvxOifHWjvtCOkPok")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            
            if (error != nil) {
                
                print(error)
            }
            else {
                
                //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                do
                {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    if jsonResult.count > 0 {
                        
                        if let items = jsonResult["items"] as? NSArray {
                            
                            var request = NSFetchRequest(entityName: "Posts")
                            
                            request.returnsObjectsAsFaults = false
                            
                            do {
                                var results = try context.executeFetchRequest(request)
                                
                                if results.count > 0 {
                                
                                    for result in results {
                                        context.deleteObject(result as! NSManagedObject)
                                        do {
                                            try context.save()
                                        }
                                        catch{
                                            print(error)
                                        }
                                    }
                                }
                            }
                            catch {
                                print(error)
                            }
                            
                            
                            for item in items {
                                
                                print(item)
                                
                                if let title = item["title"] {
                                    
                                    if let content = item["content"] {
                                        
                                        var newPost = NSEntityDescription.insertNewObjectForEntityForName("Posts", inManagedObjectContext: context) as! NSManagedObject
                                        
                                        newPost.setValue(title, forKey: "title")
                                        
                                        newPost.setValue(content, forKey: "content")
                                        
                                        do {
                                            try context.save()
                                        }
                                        catch{
                                            print(error)
                                        }
                                            
                                    }
                                    
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    
                    var request = NSFetchRequest(entityName: "Posts")
                    
                    request.returnsObjectsAsFaults = false
                    
                    do {
                        var results = try context.executeFetchRequest(request)
                        print(results)
                    }
                    catch {
                        print(error)
                    }
                        
                    self.tableView.reloadData()
                    
                }
                catch{
                    print(error)
                }
                
                
                
            }
            
        }
        
        task.resume()
      
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
        
            print("Show detail")
        
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Test"
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    

    

    // MARK: - Fetched results controller

    

}

