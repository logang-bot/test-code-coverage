//
//  Presenter.swift
//  mvp_example
//
//  Created by Alvaro Choque on 21/6/22.
//

import Foundation
import UIKit

//https://jsonplaceholder.typicode.com/posts

protocol PostPresenterDelegate: AnyObject {
    func presentPosts(posts: [Post])
    func presentAlert(title: String, message: String)
}

typealias PresenterDelegate = PostPresenterDelegate & UIViewController

class PostPresenter {
    
    var delegate: PresenterDelegate?
    
    public func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                self?.delegate?.presentPosts(posts: posts)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func didTap(post: Post) {
        delegate?.presentAlert(title: post.title, message: post.body)
    }
    
//    public func dummyFun() -> String{
//        return "testing"
//    }
}

