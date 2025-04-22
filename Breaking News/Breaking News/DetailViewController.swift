//
//  DetailViewController.swift
//  Breaking News
//
//  Created by Cheryl Chen on 4/21/25.
//

import UIKit
import NukeExtensions

class DetailViewController: UIViewController {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var readlistButton: UIButton!
    
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        readButton.layer.cornerRadius = readButton.frame.width / 2
        readlistButton.layer.cornerRadius = readlistButton.frame.width / 2
        
        let read = Article.getArticles(forKey: Article.readKey)
        if read.contains(article) {
            readButton.isSelected = true
        } else {
            readButton.isSelected = false
        }
        
        let readlist = Article.getArticles(forKey: Article.readlistKey)
        if readlist.contains(article) {
            readlistButton.isSelected = true
        } else {
            readlistButton.isSelected = false
        }
        
        titleLabel.text = article.title
        sourceLabel.text = article.source.name
        
        if let publishedAtString = formatToHumanReadable(article.publishedAt) {
            publishedDateLabel.text = "Published: \(publishedAtString)"
        } else {
            publishedDateLabel.text = "Unknown"
        }
        
        if let articleAuthor = article.author {
            authorLabel.text = "Author: \(articleAuthor)"
        } else {
            authorLabel.text = "Unknown"
        }
        
        descriptionLabel.text = article.description
        
        if let imagePath = article.urlToImage, let imageUrl = URL(string: imagePath) {
            NukeExtensions.loadImage(with: imageUrl, into: articleImageView)
        }
        
        if let url = URL(string: article.url), UIApplication.shared.canOpenURL(url) {
            linkButton.isEnabled = true
        } else {
            linkButton.isEnabled = false
        }
    }
    
    func formatToHumanReadable(_ isoString: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let fallbackFormatter = ISO8601DateFormatter()

        var date: Date?
        if let parsedDate = isoFormatter.date(from: isoString) {
            date = parsedDate
        } else {
            date = fallbackFormatter.date(from: isoString)
        }

        guard let finalDate = date else { return nil }

        let readableFormatter = DateFormatter()
        readableFormatter.locale = Locale.current
        readableFormatter.dateStyle = .medium
        readableFormatter.timeStyle = .short

        return readableFormatter.string(from: finalDate)
    }
    
    @IBAction func linkButtonTapped(_ sender: UIButton) {
        if let url = URL(string: article.url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func didTapReadButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            article.addToRead()
        } else {
            article.removeFromRead()
        }
    }
    
    @IBAction func didTapReadlistButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            article.addToReadlist()
        } else {
            article.removeFromReadlist()
        }
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
