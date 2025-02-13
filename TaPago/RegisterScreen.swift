import SwiftUI
import FirebaseAuth

struct RegisterScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) {
                    // Botão de voltar
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                                    .imageScale(.large)
                            }
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
                    Text("Crie sua conta")
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
                    
                    // Botão de Registro
                    Button(action: {
                        registerUser()
                    }) {
                        Text("Continuar")
                            .font(.system(size: 16))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("VerdePrimary"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                    }

                    HStack(spacing: 5) {
                        Text("Já possui uma conta?")
                            .font(.system(size: 14))
                            .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                        
                        NavigationLink(destination: LoginScreen()) {
                            Text("Entrar agora")
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
    }

    // Função para registrar o usuário
    private func registerUser() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Por favor, preencha todos os campos."
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                print("Usuário registrado com sucesso!")
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    RegisterScreen()
}
