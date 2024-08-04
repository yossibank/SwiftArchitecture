import SwiftUI

struct Particle: Identifiable {
    let id: UUID
    let angle: Double
}

public struct LoadingParticleView: View {
    @State private var particles: [Particle] = []

    private let radius: CGFloat = 20.0

    public init() {}

    public var body: some View {
        ZStack {
            ForEach(particles) { particle in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(.gray)
                    .offset(
                        x: radius * CGFloat(cos(particle.angle * .pi / 180)),
                        y: radius * CGFloat(sin(particle.angle * .pi / 180))
                    )
            }
        }
        .onAppear {
            particles = (0..<8).map { index in
                Particle(
                    id: .init(),
                    angle: Double(index) * (360.0 / Double(8))
                )
            }

            withAnimation(.linear(duration: 1.5).repeatForever(
                autoreverses: true
            )) {
                particles = particles.map {
                    .init(
                        id: $0.id,
                        angle: $0.angle - 600.0
                    )
                }
            }
        }
    }
}

#Preview {
    LoadingParticleView()
}
