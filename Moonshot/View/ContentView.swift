import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showCrewNames = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
//                        .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if !self.showCrewNames {
                            Text(mission.formattedLaunchDate)
                        }
                        if self.showCrewNames {
                            ForEach(mission.crew, id: \.self.name) { crewRole in
                                Text(crewRole.name)
                            }
                        }
                        
                    }
                }
            }
            .navigationBarItems(trailing: Toggle(isOn: $showCrewNames) {
                Text("Show crew")
            })
        .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
