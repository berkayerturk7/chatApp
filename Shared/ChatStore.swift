import SwiftUI
import Combine
import Firebase

/*

class ChatStore: ObservableObject {
    
    let db = Firestore.firestore()
    var chatArray : [ChatModel] = []
    
    var objectWillChange = PassthroughSubject<Array<Any>,Never>()
    
    init() {
        // Önemli: Tüm kullanıcıların chatlerini çekme, sadece ilgili kullanıcıların
        
        // 1- Benim gönderdiğim mesajlar
            db.collection("Chats").whereField("chatUserFrom", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener { snapshot, error in
                if error != nil {
                    print(error!)
                }
                else {
                    self.chatArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        
                        
                       
                        let chatUidFromFirebase = document.documentID
                            
                       
                        if let chatMessage = document.get("message") as? String {
                            if let messageFrom = document.get("chatUserFrom") as? String {
                                if let messageTo = document.get("chatUserTo") as? String {
                                    if let dateString = document.get("date") as? String {
                                        
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                        let dateFromFB = dateFormatter.date(from: dateString)
                                        // modalimize, Date yapısıyla gönderiyoruz.
                                        
                                        let currentIndex = self.chatArray.last?.id
                                        
                                        let createdChat = ChatModel(id: (currentIndex ?? -1) + 1, message: chatMessage, uidFromFirebase: chatUidFromFirebase, messageFrome: messageFrom, messageTo: messageTo, messageDate: dateFromFB!, messageFromMe: true)
                                        
                                        self.chatArray.append(createdChat)
                                        
                                        
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
        // 2- Bana gelen mesajlar
        
        db.collection("Chats").whereField("chatUserTo", isEqualTo: Auth.auth().currentUser!.uid)
        .addSnapshotListener { snapshot, error in
            if error != nil {
                print(error!)
            }
            else {
                for document in snapshot!.documents {
                    
                    self.chatArray.removeAll(keepingCapacity: false)
                   
                    let chatUidFromFirebase = document.documentID
                        
                   
                    if let chatMessage = document.get("message") as? String {
                        if let messageFrom = document.get("chatUserFrom") as? String {
                            if let messageTo = document.get("chatUserTo") as? String {
                                if let dateString = document.get("date") as? String {
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                    let dateFromFB = dateFormatter.date(from: dateString)
                                    // modalimize, Date yapısıyla gönderiyoruz.
                                    
                                    let currentIndex = self.chatArray.last?.id
                                    
                                    let createdChat = ChatModel(id: (currentIndex ?? -1) + 1, message: chatMessage, uidFromFirebase: chatUidFromFirebase, messageFrome: messageFrom, messageTo: messageTo, messageDate: dateFromFB!, messageFromMe: false)
                                    
                                    self.chatArray.append(createdChat)
                                    
                                    
                                    }
                                }
                            }
                        }
                    }
                }
            }
        
        // burda, chatleri gönderdiğimizde diğer tarafta sıralı olması için Date ine göre sıralayıp göndermeliyiz
        
        var chatArraySorted = self.chatArray.sorted(by: {$0.messageDate.compare($1.messageDate) == .orderedDescending} )
        
        self.objectWillChange.send(chatArraySorted)
        
        // benim gönderdiğim ve bana gelen mesajları sırasıyla modelimize implement ettik ve en güncel halini AuthView'a gönderdik.
        
        
        
        
    }
    
    
    
}

*/


class ChatStore : ObservableObject {
    
    
    let db = Firestore.firestore()
    var chatArray : [ChatModel] = []
    
    var objectWillChange = PassthroughSubject<Array<Any>,Never>()
    
    init(){
        
    db.collection("Chats").whereField("chatUserFrom", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener { (snapshot, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    
                    self.chatArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        
                        let chatUidFromFirebase = document.documentID
                        if let chatMessage = document.get("message") as? String {
                            if let messageFrom = document.get("chatUserFrom") as? String {
                                if let messageTo = document.get("chatUserTo") as? String {
                                    if let dateString = document.get("date") as? String {
                                        
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                        let dateFromFB = dateFormatter.date(from: dateString)
                                        
                                        let currentIndex = self.chatArray.last?.id
                                        
                                        let createdChat = ChatModel(id: (currentIndex ?? -1) + 1, message: chatMessage, uidFromFirebase: chatUidFromFirebase, messageFrome: messageFrom, messageTo: messageTo, messageDate: dateFromFB!, messageFromMe: true)
                                        
                                        self.chatArray.append(createdChat)
                                    }
                                }
                            }
                        }
                    }
                    
                    self.db.collection("Chats").whereField("chatUserTo", isEqualTo: Auth.auth().currentUser!.uid)
                        .addSnapshotListener { (snapshot, error) in
                            if error != nil {
                                print(error?.localizedDescription)
                            } else {
                                
                                for document in snapshot!.documents {
                                    
                                    let chatUidFromFirebase = document.documentID
                                    if let chatMessage = document.get("message") as? String {
                                        if let messageFrom = document.get("chatUserFrom") as? String {
                                            if let messageTo = document.get("chatUserTo") as? String {
                                                if let dateString = document.get("date") as? String {
                                                    
                                                    let dateFormatter = DateFormatter()
                                                    dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                                    let dateFromFB = dateFormatter.date(from: dateString)
                                                    
                                                    let currentIndex = self.chatArray.last?.id
                                                    
                                                    let createdChat = ChatModel(id: (currentIndex ?? -1) + 1, message: chatMessage, uidFromFirebase: chatUidFromFirebase, messageFrome: messageFrom, messageTo: messageTo, messageDate: dateFromFB!, messageFromMe: true)
                                                    
                                                    self.chatArray.append(createdChat)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                self.chatArray = self.chatArray.sorted(by: {
                                    $0.messageDate.compare($1.messageDate) ==  .orderedDescending
                                })
                                
                                self.objectWillChange.send(self.chatArray)
                            }
                    }
                    
                    
                }
        }
    }
    
    
}
