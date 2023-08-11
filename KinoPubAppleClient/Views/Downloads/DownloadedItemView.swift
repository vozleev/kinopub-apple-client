//
//  DownloadedItemView.swift
//  KinoPubAppleClient
//
//  Created by Kirill Kunst on 8.08.2023.
//

import Foundation
import SwiftUI
import KinoPubBackend
import KinoPubUI

public struct DownloadedItemView: View {
  
  private var mediaItem: MediaItem
  private var progress: Float?
  private var onDownloadStateChange: (Bool) -> Void
  
  public init(mediaItem: MediaItem,
              progress: Float?,
              onDownloadStateChange: @escaping (Bool) -> Void) {
    self.mediaItem = mediaItem
    self.progress = progress
    self.onDownloadStateChange = onDownloadStateChange
  }
  
  public var body: some View {
    HStack(alignment: .center) {
      image
        
      VStack(alignment: .leading) {
        title
        subtitle
      }.padding(.all, 5)
      
      if let progress = progress {
        Spacer()
        ProgressButton(progress: progress) { state in
          onDownloadStateChange(state == .pause)
        }
        .padding(.trailing, 16)
      } else {
        Spacer()
      }
    }
    .padding(.vertical, 8)
  }
  
  var image: some View {
    AsyncImage(url: URL(string: mediaItem.posters.small)) { image in
      image.resizable()
        .renderingMode(.original)
        .posterStyle(size: .small)
    } placeholder: {
      Color.KinoPub.skeleton
        .frame(width: PosterStyle.Size.small.width,
               height: PosterStyle.Size.small.height)
    }
    .cornerRadius(8)
  }
  
  var title: some View {
    Text(mediaItem.localizedTitle ?? "")
      .lineLimit(1)
      .font(.system(size: 14.0, weight: .medium))
      .foregroundStyle(Color.KinoPub.text)
      .padding(.bottom, 10)
  }
  
  var subtitle: some View {
    Text(mediaItem.originalTitle ?? "")
      .lineLimit(1)
      .font(.system(size: 12.0, weight: .medium))
      .foregroundStyle(Color.KinoPub.subtitle)
  }
  
}

#Preview {
  DownloadedItemView(mediaItem: MediaItem.mock(), progress: nil) { _ in
    
  }
}

