import SwiftUI
import FirebaseAuth

struct RegisterScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var errorMessage: String? = nil
    @State private var showPasswordMismatchError = false
    @State private var isEmailVerificationSent = false
    @State private var isEmailEntered = false
    
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
                    
                    // Campo de Confirmação de Senha
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Confirme sua senha")
                            .font(.system(size: 16))
                            .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                        
                        ZStack(alignment: .trailing) {
                            if isConfirmPasswordVisible {
                                TextField("Confirme sua senha", text: $confirmPassword)
                                    .padding()
                                    .background(Color("CinzaClaro-CinzaEscuro").opacity(0.1))
                                    .cornerRadius(8)
                            } else {
                                SecureField("Confirme sua senha", text: $confirmPassword)
                                    .padding()
                                    .background(Color("CinzaClaro-CinzaEscuro").opacity(0.1))
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                isConfirmPasswordVisible.toggle()
                            }) {
                                Image(systemName: isConfirmPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                                    .padding(.trailing, 10)
                            }
                        }
                    }

                    // Mensagem de erro de senhas não coincidentes
                    if showPasswordMismatchError {
                        Text("As senhas não coincidem.")
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                    }

                    // Botão de Registro
                    Button(action: {
                        if password == confirmPassword {
                            showPasswordMismatchError = false
                            isEmailEntered = true
                            registerUser()
                        } else {
                            showPasswordMismatchError = true
                        }
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
                
                // Tela de verificação de e-mail
                .navigationDestination(isPresented: $isEmailEntered) {
                    EmailVerificationScreen(email: email)
                }
                
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
                // Envia o e-mail de verificação
                result?.user.sendEmailVerification { error in
                    if let error = error {
                        errorMessage = error.localizedDescription
                    } else {
                        print("E-mail de verificação enviado com sucesso!")
                        // Redireciona para a tela de verificação de e-mail
                        DispatchQueue.main.async {
                            isEmailVerificationSent = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterScreen()
}
