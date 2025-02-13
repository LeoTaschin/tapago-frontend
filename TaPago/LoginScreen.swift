import SwiftUI
import FirebaseAuth

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var errorMessage: String? = nil
    @State private var isAuthenticated = false // Controla a navegação após o login

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) {
                   
                    // Logo e título
                    HStack(spacing: 10) {
                        Image("IMG_Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 30)
                        
                        Text("TaPago")
                            .font(.system(size: 24))
                            .fontWeight(.light)
                            .foregroundColor(Color("Preto-Branco"))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 50)
                    
                    // Título da tela
                    Text("Acesse sua conta")
                        .font(.system(size: 24))
                        .fontWeight(.light)
                        .foregroundColor(Color("Preto-Branco"))
                    
                    // Campo de E-mail
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Endereço de e-mail")
                            .font(.system(size: 16))
                            .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                        
                        TextField("Digite seu e-mail", text: $email)
                            .padding()
                            .background(Color("CinzaClaro-CinzaEscuro").opacity(0.1))
                            .cornerRadius(8)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    
                    // Campo de Senha
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Senha")
                            .font(.system(size: 16))
                            .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                        
                        ZStack(alignment: .trailing) {
                            if isPasswordVisible {
                                TextField("Digite sua senha", text: $password)
                                    .padding()
                                    .background(Color("CinzaClaro-CinzaEscuro").opacity(0.1))
                                    .cornerRadius(8)
                            } else {
                                SecureField("Digite sua senha", text: $password)
                                    .padding()
                                    .background(Color("CinzaClaro-CinzaEscuro").opacity(0.1))
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                    
                    // Botão de Login
                    Button(action: {
                        loginUser()
                    }) {
                        Text("Acessar")
                            .font(.system(size: 16))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("VerdePrimary"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    // Mensagem de erro
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                    
                    // Cadastro
                    HStack {
                        Text("Não tem uma conta?")
                            .font(.system(size: 14))
                            .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                        
                        NavigationLink(destination: RegisterScreen()) {
                            Text("Cadastre-se")
                                .font(.system(size: 14))
                                .foregroundColor(Color("VerdePrimary"))
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 30)
                .frame(maxHeight: .infinity, alignment: .top)
                
                .navigationDestination(isPresented: $isAuthenticated) {
                    HomeScreen() // Substitua por sua tela de verificação de e-mail
                }
            }
        }
        .navigationBarHidden(true)
    }

    // Função para fazer login
    private func loginUser() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Por favor, preencha todos os campos."
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                print("Usuário logado com sucesso!")
                DispatchQueue.main.async {
                    isAuthenticated = true // Navega para a próxima tela
                    print("isAuthenticated alterado para: \(isAuthenticated)") // Debug
                }
            }
        }
    }
}

#Preview {
    LoginScreen()
}
