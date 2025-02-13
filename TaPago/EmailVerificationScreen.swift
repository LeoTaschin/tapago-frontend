import SwiftUI
import FirebaseAuth

struct EmailVerificationScreen: View {
    @State private var verificationCode = "" // Isso pode ser removido, pois o Firebase não requer o código
    @State private var errorMessage: String? = nil
    @State private var isVerified = false
    @State private var isLoading = false
    var email: String
    @Environment(\.presentationMode) var presentationMode

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
                    Text("Verificação de E-mail")
                        .font(.system(size: 24))
                        .fontWeight(.light)
                        .foregroundColor(Color("Preto-Branco"))
                    
                    // Instrução para verificar o e-mail
                    Text("Verifique \(email) e clique no link para confirmar sua conta.")
                        .font(.system(size: 16))
                        .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    
                    // Botão para reenviar o e-mail de verificação
                    Button(action: {
                        sendVerificationEmail()
                    }) {
                        Text("Reenviar E-mail de Verificação")
                            .font(.system(size: 16))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("VerdePrimary"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(isLoading) // Desabilita o botão enquanto a requisição está em andamento
                    
                    // Indicador de carregamento
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("VerdePrimary")))
                    }
                    
                    // Mensagem de erro
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                    
                    // Navegação para a tela inicial após verificação bem-sucedida
                    if isVerified {
                        NavigationLink(destination: HomeScreen()) {
                            EmptyView()
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

    // Função para reenviar o e-mail de verificação
    private func sendVerificationEmail() {
        guard let user = Auth.auth().currentUser else { return }
        isLoading = true
        errorMessage = nil
        
        user.sendEmailVerification { error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    isVerified = true
                    print("E-mail de verificação enviado com sucesso!")
                }
            }
        }
    }
}

#Preview {
    EmailVerificationScreen(email: "usuario@exemplo.com")
}
