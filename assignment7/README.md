# Flutter 3-Screen App (Named Routes & Validation)

A modern, multi-screen Flutter application demonstrating **Named Routes navigation**, dynamic state handling, form validation, and data passing across screens using standard **Material 3 UI** design patterns.

---

## 📱 Application Screens

* **Home Screen (`/`)**: Welcome landing page with smooth gradient branding and a call-to-action button to start registration.
* **Registration Screen (`/register`)**: Form interface with real-time validation for full name, valid email formats, and minimum password lengths.
* **Detail Screen (`/detail`)**: Dynamic profile summary displaying user parameters passed through route arguments.

---

## ✨ Features

* 📍 **Named Routes Architecture**: Organized navigation stack managed in a centralized route mapping.
* ✍️ **Form Validation**: 
  * Required field checking (`TextFormField` validation).
  * Regex email pattern matching (`example@domain.com`).
  * Password length check (minimum 6 characters) with a show/hide toggle.
* 🔄 **Data Passing**: Route arguments map user input seamlessly from the form to the detail card.
* 🎨 **Material 3 UI Design**: Custom color palette, rounded text fields, elevated profile card layout, and responsive UI.

