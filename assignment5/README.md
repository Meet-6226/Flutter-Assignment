# Flutter Todo List

A basic Todo List application built using Flutter. This project demonstrates how to use `StatefulWidget` and `setState()` to manage and update the application state.

## Features

* Add new Todo tasks
* Mark tasks as completed
* Unmark completed tasks
* Delete Todo tasks
* Prevent empty tasks from being added
* Display completed tasks with a strikethrough effect
* Simple and beginner-friendly user interface

## Technologies Used

* Flutter
* Dart
* StatefulWidget
* setState()
* TextField
* ListView
* Checkbox
* IconButton
* Card

## How It Works

The application stores Todo items in a list. Each Todo contains a title and a completion status.

When a new task is entered and the Add button is pressed, the task is added to the list using `setState()`.

The Checkbox is used to mark a task as completed or incomplete. When the checkbox is changed, `setState()` updates the task's completion status and refreshes the screen.

Each Todo also has a delete button. When the delete button is pressed, the selected task is removed from the list using `setState()`.

## Project Structure

```text
todo_list/
│
├── lib/
│   └── main.dart
│
├── android/
├── ios/
├── web/
├── test/
├── pubspec.yaml
└── README.md
```

## Getting Started

### 1. Clone the Repository

```bash
git clone <your-github-repository-url>
```

### 2. Open the Project

Open the project folder in VS Code or Android Studio.

### 3. Install Dependencies

Run:

```bash
flutter pub get
```

### 4. Run the Application

Connect a device or start an emulator and run:

```bash
flutter run
```

## Learning Outcomes

Through this project, I learned how to create a Flutter application using `StatefulWidget` and manage changing data using `setState()`.

I also learned how to take user input using a `TextField`, display a dynamic list using `ListView`, and perform basic operations such as adding, deleting, and updating Todo items.

The project helped me understand how Flutter rebuilds the user interface when the application state changes.

## Future Improvements

Some features that could be added in the future include:

* Saving Todos permanently using a local database
* Adding Todo categories
* Adding due dates
* Adding search functionality
* Adding a dark mode

## Author

Meet Alshi
