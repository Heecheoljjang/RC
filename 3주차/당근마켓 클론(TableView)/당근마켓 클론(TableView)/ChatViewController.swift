//
//  ChatViewController.swift
//  당근마켓 클론(TableView)
//
//  Created by HeecheolYoon on 2022/02/22.
//

import UIKit

class ChatViewController: UIViewController {
    

    var chatTableCellInfo: [ChatTableCellStruct] = []
    
    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chatTableCellInfo.append(ChatTableCellStruct(profileImg: UIImage(named: "cat")!, id: "고양이", body: "맥북사고싶어요"))
        chatTableCellInfo.append(ChatTableCellStruct(profileImg: UIImage(named: "pig")!, id: "돼지", body: "제가 더 사고싶어요"))
        chatTableCellInfo.append(ChatTableCellStruct(profileImg: UIImage(named: "dog")!, id: "강아지", body: "윗사람보다 만원 더"))
        chatTableCellInfo.append(ChatTableCellStruct(profileImg: UIImage(named: "panda")!, id: "판다", body: "전부 살게요."))
        
        let myChatTableViewXib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        
        self.chatTableView.register(myChatTableViewXib, forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            chatTableCellInfo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatTableCellInfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
        
        cell.profileImg.layer.cornerRadius = cell.profileImg.frame.height / 2
        
        cell.profileImg.image = chatTableCellInfo[indexPath.row].profileImg
        cell.id.text = chatTableCellInfo[indexPath.row].id
        cell.body.text = chatTableCellInfo[indexPath.row].body
        
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    
}

class ChatTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

struct ChatTableCellStruct {
    var profileImg: UIImage
    var id: String
    var body: String
}
