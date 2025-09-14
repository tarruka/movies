# 🎬 Movies App

A simple SwiftUI application that displays a list of movies, allows sorting and ordering, and shows detail screens.  
The app was built as a demo project to practice **SwiftUI navigation**, **state management**, and **testing with XCTest / XCUITest**.

---

## ✨ Features

- **Movie List**
  - Fetch movies from a network client (mocked in tests).
  - Infinite scroll pagination.
  - Search movies by title.
  - Sort by **Title** or **Year**.
  - Toggle order between **Ascending** and **Descending**.
  - Clear sort and reset to default list.

- **Movie Detail**
  - Show movie information with `MovieStateManager` support.
  - Toggle selection state (`Select` / `Remove`).

- **Error Handling**
  - Snackbar-style error messages shown from the top.

---

## 🏗️ Architecture

The project follows a clean, modular approach:

- **Models**
  - `Movie`: main domain entity.

- **Networking**
  - `NetworkClient`: protocol for fetching data.
  - `NetworkClientMock`: used in tests.

- **State Management**
  - `HomeViewModel`: handles fetching, sorting, searching, pagination.
  - `MovieStateManager`: manages selected movies state across the app.

- **Navigation**
  - `Navigator`: central navigation manager with enum-based `Destination`.
  - `NavigatorView`: wraps SwiftUI `NavigationStack` and handles routes.

- **UI Components**
  - `HomeView`: main screen.
  - `MovieCard`: individual movie item.
  - `MovieDetailView`: detail screen.
  - `HomeHeaderView`: header with search + sorting controls.
  - `HeaderButton`: reusable button for sort/order/clear.
  - `SnackbarView`: animated error messages.

---

## 🧪 Testing

The app includes both **unit tests** and **UI tests**.

### Unit Tests
- ✅ Sorting by title ascending / descending.
- ✅ Sorting by year ascending / descending.
- ✅ Search filtering.
- ✅ Pagination logic (loading next page).
- ✅ JSON parsing into `Movie` model.

### UI Tests
- ✅ Verify movie list renders with correct accessibility identifiers:
  - `movie-list`
  - `movie-item`
  - `name`, `year`, `imdb`
- ✅ Verify sort/order/clear buttons exist:
  - `sortToggleButton`
  - `orderToggleButton`
  - `clearSortButton`
- ✅ Tap interactions update sorting state.
