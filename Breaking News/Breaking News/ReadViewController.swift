//
//  ReadViewController.swift
//  Breaking News
//
//  Created by Cheryl Chen on 4/20/25.
//

import UIKit
import NukeExtensions

class ReadViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var readArticles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let articles = Article.getArticles(forKey: Article.readKey)
        self.readArticles = articles
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        let article = readArticles[indexPath.row]
        if let imagePath = article.urlToImage {
            let imageUrl = URL(string: imagePath)
            NukeExtensions.loadImage(with: imageUrl, into: cell.articleImageView)
        }
        cell.titleLabel.text = article.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        let selectedArticle = readArticles[selectedIndexPath.row]
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        detailViewController.article = selectedArticle
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
