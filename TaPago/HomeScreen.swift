
import SwiftUI

struct HomeScreen: View {
    @Environment(\.presentationMode) var presentationMode // Acessa o modo de apresentação da view
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) {
                    
                    HStack{
                        // Botão de voltar personalizado
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
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 30)
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeScreen()
}
