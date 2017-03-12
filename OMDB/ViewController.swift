//
//  ViewController.swift
//  OMDB
//
//  Created by Death Code on 12/03/17.
//  Copyright © 2017 Death Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View Appeared")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchForMovie(title: searchBar.text!)
        searchBar.text = ""
    }

    
    func searchForMovie(title: String)
    {
        
        print("Search Started")
        if let movie = title.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        {
            let url = URL(string: "http://www.omdbapi.com/?t=\(movie)")
            let session = URLSession.shared
            
            print("Seacrh Started")
            let task = session.dataTask(with: url!, completionHandler: {
                (data, response, error) in
                
                print("Task Started")
                if error != nil
                {
                    print (error!)
                }else{
                    if data != nil{
                        do{
                            print("Seacrh Started")
                           let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, String>
                            print(jsonResult)
                            DispatchQueue.main.async {
                                
                                self.titleLabel.text = jsonResult["Title"]
                                self.imdbRating.text = jsonResult["imdbRating"]
                                self.directorLabel.text = jsonResult["Director"]
                                self.actorLabel.text = jsonResult["Actors"]
                                
                                if let imageExists = jsonResult["Poster"]
                                {
                                    let imageUrl = URL(string: imageExists)
                                    
                                    if let imageData = try? Data(contentsOf: imageUrl!)
                                    {
                                        self.imageView.image = UIImage(data: imageData)
                                    }
                                }
                            }
                            
                            
                        }catch{
                            
                        }
                        
                    }
                }
            
            })
            
            task.resume()
        }
        
    }


}

