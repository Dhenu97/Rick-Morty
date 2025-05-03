# 🛸 Rick & Morty iOS App

A modular UIKit-based iOS application that fetches and displays characters, episodes, and locations from the [Rick and Morty API](https://rickandmortyapi.com/). Built with the MVVM architecture pattern and powered by `async/await` for modern and clean networking. The app showcases proper separation of concerns, reusable UI components, and scalable folder structure.

---

## 🔑 Key Features

🧑‍🚀 Browse characters in a dynamic grid view  
📄 Detailed views for characters, episodes, and locations  
🌐 Async API integration using `URLSession` with `async/await`  
🧠 MVVM-based architecture for better maintainability  
🧱 Modular codebase organized into View, ViewModel, Model, and Networking layers  
🧪 Unit test-ready structure  
📲 Adaptive UI optimized for various screen sizes

---

## 🧱 Project Structure

### 📡 Networking

| Component             | Description                                      |
|----------------------|--------------------------------------------------|
| `CharacterApi.swift` | Protocol defining character-fetching behavior    |
| `RMCharacterApi.swift` | Implements character fetch using `URLSession`   |
| `NetworkManager.swift` | Shared service to decode JSON and handle errors |
| `ErrorClass.swift`     | Centralized error enum for API failure handling |

### 🧠 ViewModels

| ViewModel           | Responsibility                                  |
|---------------------|--------------------------------------------------|
| `CharacterVM.swift` | Handles API calls and exposes character data     |
| `EpisodeVM.swift`   | Manages episode fetching and view logic          |

### 🖼️ ViewControllers

| ViewController            | Description                                  |
|---------------------------|----------------------------------------------|
| `RMCharacterViewController` | Displays all characters in a grid          |
| `RMEpisodeViewController`   | Shows list of episodes                     |
| `RMLocationViewController`  | Lists locations with details               |
| `RMDetailVC.swift`          | Detailed metadata display of selected item |
| `CharacterCell.swift`       | Custom character tile in grid view         |

---

## 🧪 Testing Plan

| Layer             | Test Coverage                              |
|------------------|---------------------------------------------|
| ✅ ViewModel      | Unit-tested with mocked services            |
| ✅ Model Decoding | Ensures correct decoding of API responses   |
| ⬜ UI Tests        | (Planned) for user interactions and flows   |

---

## 📲 How to Run

1. **Clone the repo**:
   ```bash
   git clone https://github.com/Dhenu97/Rick-Morty.git
Open in Xcode:

bash
Copy
Edit
cd Rick-Morty
open Rick&Morty.xcodeproj
Build & Run:

Select a simulator (iOS 15+)

Run the app using Cmd + R

🧪 How to Run Tests
Select Rick&Morty scheme in Xcode

Press Cmd + U or go to Product > Test

📦 Tech Stack
✅ Swift 5.9
✅ UIKit
✅ MVVM Architecture
✅ URLSession with async/await
✅ Modular code organization
✅ Xcode 15+

👨‍💻 Author
Dhenu Sri
