import ComposableArchitecture
import SwiftUI

// MARK: - View

public struct TodayView: View {
    let store: Store<AppState, AppAction>

    public var body: some View {
        WithViewStore(store) { viewStore in
            Spacer()
            List {
                ForEachStore(
                    self.store.scope(
                        state: \.milestones,
                        action: AppAction.milestone
                    )
                ) { milestoneStore in
                    WithViewStore(milestoneStore) { milestoneViewStore in
                        MilestoneBaseCellView(store: milestoneStore)
                    }
                }
            }
            .onAppear {
                viewStore.send(.setTimerActive(true))
            }
            .onDisappear {
                viewStore.send(.setTimerActive(false))
            }
        }
    }
}