//
//  ViewController.swift
//  Editing and Reordering
//
//  Created by Bimonaretga on 6/27/17.
//  Copyright © 2017 moeCodes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func refreshTableView(_ sender: Any) {
        let ip = IndexPath(row: 2, section: 0)
        let ip2 = IndexPath(row: 5, section: 0)
        //insert
        allEmojis.insert("Hello", at: ip.row)
        tableView.insertRows(at: [ip], with: .fade)
        //delete
        allEmojis.remove(at: ip2.row)
        tableView.deleteRows(at: [ip2], with: .fade)
        //it has to be in the following line
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isEditing = false
    }
    
    let checkmark = Set<IndexPath>()
    
    var allEmojis = ["😀","😁","😂","😃","😄","😅","😆","😇","😈","👿","😉","😊","☺️","😋","😌","😍","😎","😏","😐","😑","😒","😓","😔","😕","😖","😗","😘","😙","😚","😛","😜","😝","😞","😟","😠","😡","😢","😣","😤","😥","😦","😧","😨","😩","😪","😫","😬","😭","😮","😯","😰","😱","😲","😳","😴","😵","😶","😷","😸","😹","😺","😻","😼","😽","😾","😿","🙀","👣","👤","👥","👶","👶🏻","👶🏼","👶🏽","👶🏾","👶🏿","👦","👦🏻","👦🏼","👦🏽","👦🏾","👦🏿","👧","👧🏻","👧🏼","👧🏽","👧🏾","👧🏿","👨","👨🏻","👨🏼","👨🏽","👨🏾","👨🏿","👩","👩🏻","👩🏼","👩🏽","👩🏾","👩🏿","👪","👨‍👩‍👧","👨‍👩‍👧‍👦","👨‍👩‍👦‍👦","👨‍👩‍👧‍👧","👩‍👩‍👦","👩‍👩‍👧","👩‍👩‍👧‍👦","👩‍👩‍👦‍👦","👩‍👩‍👧‍👧","👨‍👨‍👦","👨‍👨‍👧","👨‍👨‍👧‍👦","👨‍👨‍👦‍👦","👨‍👨‍👧‍👧","👫","👬","👭","👯","👰","👰🏻","👰🏼","👰🏽","👰🏾","👰🏿","👱"]
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return allEmojis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = allEmojis[indexPath.row]
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = cell.accessoryType == .checkmark ? .none : .checkmark
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let source = allEmojis[sourceIndexPath.row]
        allEmojis.remove(at: sourceIndexPath.row)
        allEmojis.insert(source, at: destinationIndexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//        switch editingStyle {
//        case .delete:
//            
//            allEmojis.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .left)
//            
//        default:
//            break
//        }
//        
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        var actions = [UITableViewRowAction]()
        
        let delete = UITableViewRowAction(style: .destructive, title: "Destruct") { (action, indexPath) in
            //to do: 
            //delete the emojis in the allEmojis array
            //delete the rows in the tableView
            //using an if check, cover asynchrony bases by
            if let _ = tableView.cellForRow(at: indexPath) {
                self.allEmojis.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
        }
        actions.append(delete)
        
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { (action, indexPath) in
            let emoji = self.allEmojis[indexPath.row]
            print("Favorited:", emoji)
        }
        favorite.backgroundColor = .blue

        actions.append(favorite)
        
        let more = UITableViewRowAction(style: .default, title: "More") { (action, indexPath) in
            let emoji = self.allEmojis[indexPath.row]
            print("More Of:", emoji)
        }
        
        actions.append(more)
        
        return actions
        
    }
}
