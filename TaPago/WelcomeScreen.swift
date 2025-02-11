import SwiftUI

struct WelcomeScreen: View {
    @State private var currentIndex = 0
    let images = ["IMG_Welcome1", "IMG_Welcome2", "IMG_Welcome3", "IMG_Welcome4"]
    let titles = ["Bem-vindo ao TaPago!", "Facilite sua vida financeira", "Organize seus gastos em grupo", "Facilidade e segurança"]
    let subtitles = [
        "Conecte-se com seus amigos e comece a dividir contas.",
        "Gerencie contas compartilhadas de forma simples e segura.",
        "Crie grupos, adicione amigos e registre despesas com facilidade.",
        "Veja quem pagou, quem deve e simplifique acertos."
    ]

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
                .padding(20)

                // Imagem animada com fade-in
                Image(images[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 230)
                    .padding(.bottom, 40)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1.0), value: currentIndex)

                VStack(spacing: 10) {
                    Text(titles[currentIndex])
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, maxHeight: 24)
                        .foregroundColor(Color("Preto-Branco"))
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1.0), value: currentIndex)

                    Text(subtitles[currentIndex])
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .foregroundColor(Color("CinzaClaro-CinzaEscuro"))
                        .multilineTextAlignment(.center)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1.0), value: currentIndex)
                }
                .padding(.bottom, 30)

                Button(action: {
                    // Ação do botão
                }) {
                    Text("Começar")
                        .font(.system(size: 16))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("VerdePrimary"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 50)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            // Inicia um timer para alternar os conteúdos a cada 5 segundos
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % images.count
                }
            }
        }
    }
}

#Preview {
    WelcomeScreen()
}
