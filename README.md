# Dart Mock API Program

## About

This is a simple Dart program created to understand Null Safety, Future, async/await, mock API data, and error handling.

The program simulates fetching user data from an API and displays the data in the console.

## Concepts Used

* Null Safety
* Future
* async/await
* Mock API
* Error Handling
* try-catch

## How It Works

The program creates a `User` class containing user details such as ID, name, and email.

A mock API function is created using `Future` and `Future.delayed()` to simulate an API request.

The program uses `async` and `await` to wait for the data before displaying it.

Null values are checked and handled properly. Errors are handled using `try-catch`.

## How to Run

Make sure Dart is installed.

Check the Dart version:

```bash
dart --version
```

Run the program:

```bash
dart run main.dart
```

## Sample Output

```text
Fetching user data...
User data found!
ID: 1
Name: Meet
Email: Email not available
```

## Learning Outcome

This assignment helped me understand how asynchronous operations work in Dart. I learned how to use Future, async/await, Null Safety, and error handling in a simple program.
