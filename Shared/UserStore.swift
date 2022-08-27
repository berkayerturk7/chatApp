
import SwiftUI
import Firebase
import Combine

// kullanıcıların verilerini saklayacağız ve bir değişiklik olursa hemen ilgili objeye haber vereceğiz

// diğer tarafta oluşturulan objeyi alıp, authView tarafına haber gönderir
// özet: firestore daki yapıyı olduğu gibi, en güncel hali ile bastırmak için bu sınıfı yazdık (userModel'a mapleyerek)

class UserStore: ObservableObject {
    
    // Değişip değişmediğinin kontrolünün olması için bir did değişkeni olmalı.
    
    let db = Firestore.firestore()
    var userArray : [UserModel] = []
    
    var didChange = PassthroughSubject<Array<Any>, Never>()
    
    init() {
        // Firestoredan users collection'ını çektik
        db.collection("Users").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error!)
            }
            else {
                
                self.userArray.removeAll(keepingCapacity: false)
                // userModel'a mapping işlemi for içinde yapılır
                for document in snapshot!.documents {
                    if let userUidFromFirebase = document.get("useridfromfirebase") as? String {
                        if let userName = document.get("username") as? String {
                            let currentIndex = self.userArray.last?.id
                            let createdUser = UserModel(id: (currentIndex ?? -1) + 1, name: userName, uidFromFirebase: userUidFromFirebase)
                            // currentIndex varsa 1 ekle, yoksa 1 çıkar 1 ekle(yoksa 0 elemana ekle)
                            // döngü ilk girdiğinde sadece currentIndex yok, diğerlerinde var
                            // createdUser, UserModel tipinden objelerin olduğu bir array
                            
                            self.userArray.append(createdUser)
                        }
                        
                        
                    }
                }
                self.didChange.send(self.userArray)
                
            }
        }
        
    }
    
    
}
