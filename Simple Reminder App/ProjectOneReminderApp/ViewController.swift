//
//  ViewController.swift
//  ProjectOneReminderApp
//
//  Created by Aidan Scheer on 3/27/21.
//
import UserNotifications
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    struct reminders {
        var name:String
        var description:String
        var date:Date
    }
    
    var reminderList = [reminders]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reminderTable.dequeueReusableCell(withIdentifier: "MyTableViewCell") as! MyTableViewCell

        cell.textLabel?.text =  reminderList[indexPath.row].name
        
        let date = reminderList[indexPath.row].date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, YYYY"
        cell.detailTextLabel?.text = formatter.string(from: date)

        cell.textLabel?.font = UIFont(name: "Arial", size: 22)
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 18)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            reminderList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // show edit vc
        guard let vc = storyboard?.instantiateViewController(identifier: "edit") as? EditViewController else {
            return
        }
        vc.title = "Edit Reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.complete = {title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = reminders(name: title, description: "id_\(title)", date: date)
                
                
                self.reminderList[indexPath.row].name = new.name
                self.reminderList[indexPath.row].description = new.description
                self.reminderList[indexPath.row].date = new.date
                self.reminderTable.reloadData()
                
                
                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body
                
                let targetDate = date
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
                
                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                    if error != nil {
                        print("Something went wrong")
                    }
                })
            }
        }
        
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var reminderTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reminderTable.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.identifier)
        reminderTable.delegate = self
        reminderTable.dataSource = self
        
        
    }
    

    @IBAction func didTapAdd() {
        // show add vc
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? AddViewController else {
            return
            
        }
        
        vc.title = "New Reminder"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.complete = {title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = reminders(name: title, description: "id_\(title)", date: date)
                self.reminderList.append(new)
                self.reminderTable.reloadData()
                
                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body
                
                let targetDate = date
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
                
                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                    if error != nil {
                        print("Something went wrong")
                    }
                })
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func didTapTest() {
        // fire test controller
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
            if success {
                //schedule test
                self.scheduleTest()
            }
            else if error != nil {
                print("error occured")
            }
        })
    }
    
    func scheduleTest() {
        let content = UNMutableNotificationContent()
        content.title = "Hello World"
        content.sound = .default
        content.body = "Body Body Body Body"
        
        let targetDate = Date().addingTimeInterval(10)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil {
                print("Something went wrong")
            }
        })
    }
    
}

