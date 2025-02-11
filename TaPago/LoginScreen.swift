import SwiftUI

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isStayLoggedIn = false  // Variável para controlar o estado do toggle
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 20) {
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
                    
                    SecureField("Digite sua senha", text: $password)
                        .padding()
                        .background(Color("CinzaClaro-CinzaEscuro").opacity(0.1))
                        .cornerRadius(8)
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
                
                // Esqueceu a senha no canto direito
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
                    // Ação de login
                    print("Tentando fazer login com e-mail: \(email) e senha: \(password)")
                }) {
                    Text("Acessar")
                        .font(.system(size: 16))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("VerdePrimary"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
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
        }
    }
}

#Preview {
    LoginScreen()
}
