import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()

            VStack(alignment: .leading, spacing: 10) { // Alinhado no topo
                HStack (spacing:10){
                    Image("IMG_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 30)

                    Text("TaPago")
                        .font(.system(size: 24))
                        .fontWeight(.light)
                        .foregroundColor(Color("Preto-Branco"))
                }
                .frame(maxWidth: .infinity, alignment: .center) // Alinhado
                .padding(20)
                
                Image("IMG_Welcome1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, alignment: .center) // Alinhado
                
                    .padding(.bottom, 40)
                
                VStack(spacing: 10){
                    Text("Bem-vindo ao TaPago!")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    
                    
                    Text("Conecte-se com seus amigos e comece a dividir contas")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                }
                
            Button 
                .frame(maxWidth: .infinity, alignment: .center) // Alinhado
                .multilineTextAlignment(.center)
            }
            
            
            .padding(.horizontal, 30)
            .padding(.vertical, 50)
            .frame(maxHeight: .infinity, alignment: .top) // Garante alinhamento superior
        }
        
    }
}

#Preview {
    WelcomeScreen()
}
