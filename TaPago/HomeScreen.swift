import SwiftUI
import FirebaseAuth

struct HomeScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isLoggedOut = false // Controla a navegação após o logout

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
                    
                    // Botão de Logout
                    Button(action: {
                        logoutUser()
                    }) {
                        Text("Deslogar")
                            .font(.system(size: 16))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 30)
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isLoggedOut) {
            WelcomeScreen() // Redireciona para a tela de boas-vindas após o logout
        }
    }

    // Função para deslogar o usuário
    private func logoutUser() {
        do {
            try Auth.auth().signOut() // Desloga o usuário
            isLoggedOut = true // Navega para a tela de boas-vindas
            print("Usuário deslogado com sucesso!")
        } catch {
            print("Erro ao deslogar: \(error.localizedDescription)")
        }
    }
}

#Preview {
    HomeScreen()
}
