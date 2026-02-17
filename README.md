# VolunteeringApp

A location-aware, real-time volunteer coordination platform built with Flutter and Firebase.

VolunteeringApp enables communities to submit, review, and fulfill service requests through a structured approval workflow and cloud-backed architecture.

<p float="left">
  <img src="https://github.com/Koorikdat/VolunteeringApp/assets/45243399/7ed3484e-659c-4796-8e56-f6e0d942e2e7" width="400" height="800"/>
  <img src="https://github.com/Koorikdat/VolunteeringApp/assets/45243399/920de786-c585-4a4e-9a65-a4c500f4e702" width="400" height="800"/>
</p>

---

## 🚀 Product Vision

VolunteeringApp was built to solve a coordination problem:

Communities often struggle to efficiently connect people who need help with those willing to provide it. This platform introduces a structured, role-based system that ensures requests are verified, location-aware, and distributed in real time.

The goal: scalable, secure, and frictionless community coordination.

---

## 🏗 System Architecture

### Frontend
- Flutter (single shared codebase)
- Responsive UI components
- Platform-agnostic architecture (Android, iOS, Web-ready)

### Backend (Serverless)
- Firebase Authentication
- Cloud Firestore (real-time database)
- Role-based access control
- Structured request state transitions (submitted → approved → fulfilled)

### Core Architectural Decisions
- Serverless backend for scalability and reduced infrastructure overhead
- Stateless client design with database-driven UI updates
- Centralized request approval layer to prevent spam and misuse
- Modular validation layer for authentication security

---

## 🔐 Authentication & Security

- Firebase Authentication integration
- Regex-based email validation
- Enforced password strength requirements:
  - Minimum length
  - Uppercase character requirement
  - Numeric requirement
- Defensive client-side validation to reduce invalid writes

---

## 📍 Location-Aware Coordination

- Device-level location integration
- Contextual volunteer matching
- Geo-relevant request browsing

Designed to scale to region-based filtering and future geospatial indexing.

---

## ⚙️ Key Features

- User account creation and login
- Request submission workflow
- Administrative approval system
- Real-time request updates
- Structured database schema
- Cross-platform deployment capability
- Android prototype build included

---

## 🧠 Engineering Focus

This project emphasizes:

- Clean separation of UI and logic
- Maintainable Flutter project structure
- Scalable Firestore document modeling
- Secure input validation patterns
- Cross-platform mobile architecture

The system is designed to be extendable to:
- Push notifications
- Role-based dashboards
- Analytics and usage tracking
- Cloud Functions automation

---

## 🛠 Tech Stack

- Flutter
- Dart
- Firebase Authentication
- Firebase Firestore
- FlutterFlow

---

## 📂 Repository Structure

```
VolunteeringApp/
│
├── lib/                  # Application logic & UI
├── android/              # Android platform config
├── ios/                  # iOS support
├── web/                  # Web support
├── windows/              # Windows support
├── macos/                # macOS support
├── linux/                # Linux support
├── assets/images/        # Static assets
├── test/                 # Unit & widget tests
├── pubspec.yaml          # Dependencies
└── Volunteer-App.apk     # Android build artifact
```

---

## ▶️ Running Locally

Clone the repository:

```
git clone https://github.com/Koorikdat/VolunteeringApp.git
```

Navigate to the project:

```
cd VolunteeringApp/Volunteer_App-main
```

Install dependencies:

```
flutter pub get
```

Run the app:

```
flutter run
```

---

## 🌐 Firebase Console

https://console.firebase.google.com/project/volunteer-app-ecc3f/authentication/users

---

## 👤 Author

**Maisam Anjum**  
Mobile & Systems Developer  

Supervisor: Dr. Renata Dividino  
Design: Nicole Roasa  

---

## 📌 Summary

VolunteeringApp demonstrates:

- End-to-end mobile product development  
- Real-time cloud-integrated architecture  
- Secure authentication workflows  
- Cross-platform engineering  
- Scalable system design decisions  

Built with production-oriented architectural thinking.
