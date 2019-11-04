import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var missionsForAstronaut: [Mission] {
        var astronautMissions = [Mission]()
        
        for mission in missions {
            if let _ = mission.crew.first(where: { $0.name == self.astronaut.id }) {
                astronautMissions.append(mission)
            }
        }
        
        return astronautMissions
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions")
                        .font(.headline)
                    ForEach(self.missionsForAstronaut) { mission in
                        Text(mission.displayName)
                    }
                    
                    
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
