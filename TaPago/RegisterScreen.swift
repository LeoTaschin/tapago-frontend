import SwiftUI

struct RegisterScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isStayLoggedIn = false  // Variável para controlar o estado do toggle
    @State private var isPasswordVisible = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) {
                    // Botão de voltar
                    HStack {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "arrow.left") // Ícone de seta
                                    .foregroundColor(Color("CinzaClaro-CinzaEscuro")) // Cor do ícone
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
                                    .padding(.trailing, 10) // Ajusta a posição do ícone
                            }
                        }
                    }
                    //Confirmar sua senha
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
                                    .padding(.trailing, 10) // Ajusta a posição do ícone
                            }
                        }
                    }
                    
                    // Botão de Login
                    Button(action: {}) {
                        Text("Continuar")
                            .font(.system(size: 16))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("VerdePrimary"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    HStack {
                        Text("Não tem uma conta?")
                            .font(.system(size: 14))
                            .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                        
                        Button(action: {
                            // Ação para abrir tela de cadastro
                            print("Abrir tela de cadastro")
                        }) {
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
    }
}

#Preview {
    RegisterScreen()
}
