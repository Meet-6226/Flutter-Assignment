# Flutter REST API with Offline Caching

A modern, responsive Flutter web and mobile application that fetches posts from a public REST API (`JSONPlaceholder`), displays them dynamically using `FutureBuilder`, and caches the most recent API response locally using `shared_preferences` for offline availability.

---

## 🌟 Key Features

* **REST API Integration:** Fetches real-time post data from [JSONPlaceholder REST API](https://jsonplaceholder.typicode.com/).
* **Offline Caching:** Uses `shared_preferences` to persist JSON response strings locally, ensuring seamless content display even without an active internet connection.
* **Asynchronous State Handling:** Utilizes Flutter's `FutureBuilder` to handle loading, success, and error states gracefully.
* **Modern Material 3 UI:** Features clean card layouts, post badges, subtle borders, responsive styling, and loading skeleton placeholders.
* **Offline Status Banner:** Automatically detects and notifies users when viewing locally cached offline data.
* **Pull-To-Refresh:** Built-in `RefreshIndicator` and header action button to sync content with the server on demand.

