# Campus Food Ordering App

A comprehensive Flutter-based campus food ordering application built with **Clean Architecture** and **BLoC pattern** for state management. This demo app showcases a complete food ordering system with three user roles: Students/Staff, Vendors, and Campus Administrators.

## 📱 Project Overview

This is a feature-rich campus food ordering application that demonstrates:
- **Clean Architecture** implementation with Domain-Driven Design
- **BLoC Pattern** for robust state management
- **Role-based access control** with three distinct user types
- **Repository Pattern** for data access abstraction
- **Material Design 3** for modern UI/UX

## 🎯 Features

### 🎓 Student/Staff Features
- **Authentication**: Role-based login system
- **Wallet Management**: Digital wallet with balance tracking and top-up functionality
- **Vendor Discovery**: Browse and filter campus food vendors
- **Ordering System**: Complete cart functionality with order placement
- **Pickup Slot Booking**: Select convenient pickup times
- **Real-time Order Tracking**: Live order status updates
- **Order History**: View and reorder past orders
- **Ratings & Feedback**: Rate vendors and provide feedback

### 🏪 Vendor Features
- **Authentication**: Secure vendor login
- **Order Management**: Kitchen display system with accept/reject functionality
- **Menu Management**: Full CRUD operations for menu items
- **Discount Management**: Create and manage promotional offers
- **Sales Reports**: Analytics dashboard with revenue insights

### 👨‍💼 Admin Features
- **Role-Based Access**: Administrative dashboard
- **Vendor Onboarding**: Approve or deny new vendor applications
- **System Oversight**: Monitor all system data and activities
- **Analytics Dashboard**: Comprehensive system analytics with charts
- **Feedback Management**: Handle user complaints and feedback

## 🛠️ Technology Stack

### **Core Dependencies**
- **Flutter**: ^3.10.0 (UI framework)
- **Dart SDK**: >=3.0.0 <4.0.0
- **flutter_bloc**: ^8.1.3 (State management)
- **equatable**: ^2.0.5 (Value equality)
- **fl_chart**: ^0.63.0 (Charts and analytics)
- **flutter_svg**: ^2.0.9 (SVG support)
- **cached_network_image**: ^3.3.0 (Image caching)
- **shimmer**: ^3.0.0 (Loading effects)
- **flutter_local_notifications**: ^16.3.0 (Local notifications)

### **Design Patterns**
- **BLoC Pattern**: For state management
- **Clean Architecture**: Domain-Driven Design
- **Repository Pattern**: For data access abstraction
- **MVVM**: Separation of UI and business logic

### **Infrastructure**
- **Backend**: Mock Services / Local State Management
- **Database**: In-memory data structures
- **Authentication**: Simulated local authentication
- **Charts**: fl_chart for analytics visualization
- **Notifications**: Local notification simulation

## 🏗️ Architecture

### **Clean Architecture Implementation**
The project follows Domain-Driven Design principles with clear separation of concerns:

```
lib/
├── main.dart                    # App entry point
├── core/                       # Shared utilities and constants
│   └── utils/
│       ├── app_constants.dart  # App-wide constants
│       └── app_theme.dart      # Material Design theme
├── data/                       # Data layer (implementation)
│   ├── datasources/
│   │   └── mock_data_source.dart # Mock data provider
│   ├── models/                 # Data models (DTOs)
│   │   ├── user_model.dart
│   │   ├── vendor_model.dart
│   │   ├── menu_item_model.dart
│   │   ├── discount_model.dart
│   │   ├── order_model.dart
│   │   └── transaction_model.dart
│   └── repositories/           # Repository implementations
│       ├── mock_auth_repository.dart
│       ├── mock_user_repository.dart
│       ├── mock_vendor_repository.dart
│       ├── mock_menu_repository.dart
│       └── mock_order_repository.dart
├── domain/                     # Business logic layer
│   ├── entities/               # Business entities
│   │   ├── user_entity.dart
│   │   ├── vendor_entity.dart
│   │   ├── menu_item_entity.dart
│   │   └── order_entity.dart
│   ├── repositories/           # Repository interfaces
│   │   ├── auth_repository.dart
│   │   ├── user_repository.dart
│   │   ├── vendor_repository.dart
│   │   ├── menu_repository.dart
│   │   └── order_repository.dart
│   └── usecases/               # Business use cases (planned)
└── presentation/               # UI layer
    ├── auth/                   # Authentication feature
    │   ├── bloc/               # BLoC components
    │   │   ├── auth_bloc.dart
    │   │   ├── auth_event.dart
    │   │   └── auth_state.dart
    │   └── screens/
    │       └── login_screen.dart
    ├── student/                # Student dashboard
    │   └── screens/
    │       └── student_home_screen.dart
    ├── vendor/                 # Vendor dashboard
    │   └── screens/
    │       └── vendor_home_screen.dart
    ├── admin/                  # Admin dashboard
    │   └── screens/
    │       └── admin_home_screen.dart
    └── app_router.dart         # Navigation routing
```

### **Architecture Layers**

1. **Presentation Layer** (`presentation/`)
   - UI widgets and screens
   - BLoC state management
   - Navigation and routing

2. **Domain Layer** (`domain/`)
   - Business entities and logic
   - Repository interfaces
   - Use cases (business rules)

3. **Data Layer** (`data/`)
   - Repository implementations
   - Data models (DTOs)
   - Data sources (API, database, mock)

4. **Core Layer** (`core/`)
   - Shared utilities
   - App configuration
   - Constants and themes

## 🔧 Current Implementation Status

### **✅ Completed Components**

1. **Core Architecture**
   - ✅ Clean Architecture structure implemented
   - ✅ Domain entities defined
   - ✅ Repository interfaces and implementations
   - ✅ Mock data source with sample data

2. **Authentication System**
   - ✅ BLoC-based authentication flow
   - ✅ Role-based login (Student/Vendor/Admin)
   - ✅ Session management
   - ✅ Navigation based on user roles

3. **UI Framework**
   - ✅ Material Design 3 theme
   - ✅ Consistent styling and colors
   - ✅ App routing system
   - ✅ Basic dashboard screens for all roles

4. **Data Models**
   - ✅ Complete data models with JSON serialization
   - ✅ Mock data for testing
   - ✅ Repository pattern implementation

### **⚠️ Areas for Development**

1. **Feature Implementation**
   - ⚠️ Student ordering flow (incomplete)
   - ⚠️ Vendor order management (incomplete)
   - ⚠️ Admin analytics dashboard (incomplete)
   - ⚠️ Wallet management system (not implemented)
   - ⚠️ Menu management (not implemented)

2. **UI/UX Enhancements**
   - ⚠️ Detailed screens beyond basic dashboards
   - ⚠️ Form validations
   - ⚠️ Loading states and error handling
   - ⚠️ Responsive design optimization

3. **Data Persistence**
   - ⚠️ Currently using mock/in-memory data
   - ⚠️ No real database integration
   - ⚠️ No API/backend integration

4. **Testing**
   - ⚠️ Basic widget test template exists
   - ⚠️ No comprehensive test coverage
   - ⚠️ No integration tests

## 🐛 Recent Issue Fixed

**Problem**: The imported library `'package:campus_food_app/presentation/auth/bloc/auth_state.dart' can't have a part-of directive.`

**Root Cause**: Direct import of Dart part files, which is not allowed in the `part` directive system.

**Solution Applied**: Removed direct imports of `auth_event.dart` and `auth_state.dart` from `vendor_home_screen.dart`, keeping only the main `auth_bloc.dart` import. This follows Dart best practices for the `part` directive system.

## 📊 Code Quality Assessment

### **Strengths**
- ✅ Well-structured Clean Architecture
- ✅ Proper separation of concerns
- ✅ BLoC pattern implementation
- ✅ Consistent coding style
- ✅ Comprehensive data models
- ✅ Role-based access control

### **Areas for Improvement**
- ⚠️ Incomplete feature implementation
- ⚠️ Limited error handling
- ⚠️ No real data persistence
- ⚠️ Minimal test coverage
- ⚠️ Missing form validations
- ⚠️ Basic UI implementations

## 🚀 Installation & Setup

### **Prerequisites**
- Flutter SDK (>= 3.0.0)
- Dart SDK (>= 3.0.0)
- Android Studio / VS Code with Flutter extensions

### **Steps**

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd campus-food-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 👥 Demo Accounts

The app comes with pre-configured mock accounts for testing:

### **Student Account**
- **Email**: `student@campus.edu`
- **Password**: `any password` (any non-empty password works)
- **Role**: Student
- **Wallet Balance**: $50.00
- **Campus ID**: STU001

### **Vendor Account**
- **Email**: `vendor1@campus.edu`
- **Password**: `any password` (any non-empty password works)
- **Role**: Vendor
- **Wallet Balance**: $1000.00
- **Campus ID**: VEN001

### **Admin Account**
- **Email**: `admin@campus.edu`
- **Password**: `any password` (any non-empty password works)
- **Role**: Administrator
- **Wallet Balance**: $0.00
- **Campus ID**: ADM001

### **Additional Student Account**
- **Email**: `student2@campus.edu`
- **Password**: `any password` (any non-empty password works)
- **Role**: Student
- **Wallet Balance**: $75.50
- **Campus ID**: STU002

## 📋 Mock Data

The app includes comprehensive mock data for demonstration:

### **Vendors**
- **Pizza Palace**: Open, 4.5★ rating, 120 reviews
- **Burger Barn**: Open, 4.2★ rating, 85 reviews
- **Sushi Station**: Pending approval, new vendor
- **Taco Time**: Closed, 4.0★ rating, 45 reviews

### **Menu Items**
- Various food items across different categories
- Pricing and availability status
- Preparation time estimates

### **Orders & Transactions**
- Sample order history
- Transaction records for wallet operations

## 🎮 Key Features Demonstration

### **1. Authentication Flow**
- Role-based navigation after login
- Session management
- Logout functionality
- BLoC state management

### **2. Student Dashboard**
- Welcome section with user info
- Quick action cards for main features
- Wallet balance display
- Navigation to different sections

### **3. Vendor Dashboard**
- Order statistics
- Revenue tracking
- Management tools
- Vendor-specific controls

### **4. Admin Dashboard**
- System overview metrics
- Administrative controls
- Analytics access
- System management features

## 🔍 Development Notes

### **State Management**
- BLoC pattern used throughout the app
- Each feature has its own BLoC for state management
- Global authentication state managed by AuthBloc
- Proper event-driven architecture

### **Navigation**
- Named routing system
- Role-based navigation guards
- Centralized router configuration
- Proper route handling

### **UI/UX**
- Material Design 3 implementation
- Consistent theming and styling
- Responsive layout considerations
- Clean and modern interface

### **Data Management**
- Mock data source for development
- Repository pattern for data access
- Entity-domain separation
- JSON serialization support

## 🚀 Next Steps Recommendations

### **1. Complete Core Features**
- Implement student ordering flow
- Build vendor order management
- Create admin analytics dashboard
- Add wallet management system
- Implement menu management

### **2. Enhance Data Layer**
- Add real database integration (SQLite/Firestore)
- Implement API connectivity
- Add data synchronization
- Implement offline capabilities

### **3. Improve Testing**
- Write unit tests for BLoCs
- Add widget tests for screens
- Implement integration tests
- Add test coverage reporting

### **4. UI/UX Polish**
- Add loading states and skeletons
- Implement form validations
- Enhance responsive design
- Add animations and transitions
- Implement dark mode
- Add accessibility features

### **5. Advanced Features**
- Push notifications integration
- Real-time order updates with WebSockets
- Payment gateway integration
- GPS-based vendor discovery
- Multi-language support
- Advanced analytics

## 🤝 Contributing

We welcome contributions to the Campus Food Ordering App! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) file for detailed guidelines on:

- Development setup and workflow
- Coding standards and best practices
- Testing guidelines
- Pull request process
- Issue reporting and feature requests

### **Quick Development Guidelines**
- Follow Clean Architecture principles
- Use BLoC pattern for state management
- Maintain consistent coding style
- Write comprehensive tests
- Document new features

## 📄 License

This project is for demonstration purposes only.

## 📞 Support

For questions or issues related to this project, please refer to the code documentation and comments within the source files.
