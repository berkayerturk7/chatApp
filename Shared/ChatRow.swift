import SwiftUI
import Firebase

struct ChatRow: View {
    
    var chatMessage: ChatModel
    var userToChatFromChatView: UserModel // Kiminle mesajlaştığımızı göstermesi için
    
    var body: some View {
        
        //1- Eğer ilgili chat mesajı benim kullanıcımdan -> tıkladığım kişiye gittiyse
        
        if chatMessage.messageFrome == Auth.auth().currentUser!.uid && chatMessage.messageTo == userToChatFromChatView.uidFromFirebase {
            
            
                HStack {
                Text("Ben: " + chatMessage.message)
                    .bold()
                    .foregroundColor(Color.black)
                    .padding(10)
                }
                .frame(width: UIScreen.main.bounds.width)
            
            
            
        }
        //2- Eğer benim tıkladığım kullanıcı bana yolladıysa
        else if chatMessage.messageFrome == userToChatFromChatView.uidFromFirebase && chatMessage.messageTo == Auth.auth().currentUser!.uid {
            
            HStack {
                Spacer()
                Text("\(userToChatFromChatView.name):" + chatMessage.message)
                    .bold()
                    .foregroundColor(Color.black)
                    .padding(10)
            
            }.frame(width: UIScreen.main.bounds.width)
        }
        
        else {
            // Hiçbiri değilse :) Diğer ChatStore kısmında ilgili sorguyu atmıştık ve tüm mesajlar görünüyordu.
            // İki kişi arasında olmayan hiçbir mesaj görünür olmasın!
            
            //No
            
            
            
        }
    }//.frame(width:UIScreen.main.bounds.width * 0.95)
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chatMessage: ChatModel(id: 0, message: "message", uidFromFirebase: "wdasd", messageFrome: "aa", messageTo: "bb", messageDate: Date(), messageFromMe: true), userToChatFromChatView: UserModel(id: 1, name: "egehan", uidFromFirebase: "asdsad"))
    }
}

