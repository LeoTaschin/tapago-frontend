import SwiftUI

struct StartingView: View {
    var body: some View {
        ZStack {
            // Fundo verde cobrindo toda a tela
            Color("VerdePrimary")
                .ignoresSafeArea()

            // Conteúdo da tela (imagem da logo)
            VStack {
                Image("logo")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
        }
    }
}

#Preview {
    StartingView()
}
