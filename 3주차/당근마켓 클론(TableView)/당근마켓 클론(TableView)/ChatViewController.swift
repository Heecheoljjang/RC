//
//  ChatViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/22.
//

import UIKit

class ChatViewController: UIViewController {
    
    let chatId: [String] = ["희철", "봉봉", "가나다라마바사아자", "호랑이코끼리", "강아지고양이", "붐", "호호호", "호", "Llilili", "ABCDEFG", "안녕하세요저는"]
    
    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myChatTableViewXib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        
        self.chatTableView.register(myChatTableViewXib, forCellReuseIdentifier: "cell")
    }

}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatId.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
        
        cell.id.text = chatId[indexPath.row]
        cell.profileImg.layer.cornerRadius = 25
        
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    
}

class ChatTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var id: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
