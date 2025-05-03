🛸 Rick & Morty
📱 Rick & Morty iOS App
A UIKit-based iOS application that fetches and displays characters, episodes, and locations from the Rick and Morty API. Built using a modular MVVM architecture, async/await for clean networking, and a scalable folder structure for easy maintenance. The app offers a fast, responsive UI with organized navigation between data types.

🔑 Key Features
🧑‍🚀 Browse Rick and Morty characters, episodes, and locations
📄 Detail views with complete metadata and styling
🗺️ Location and episode explorer with navigation
🧱 MVVM architecture with separation of concerns
🌐 Async/await-based network layer
💥 Modular codebase with scalable controller/view separation
🧪 Unit testing supported for ViewModels
📲 Adaptive layout support for iPhones

🚀 Live Preview


🧱 Project Structure
📡 Networking
Component  Description
CharacterApi.swift  Protocol defining character fetch logic
RMCharacterApi.swift  Implements network logic using URLSession
NetworkManager.swift  Shared fetcher using async/await and error handling
ErrorClass.swift  Custom error enums for API failures

🧠 ViewModel
Component  Description
CharacterVM.swift  Drives character data from API to controller
EpisodeVM.swift  Handles episode fetching and view logic

🖼️ UI & Controllers
ViewController  Description
RMCharacterViewController  Displays a grid of characters
RMEpisodeViewController  Lists episodes with tap navigation
RMLocationViewController  Lists all locations
RMDetailedVC  Shows details of a selected item
CharacterCell.swift  Custom UI for character grid
EpisodeCollectionCell.swift  Styled episode cell

🧪 Testing Plan
Layer  Test Coverage
✅ ViewModel  Validates mock fetch, loading state, and error flow
✅ Model Decoding  Verifies decoding of API response models


📲 How to Run
Clone the repo:

bash
Copy
Edit
git clone https://github.com/Dhenu97/Rick-Morty.git
Open the project in Xcode 15+

Select Rick&Morty scheme

Run on any iOS simulator or real device (iOS 15+)

📦 Tech Stack
✅ Swift 5.9
✅ UIKit
✅ MVVM Architecture
✅ URLSession + async/await
✅ XCTest
✅ Modular file organization
✅ Xcode 15+

👩‍💻 About the Author
Dhenu Sri




