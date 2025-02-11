import SwiftUI

struct LoginScreen: View {
    @Environment(\.presentationMode) var presentationMode // Acessa o modo de apresentação da view
    @State private var email = ""
    @State private var password = ""
    @State private var isStayLoggedIn = false  // Variável para controlar o estado do toggle
    
    // Estados para controle de erros
    @State private var isEmailEmpty = false
    @State private var isPasswordEmpty = false
    @State private var isIncorrectEmail = false // Erro de email incorreto
    @State private var isIncorrectPassword = false // Erro de senha incorreta
    @State private var isAccountLocked = false // Conta bloqueada
    
    // Contador de tentativas falhas
    @State private var failedAttempts = 0
    
    // Estado para controlar se a senha está visível ou oculta
    @State private var isPasswordVisible = false
    
    
    
    // Estado para controle de navegação
    @State private var navigateToHome = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) {
                    // Botão de voltar
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // Fecha a tela atual
                        }) {
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
                            .onChange(of: email) { _ in
                                isEmailEmpty = email.isEmpty
                                isIncorrectEmail = false // Resetando o erro de email
                            }
                        
                        // Mensagens de erro
                        if isEmailEmpty {
                            Text("O campo de e-mail não pode estar vazio.")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .foregroundColor(.yellow)
                        } else if isIncorrectEmail {
                            Text("E-mail incorreto ou não registrado. Tente novamente")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .foregroundColor(.red)
                        }
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
                        
                        // Mensagens de erro
                        if isPasswordEmpty {
                            Text("O campo de senha não pode estar vazio.")
                                .font(.system(size: 12))
                                .fontWeight(.light)
                                .foregroundColor(.yellow)
                        } else if isIncorrectPassword {
                            Text("Senha inválida. Tente novamente")
                                .font(.system(size: 12))
                                .fontWeight(.thin)
                                .foregroundColor(.red)
                        }
                    }
                    
                    // Manter conectado
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("CinzaClaro-CinzaEscuro"), lineWidth: 1)
                                .frame(width: 20, height: 20)
                            
                            if isStayLoggedIn {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color("VerdePrimary"))
                                    .frame(width: 20, height: 20)
                            }
                        }
                        
                        Text("Manter conectado")
                            .font(.system(size: 14))
                            .fontWeight(.light)
                            .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                    }
                    .onTapGesture {
                        isStayLoggedIn.toggle()
                    }
                    .frame(maxWidth:.infinity, alignment: .leading)
                    
                    // Esqueceu a senha
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            // Ação de recuperação de senha
                            print("Acessar tela de recuperação de senha")
                        }) {
                            Text("Esqueceu sua senha?")
                                .font(.system(size: 14))
                                .fontWeight(.light)
                                .foregroundColor(Color("VerdePrimary"))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    // Botão de Login
                    Button(action: {
                        // Lógica de login
                        if isAccountLocked {
                            print("Conta bloqueada")
                        } else {
                            if email.isEmpty || password.isEmpty {
                                isEmailEmpty = email.isEmpty
                                isPasswordEmpty = password.isEmpty
                            } else if email != "leonardot@tapago.com" {
                                isIncorrectEmail = true
                            } else if password != "tapago123" {
                                isIncorrectPassword = true
                                failedAttempts += 1
                            } else {
                                // Sucesso no login
                                print("Login bem-sucedido")
                                failedAttempts = 0 // Resetando o contador de tentativas
                                navigateToHome = true
                            }
                            
                            // Verifica se o número de tentativas falhas excedeu o limite
                            if failedAttempts >= 3 {
                                isAccountLocked = true
                                print("Conta bloqueada devido a tentativas incorretas")
                            }
                        }
                    }) {
                        Text("Acessar")
                            .font(.system(size: 16))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("VerdePrimary"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    // Se a conta estiver bloqueada
                    if isAccountLocked {
                        Text("Sua conta foi bloqueada devido a tentativas incorretas excessivas. Aguarde alguns minutos")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                    
                    // Link para tela de cadastro (opcional)
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
                // Condicional de navegação para a HomeScreen
                NavigationLink(destination: HomeScreen(), isActive: $navigateToHome) {
                    EmptyView()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    LoginScreen()
}
