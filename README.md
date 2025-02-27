# 🌟 ORU_Phones_Assignment

![Flutter](https://img.shields.io/badge/Flutter-3.4.4-blue?style=flat-square&logo=flutter&logoColor=white)  
![Build](https://img.shields.io/badge/Build-Passing-brightgreen?style=flat-square)  
![Figma](https://img.shields.io/badge/Design-Figma-red?style=flat-square&logo=figma&logoColor=white)  
![Firebase](https://img.shields.io/badge/Firebase-Notification-brightgreen?style=flat-square&logo=firebase)

This **Assignment** is designed to evaluate your **Flutter development** skills and **problem-solving** abilities. The task closely resembles features from our **OruPhones app**

---  

## 🎨 Design Reference

Explore the meticulously crafted UI/UX on [Figma](https://www.figma.com/design/l2K16E94wmCvWeG2EpWXVF/ORUphones-Flutter-Dev-Intern-Assignment?node-id=0-1&p=f&t=gPdckx0LXhrGvGHS-0).

---  

## ✨ Features

✔ **Splash Screen** - Checks authentication state & navigates accordingly.  
✔ **Login OTP Screen** - Enter phone number & request OTP.  
✔ **Verify OTP Screen** - Enter OTP & authenticate user.  
✔ **Confirm Name Screen** - Prompt new users to set a name before proceeding.  
✔ **State Management** - Use Flutter Bloc.
✔ **Standalone & Bottom Sheet Support** - Authentication screens work both as full pages and bottom sheets.  


---  

## 🛠️ Tech Stack

| Aspect              | Technology           | Description                      |  
|---------------------|----------------------|----------------------------------|  
| **Framework**       | [Flutter](https://flutter.dev)   | Cross-platform mobile development. |   
| **State Management**| [Flutter BLoC](https://bloclibrary.dev/) | Simplified state handling.       |  
| **Networking**      | [Dio](https://pub.dev/packages/dio) | Robust HTTP client.             |  
| **Routing**         | [GoRouter](https://pub.dev/packages/go_router) | Dynamic navigation.             |   

---  

## 🚀 Getting Started

### Prerequisites

Ensure the following are installed on your system:
- **Flutter SDK**: Version `>=3.4.4 <4.0.0`.
- **Dart SDK**.
- **Android/iOS Setup**: For Flutter development.

### Installation

1. **Clone the Repository**:
   ```bash  
   git clone https://github.com/AmbrishTripathi6974/oru_phones.git  
   cd oru_phones  
   ```  

2. **Install Dependencies**:
   ```bash  
   flutter pub get  
   ```

2. **Connect Firebase**:
   ```bash  
   flutterfire configure "demo project"  
   ```  

3. **Run the App**:
   ```bash  
   flutter run  
   ```  

---  

## 📦 Dependencies

A glimpse at the major dependencies:

| Dependency            | Version | Purpose                                  |  
|-----------------------|---------|------------------------------------------|  
| `flutter_bloc`        | ^8.1.6  | State management            |  
| `dio`                 | ^5.7.0  | Advanced HTTP client.                    |  
| `go_router`           | ^14.6.1 | Simplified navigation management.        |  
| `firebase_flutter`    | ^1.2.0  | Authentication and backend integration.  |  

For a complete list, check out the [`pubspec.yaml`](./pubspec.yaml).

---  

## 📖 Project Structure

The project follows **clean architecture principles** to ensure scalability and maintainability:

```
lib/  
├── core/               # Core utilities and constants  
├── data/               # Data sources and models  
├── features/           # App features grouped by functionality  
├── presentation/       # UI layers (widgets and screens)  
└── main.dart           # App entry point  
```  

---  

## 🌐 ORU_Phones

**OruPhone** is a feature-rich mobile application designed to enhance the shopping experience for **smartphones** and **accessories**. It offers seamless product discovery, **smart filtering**, and personalized **recommendations**. With a clean **UI**, intuitive navigation, and real-time updates, **OruPhones** ensures a smooth and engaging user experience. 🚀

---   

Made with 💙 by **Ambrish**.  
