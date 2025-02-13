import SwiftUI
import FirebaseAuth

struct LoginScreen: View {
    @State private var email = ""
    @State private var senha = ""
    @State private var errorMessage: String? = nil
    @State private var isAuthenticated = false // Controla a navegação após o login

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) {
                    // Botão de voltar
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                                .imageScale(.large)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
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
                        
                        SecureField("Digite sua senha", text: $senha)
                            .padding()
                            .background(Color("CinzaClaro-CinzaEscuro").opacity(0.1))
                            .cornerRadius(8)
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
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $isAuthenticated) {
            HomeScreen() // Navega para a tela inicial após o login
        }
    }

    // Função para fazer login
    private func loginUser() {
        guard !email.isEmpty, !senha.isEmpty else {
            errorMessage = "Por favor, preencha todos os campos."
            return
        }

        Auth.auth().signIn(withEmail: email, password: senha) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                print("Usuário logado com sucesso!")
                isAuthenticated = true // Navega para a próxima tela
            }
        }
    }
}

#Preview {
    LoginScreen()
}
