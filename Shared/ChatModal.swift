import Foundation

struct ChatModel: Identifiable {
    
    var id: Int
    var message: String
    var uidFromFirebase: String
    var messageFrome: String
    var messageTo: String
    var messageDate: Date
    
    
    // ek olarak, mesaj benden mi gelmiş, karşıdan mı diye (ona göre sağ sol, renk değişikliği vs yapacağız)
    var messageFromMe: Bool
    
}
