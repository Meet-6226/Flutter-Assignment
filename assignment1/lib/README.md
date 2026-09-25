# Library Management System in Dart

## 📚 Project Overview

This project is a comprehensive **Library Management System** implemented in Dart inside `lib/main.dart`. It models a modern library catalog containing multiple media types such as Books, DVDs, and Magazines alongside registered library members.

The application demonstrates core object-oriented programming (OOP) principles and functional Dart features, including:
* Abstract Classes and Inheritance
* Polymorphism and Method Overriding
* Data Encapsulation and Getters
* Collection Types (Lists and Maps)
* Conditional Control Flow and Iteration

The system supports adding items to the catalog, registering members, searching items by title, issuing checkouts, and processing item returns.

---

## 🎯 Objectives

The primary objectives of this project are:

1. To design an extensible class hierarchy using abstract base classes.
2. To apply inheritance for specialized item types (Books, DVDs, Magazines).
3. To override methods to customize behavior for derived classes.
4. To store catalog records using List collections and member records using Map collections.
5. To implement case-insensitive search functionality over catalog collections.
6. To model real-world business logic like checkout validation and item returns.

---


## 🛠️ Concepts Used

### 1. Variables and Data Types
Variables store essential item properties and system attributes:
* Item identifiers, titles, authors, directors, and publishers stored as Strings.
* Publication year, page count, runtime, and issue numbers stored as Integers.
* Availability state managed with Boolean flags.

### 2. Abstract Classes and Subclasses
* **LibraryItem**: An abstract parent class defining common attributes like ID, title, publication year, and borrow status.
* **Book**: Child class inheriting from `LibraryItem` with extra fields for author, genre, and page count.
* **DVD**: Child class inheriting from `LibraryItem` with extra fields for director and runtime duration.
* **Magazine**: Child class inheriting from `LibraryItem` with extra fields for issue number and publisher.

### 3. Inheritance & Constructor Forwarding
Subclasses inherit foundational properties from `LibraryItem` and initialize parent parameters using super constructors.

### 4. Method Overriding
Subclasses override the `displayInfo()` method to format and output media-specific details alongside the item's current availability status.

### 5. Polymorphism
The library catalog is stored as a list of `LibraryItem` objects. This allows Books, DVDs, and Magazines to be treated uniformly inside searches, catalog displays, and checkout workflows.

### 6. Collections (Lists and Maps)
* **Lists**: Used to store catalog items and track borrowed items per member.
* **Maps**: Used for key-value member lookups based on unique member IDs.

### 7. Control Flow and Conditionals
* `for-in` loops iterate through the catalog to display items or search titles.
* `if-else` statements validate whether a member exists, whether an item is present, and whether an item is already borrowed before completing transactions.

---

## 📖 OOP Structure

```text
               LibraryItem (Abstract Base Class)
                       │
       ┌───────────────┼───────────────┐
       ▼               ▼               ▼
     Book             DVD           Magazine
```

* **`LibraryItem`**: Parent class holding core attributes (`id`, `title`, `year`, `isBorrowed`) and common getters/methods.
* **`Book` / `DVD` / `Magazine`**: Subclasses extending `LibraryItem` with specialized properties and custom `displayInfo()` implementations.
* **`LibraryMember`**: Manages user details and individual borrowed item collections.
* **`Library`**: Controller managing overall catalog list, member map, search filters, and transaction logic.

---

## 🏁 Conclusion

This project illustrates how Dart can be used to construct a complete object-oriented console application. By leveraging abstract base classes, inheritance, polymorphism, and collections, the system cleanly models real-world catalog management, user registrations, and item transaction workflows.
