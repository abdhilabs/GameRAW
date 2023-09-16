//
//  GameDetailView.swift
//  GameRAW
//
//  Created by Abdhi P on 21/07/23.
//

import Common
import DesignSystem
import Dependiject
import Domain
import SwiftUI

public struct GameDetailView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @Store var viewModel = Factory.shared.resolve(GamesViewModel.self)
  
  @State private var isFavorite = false
  @State private var isLoading = false
  @State private var isReadMore = false
  @State private var error: ErrorType = (false, "")
  @State private var item: Game = .init()
  
  private let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  var id: Int = 0
  
  public init(id: Int) {
    self.id = id
  }
  
  public var body: some View {
    ZStack {
      Color.Background.background
      
      if isLoading {
        ProgressView()
          .progressViewStyle(.circular)
      } else if error.state {
        GeneralErrorView(message: error.message) {
          getGame()
        }
      } else {
        VStack {
          GameRAWWebImage(urlImage: item.backgroundImage)
            .frame(width: UIScreen.screenWidth, height: 260)
            .clipped()
            .overlay(Color.black.opacity(0.5))
            .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .top, endPoint: .bottom))
          
          Spacer()
        }
        
        ScrollView(showsIndicators: false) {
          VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
              HStack(alignment: .center, spacing: 4) {
                ForEach(item.platforms, id: \.self) { platform in
                  Image(platform.iconPlatform)
                    .resizable()
                    .frame(width: 16, height: 16)
                }
                
                HorizontalSpacer(width: 2)
                
                if item.playtime != 0 {
                  Text("game.detail.content.average-playtime-%lld".localizedPlural(item.playtime))
                    .font(.system(size: 12))
                    .italic()
                }
                
                Spacer()
              }
              
              Text(item.title)
                .font(.largeTitle)
                .bold()
              
              if !item.releaseDate.isEmpty {
                VerticalSpacer(height: 4)
                
                Text(item.releaseDate.stringToDate()?.string().uppercased() ?? "")
                  .font(.system(size: 11))
                  .foregroundStyle(.black)
                  .padding(.horizontal, 4)
                  .padding(.vertical, 2)
                  .background(Color.white.cornerRadius(4))
              }
            }
            .padding([.top, .horizontal], 16)
            
            VStack(alignment: .leading, spacing: 8) {
              let rating = item.ratings.first
              VStack(alignment: .leading) {
                Text(rating?.title ?? "")
                  .font(.title2)
                  .bold()
                
                VerticalSpacer(height: 4)
                
                let rating = rating?.subtitle ?? ""
                Text("game.detail.content.ratings-%@".localizedPlural(rating))
                  .font(.footnote)
              }
              
              let ratings = item.ratings.sorted(by: {
                $0.id < $1.id
              })
              LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                ForEach(ratings, id: \.id) { content in
                  HStack(spacing: 4) {
                    Circle()
                      .frame(width: 10, height: 10)
                      .foregroundStyle(Color(content.iconColor))
                    
                    Text(content.title)
                      .font(.callout)
                    
                    Text(content.subtitle)
                      .font(.subheadline)
                      .foregroundStyle(Color.General.grayLight)
                  }
                }
              }
            }
            .padding([.top, .horizontal], 16)
            
            VStack(alignment: .leading, spacing: 8) {
              Text("game.detail.content.about".localized)
                .font(.title2)
                .bold()
              
              VStack(alignment: .leading) {
                Text(item.description)
                  .font(.body)
                  .lineLimit(isReadMore ? nil : 8)
                
                let label: String = {
                  let key = isReadMore ? "game.detail.action.show-less" : "game.detail.action.read-more"
                  return key.localized
                }()
                Button(label) {
                  withAnimation {
                    isReadMore.toggle()
                  }
                }
                .font(.callout)
              }
            }
            .padding([.top, .horizontal], 16)
            
            VStack(alignment: .leading, spacing: 8) {
              LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                ForEach(item.subDetails, id: \.title) { content in
                  VStack(alignment: .leading, spacing: 4) {
                    Text(content.title.localized)
                      .font(.subheadline)
                      .foregroundStyle(Color.General.grayLight)
                    
                    if content.title != "game.detail.content.title.metascore" {
                      Text(content.subtitle.localized)
                        .font(.body)
                    } else {
                      Text(content.subtitle)
                        .foregroundStyle(Color(content.iconColor))
                        .font(.body)
                        .bold()
                        .padding(4)
                        .overlay(
                          RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(content.iconColor), lineWidth: 1)
                        )
                    }
                    
                    Spacer()
                  }
                }
              }
            }
            .padding([.top, .horizontal], 16)
            
            Spacer()
          }
        }
      }
    }
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          dismiss()
        } label: {
          HStack {
            Image(systemName: "chevron.backward")
            
            Text("game.detail.action.back".localized)
          }
        }
      }
      
      if !isLoading && !error.state {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            if isFavorite {
              viewModel.deleteGame(with: id)
            } else {
              viewModel.saveGame(item: item)
            }
            
            viewModel.isGameFavorited(with: id)
          }, label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
          })
        }
      }
    }
    .onAppear {
      getGame()
    }
    .viewState(
      viewModel.gameDetail,
      onLoading: { state in
        isLoading = state
      },
      onSuccess: { data in
        withAnimation {
          item = data
        }
      },
      onFailed: { error in
        self.error = (true, error.localizedDescription)
        print("Error: \(error.localizedDescription)")
      }
    )
    .viewState(
      viewModel.isGameFavorite,
      onSuccess: { data in
        isFavorite = data
      },
      onFailed: { error in
        self.error = (true, error.localizedDescription)
        print("Error: \(error.localizedDescription)")
      }
    )
    .viewState(
      viewModel.saveGame,
      onFailed: { error in
        self.error = (true, error.localizedDescription)
        print("Error: \(error.localizedDescription)")
      }
    )
    .viewState(
      viewModel.deleteGame,
      onFailed: { error in
        self.error = (true, error.localizedDescription)
        print("Error: \(error.localizedDescription)")
      }
    )
  }
  
  private func getGame() {
    error = (false, "")
    viewModel.getDetailGame(with: id)
    viewModel.isGameFavorited(with: id)
  }
}

struct GameDetailViewProvider_Previews: PreviewProvider {
  static var previews: some View {
    GameDetailView(id: 0)
  }
}
