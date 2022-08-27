import SwiftUI
import Firebase



struct Home: View {
    
    @State var shown = true
    let db = Firestore.firestore()
    @ObservedObject var userStore = UserStore()
   
    
    @State var index = 0
    @Namespace var name
    
    
    var body: some View {
      
                // üst panel - wp image, login-signUp
                VStack {
                    Image("whatsapp")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                    
                    HStack(spacing: 0) {
                        Button {
                            withAnimation(.spring()) {
                                index = 0
                            }
                        } label: {
                            VStack {
                                Text("Login")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(index == 0 ? .black : .gray)
                                
                                ZStack {
                                    
                                    // slide animation
                                    
                                    Capsule()
                                        .fill(Color.black.opacity(0.04))
                                        .frame(height: 4)
                                
                                    if index == 0 {
                                        Capsule()
                                        .fill(Color("Color"))
                                        .frame(height: 4)
                                        .matchedGeometryEffect(id: "Tab", in: name)
                                    
                                    }
                                    
                                }
                                    
                            }
                        }
                        
                        Button {
                            withAnimation(.spring()) {
                                index = 1
                            }
                        } label: {
                            VStack {
                                Text("Sign Up")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(index == 1 ? .black : .gray)
                                
                                ZStack {
                                    
                                    // slide animation
                                    
                                    Capsule()
                                        .fill(Color.black.opacity(0.04))
                                    .frame(height: 4)
                                
                                    if index == 1 {
                                        Capsule()
                                        .fill(Color("Color"))
                                        .frame(height: 4)
                                        .matchedGeometryEffect(id: "Tab", in: name)
                                    
                                    }
                                    
                                }
                                
                            }
                        }
                        

                        
                    }
                    .padding(.top,30)
                    
                    // Login View..
                    // Changing Views Based On Index
                    
                            if index == 0 {
                                
                                // ...
                                Login()
                                
                                
                            }
                            else {
                                SignUp()
                                
                            }
                    
                    Spacer(minLength: 0)
                    
                }
    }
}

struct Login : View {
    
    
    
    @State var userEmail = ""
    @State var userPassword = ""
    @State var shown = true
    @ObservedObject var userStore = UserStore()
    
    @State var showPassword = false
    @FocusState var focused: focusedField?
    
    var body: some View {
        
        NavigationView {
            
            if shown {
            
            VStack {
            
                HStack {
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Tekrar Hoşgeldin,")
                        .fontWeight(.bold)
                    Text("Cüneyt")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Spacer(minLength: 0)
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 85, height: 85)
                    .clipShape(Circle())
                
            }
            .padding(.horizontal,25)
            .padding(.top,-90)
            
                VStack(alignment: .leading, spacing: 15) {
                
                    Text("Email")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
              
                    TextField("email", text: $userEmail)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                   
                    Text("Password")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                    ZStack {
                        TextField("password", text: $userPassword)
                            .focused($focused,equals: .unSecure)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .opacity(showPassword ? 1 : 0)
                   
                        SecureField("password", text: $userPassword)
                            .focused($focused,equals: .secure)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .opacity(showPassword ? 0 : 1)
                        
                        
                        Button {
                            self.showPassword.toggle()
                            focused = focused == .secure ? .unSecure : .secure
                        } label: {
                            Image(showPassword ? "eye-fill" : "eye-slash-fill")
                                .foregroundColor(Color.blue)
                        }
                        .offset(x: 150)
                    
                    
                }
                
    
                        Button(action: {}) {
                        Text("Şifremi Unuttum")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                        }
                        .padding(.top,10)


                
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
           
            Button {
                // Login butonuna basıldıktan sonra yapılacaklar
                Auth.auth().signIn(withEmail: self.userEmail, password: self.userPassword) { result, error in
                    
                    if error != nil {
                        print(error!)
                    }
                    else {
                        // giriş yaptıktan sonra ilk çalışacak kodlar
                        print("Giriş yapıldı")
                        self.shown = false
                        // -> diğer else'e gider
                        }
                    }
                
            } label: {
                Text("Login")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(
                        LinearGradient(gradient: .init(colors: [Color.black,Color.blue]) , startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(10)
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
        }
                
            }
            
            else {
                // Giriş başarılı sayfası
                // yukardaki ilk else shown'u false yaptı.
                
                
                NavigationView {
                    List(userStore.userArray) { user in
                        NavigationLink(destination: ChatView(userToChat: user)){
                        // tıklanan user objesini alarak ChatView sayfasına git
                        Text(user.name)
                    }
                }
            }
                .navigationBarTitle(Text("Lets Chat"))
                .navigationBarItems(leading: Button(action: {
                    // log out code
                    do {
                        try Auth.auth().signOut()
                    }
                    catch  {
                        //
                    }
                    self.shown = true
                   
                   
                }, label: {
                    Text("Log Out")
                    
                }))
            }
            
        
    }
    
    }
    
    enum focusedField {
            case secure, unSecure
        }
    // password hide için
    
    
}

struct SignUp : View {
  
    
    let db = Firestore.firestore()
    @ObservedObject var userStore = UserStore()
    
    @State var showAuthView = true
    @State var userEmail = ""
    @State var userPassword = ""
    @State var username = ""
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Hesap Oluştur")
                        .fontWeight(.bold)

                    
                }
                
                Spacer(minLength: 0)
                
                
            }
            .padding(.horizontal,25)
            .padding(.top,30)
            
            VStack(alignment: .leading, spacing: 15) {
                
                Text("Username")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("username", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Text("Email")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("email", text: $userEmail)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Text("Password")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    
                
                SecureField("password", text: $userPassword)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
        
                
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
            
            Button {
                // sign up butonuna basıldıktan sonra olacaklar
                Auth.auth().createUser(withEmail: self.userEmail, password: self.userPassword) { result, error in
                    
                    if error != nil {
                        print(error!)
                    }
                    
                    else {
                        // kayıt olurken hata yoksa
                        var ref: DocumentReference? = nil
                        // ref ile ilk collection'ımızı oluşturduk
                        
                        let myUserDict: [String : Any] = ["username" : self.username,"useremail" : self.userEmail, "useridfromfirebase": result!.user.uid]
                        
                        ref = self.db.collection("Users").addDocument(data: myUserDict)
                        //self.showAuthView = false
                        self.showAuthView = false
                        
                    }
                    
                }
                
            } label: {
                Text("Sign Up")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(
                        LinearGradient(gradient: .init(colors: [Color.black,Color.blue]) , startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(10)
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        
            Login(shown: false)
            
           
            
        
   
    }
}
