//
//  ListView.swift
//  MapMe
//
//  Created by Andrew Llewellyn on 5/14/18.
//  Copyright © 2018 Andrew Llewellyn. All rights reserved.
//

import Foundation
import UIKit
import WebKit


class ListViewController: UITableViewController
{
    
    @IBOutlet weak var listView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    @IBAction func postPin(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "InputLocationController")
        
        controller!.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(controller!, animated: true)
        
    }
    
    @IBAction func refresh(_ sender: Any)
    {
        
        performUIUpdatesOnMain
            {
            MapInteract.sharedInstance().resultToStudent()
                {
                (success) in
                    
                    return
                }
            }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return MapInteract.sharedInstance().studentLocationArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let studentItem = MapInteract.sharedInstance().studentLocationArray[(indexPath as NSIndexPath).row]
        
        SurfClient.sharedInstance().studentURL = studentItem.mediaURL
        
        SurfClient.sharedInstance().setRequest()
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "WebController") as! WebController
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for:indexPath)
        
        let studentItem = MapInteract.sharedInstance().studentLocationArray[(indexPath as NSIndexPath).row]
    
        cell.textLabel?.text = studentItem.firstName
        cell.detailTextLabel?.text = studentItem.mapString
        
        cell.textLabel?.font = UIFont(name: "Menlo", size: 16.0)
        cell.detailTextLabel?.font = UIFont(name: "Menlo", size: 16.0)
        
        return cell
    }
    
  

}
