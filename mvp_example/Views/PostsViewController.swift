//
//  ViewController.swift
//  mvp_example
//
//  Created by Alvaro Choque on 21/6/22.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var posts = [Post]()
    private let presenter = PostPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Table
        let uiNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: "Cell-Test")
        
        // Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getPosts()
    }
}

extension PostsViewController: PostPresenterDelegate {
    func presentPosts(posts: [Post]) {
        self.posts = posts
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell-Test") as? PostTableViewCell ?? PostTableViewCell(style: .subtitle, reuseIdentifier: "Cell-Test")
        
        cell.titleLabel.text = posts[indexPath.row].title
        cell.bodyLabel.text = posts[indexPath.row].body

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Ask presenter to handle this tap
        presenter.didTap(post: posts[indexPath.row])
    }
}
