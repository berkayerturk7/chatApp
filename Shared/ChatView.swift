import SwiftUI
import Firebase

struct ChatView: View {
    
    let db = Firestore.firestore()
    var userToChat : UserModel
    // hangi user'a tıklandı bilgisi
    @State var messageToSend = ""
    @ObservedObject var chatStore = ChatStore()
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                ForEach(chatStore.chatArray) { chats in
                
                //Text(chats.message) -> Chat Store daki filtrelemeyi geçen tüm chatlari, her kullanıcıya tıkladığımızda gösterir
                // Biz X e tıkladığımızda sadece X ile aramızda geçen sohbeti görmek istediğimiz için ChatRow yapısını yazdık.
                ChatRow(chatMessage: chats, userToChatFromChatView: self.userToChat)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            
            HStack {
                TextField("Message here...", text: $messageToSend).frame(minHeight: 50).padding()
                Button(action: sendMessageToFirebase) {
                    Text("Send")
                }.frame(minHeight:50).padding()
            }
        }
        
    }
    
    func sendMessageToFirebase() {
        // mesajı firestora göndermek için kullanacağımız fonksiyon
        
        var ref: DocumentReference? = nil
        
        let myChatDictionary : [String : Any] = ["chatUserFrom": Auth.auth().currentUser!.uid, "chatUserTo": userToChat.uidFromFirebase, "date": generateDate(), "message": self.messageToSend]
        
        ref = self.db.collection("Chats").addDocument(data: myChatDictionary, completion: { (error) in
            
            if error != nil {
                print(error!)
            }
            else {
                // mesaj göndermek başarılı
                // chati temizle
                self.messageToSend = ""
                
                
                
            }
        })
        
        }
    
    func generateDate() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
        
    }
}









struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
       
            ChatView(userToChat: UserModel(id: 0, name: "", uidFromFirebase: "sdasd"))
     
        
        
    }
}

