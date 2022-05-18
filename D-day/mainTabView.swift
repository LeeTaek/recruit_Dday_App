//
//  TabView.swift
//  D-day
//
//  Created by 이택성 on 2022/05/11.
//

import SwiftUI

struct mainTabView: View {
    private enum Tabs {
        case recruit, TodoList
    }

    @State private var selectedTab: Tabs = .recruit

    var body: some View {
//        NavigationView {
            TabView(selection: $selectedTab) {
                Group{
                    Dday()
                        .tag(Tabs.recruit)
                        .tabItem {
                            Text("recruit❗️")
                        }
                  
                    TodoList()
                        .tag(Tabs.TodoList)
                        .tabItem {
                            Text("TodoList📍")
                        }
                    
                }
            }
            .onAppear() {
                UITabBar.appearance().backgroundColor = .init(Color.tabColor)
                UITabBar.appearance().shadowImage = UIImage()
                UITabBar.appearance().unselectedItemTintColor = .init(Color.textFiledColor)
                

                UINavigationBar.appearance().tintColor = .init(Color.textFiledColor)
            }

//        }
//        .navigationViewStyle(.stack)
//
//
    }
    
    


}

struct mainTabView_Previews: PreviewProvider {
    static var previews: some View {
        mainTabView()
    }
}




//MARK: -  tabbar 숨김 처리 여부
// Helper bridge to UIViewController to access enclosing UITabBarController
// and thus its UITabBar
struct TabBarAccessor: UIViewControllerRepresentable {
    var callback: (UITabBar) -> Void
    private let proxyController = ViewController()

    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
                              UIViewController {
        proxyController.callback = callback
        return proxyController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
    }

    typealias UIViewControllerType = UIViewController

    // viewWillAppear 가 탈때 가지고 있는 탭바를 클로저 콜백으로 넘겨준다.
    private class ViewController: UIViewController {
        var callback: (UITabBar) -> Void = { _ in }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let tabBar = self.tabBarController {
                self.callback(tabBar.tabBar)
            }
        }
    }
}


extension View {
    /// 탭바 숨김 처리 여부
    /// - Parameter isHidden:
    /// - Returns:
    func setTabBarVisibility(isHidden : Bool) -> some View {
      background(TabBarAccessor { tabBar in
//          print(">> TabBar height: \(tabBar.bounds.height)")
          // !! use as needed, in calculations, @State, etc.
          // 혹은 높이를 변경한다던지 여러가지 설정들이 가능하다.
          tabBar.isHidden = isHidden
      })
  }
}
