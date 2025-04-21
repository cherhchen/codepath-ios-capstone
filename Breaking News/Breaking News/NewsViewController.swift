//
//  NewsViewController.swift
//  Breaking News
//
//  Created by Cheryl Chen on 4/20/25.
//

import UIKit
import NukeExtensions

class NewsViewController: UIViewController, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        fetchNews()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        let selectedArticle = articles[selectedIndexPath.row]
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        detailViewController.article = selectedArticle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get the index path for the selected row
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            // Deselect the currently selected row
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // Get the article associated table view row
        let article = articles[indexPath.row]
        
        // Configure the cell
        
        if let imagePath = article.urlToImage {
            let imageUrl = URL(string: imagePath)
            NukeExtensions.loadImage(with: imageUrl, into: cell.articleImageView)
        }
        cell.titleLabel.text = article.title
        return cell
    }
    
    private func fetchNews() {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=5a40fa3f75de402eb26b365d4dc3b33f"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                print("🚨 Request failed: \(error.localizedDescription)")
                return
            }
            // Check for server errors
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("🚨 Server Error: response: \(String(describing: response))")
                return
            }
            // Check for data
            guard let data = data else {
                print("🚨 No data returned from request")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                // Create a date formatter object
                let dateFormatter = DateFormatter()
                
                // Set the date formatter date format to match the the format of the date string we're trying to parse
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                // Tell the json decoder to use the custom date formatter when decoding dates
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                // Decode the JSON data into our custom `NewsFeed` model
                let newsFeedResponse = try decoder.decode(NewsFeed.self, from: data)
                
                // Access the array of movies
                let articles = newsFeedResponse.articles
                
                // Run any code that will update the UI on the main thread
                DispatchQueue.main.async { [weak self] in
                    // We have articles! Do something with them!
                    print("✅ SUCCESS!!! Fetched \(articles.count) articles")
                    
                    // Iterate over all articles and print out their details
                    for (index, article) in articles.enumerated() {
                        print("🍿 Article \(index) ------------------")
                        print("Source: \(article.source)")
                        print("Title: \(article.title)")
                    }
                    
                    // Update the articles property so we can access movie data anywhere in the view controller
                    self?.articles = articles
                    print("🍏 Fetched and stored \(articles.count) articles")
                    
                    // Prompt the table view to reload its data (i.e. call the data source methods again and re-render contents)
                    self?.tableView.reloadData()
                }
            }
            catch {
                print("🚨 Error decoding JSON data into Article Response: \(error.localizedDescription)")
                return
            }
        }
        // Don't forget to run the session!
        session.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
