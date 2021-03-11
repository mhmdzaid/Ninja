//
//  ViewController.swift
//  Networking Layer
//
//  Created by Mohamed Zead on 3/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let params :[String:Any] = ["first_name":"Ahmed",
                      "last_name" : "Kamal",
                      "phone" : "50733441",
                      "image":UIImage(named: "AvatarMaker")!]
        NinjaRequest.profile(params).upload(ProfileUploadResponse.self) { (result) in
            switch result{
            case .success(let response):
                print("---------- success ------- \n \(response)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

