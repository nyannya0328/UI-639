//
//  Home.swift
//  UI-639
//
//  Created by nyannyan0328 on 2022/08/11.
//

import SwiftUI

struct Home: View {
    @State var currentTab : Tab = .home
    @Namespace var animation
    @State var currentIndex : Int = 0
    var body: some View {
        
        VStack{
            
            TopBar()
            
            SearchBar()
            
            
            (
                Text("Featured").font(.title) + Text(" Movies").font(.callout).foregroundColor(.green)
                
                
                
            )
            .fontWeight(.light)
            .frame(maxWidth: .infinity,alignment: .leading)
            
            CustomCrousel(index: $currentIndex,  items: movies,cardPadding : 150, id: \.id) { movie, cardSize in
                
                Image(movie.artwork)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cardSize.width,height: cardSize.height)
                    .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
            }
            .padding(.horizontal,-15)
            .padding(.vertical)
            
            
            TabBar()
        }
        .padding([.horizontal,.bottom],15)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background{
            
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                
                TabView(selection: $currentIndex) {
                    
                    
                    ForEach(movies.indices,id:\.self){index in
                        
                        Image(movies[index].artwork)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width,height: size.height)
                            .clipped()
                        
                    }
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentIndex)
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                LinearGradient(colors: [
                    
                    .clear,
                    Color("BGTop"),
                    Color("BGBottom")
                    
                ], startPoint: .top, endPoint: .bottom)
                
            }
            
            .ignoresSafeArea()
            
        }
        
    }
    @ViewBuilder
    func  TabBar()->some View{
        
        HStack(spacing:0){
            
            ForEach(Tab.allCases,id:\.rawValue){tab in
                
                
                VStack(spacing:10){
                    
                    
                    Image(tab.rawValue)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20,height: 20)
                        .frame(maxWidth: .infinity,alignment: .center)
                    
                    
                    if currentTab == tab{
                        
                        Circle()
                            .fill(.red)
                            .frame(width: 15,height: 15)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                    
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    
                    withAnimation(.easeInOut(duration: 0.5)){
                        
                        currentTab = tab
                    }
                }
            }
            
        }
        
        
        
    }
    
    @ViewBuilder
    func SearchBar()->some View{
        
        HStack{
            
            Image("Search")
                .renderingMode(.template)
                .resizable()
                .frame(width: 20,height: 20)
            
            TextField("Search ", text: .constant(""))
            
            Image("Mic")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20,height: 20)
                .foregroundColor(.orange)
        }
        .padding(.vertical,10)
        .padding(.horizontal)
        .background{
            
            
            RoundedRectangle(cornerRadius: 10,style: .continuous)
                .fill(.ultraThinMaterial)
        }
        
    }
    @ViewBuilder
    func TopBar()->some View{
        
        HStack{
            
            VStack(alignment: .leading,spacing: 10) {
                
                (
                    
                    Text("Hello") + Text(" Nyan Nyan").font(.largeTitle)
                    
                    
                )
                .fontWeight(.semibold)
                
                Text("Book Your Favorite movie")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.gray)
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            
            Image("p1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60,height: 60)
                .clipShape(Circle())
        }
        
        
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
