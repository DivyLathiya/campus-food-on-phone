# Contributing to Campus Food Ordering App

Thank you for your interest in contributing to the Campus Food Ordering App! This document provides guidelines and instructions for contributing to this project.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Project Structure](#project-structure)
- [Coding Standards](#coding-standards)
- [Git Workflow](#git-workflow)
- [Pull Request Process](#pull-request-process)
- [Testing Guidelines](#testing-guidelines)
- [Documentation Standards](#documentation-standards)
- [Issue Reporting](#issue-reporting)
- [Feature Requests](#feature-requests)

## 🤝 Code of Conduct

Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md) to ensure a welcoming and inclusive environment for all contributors.

## 🚀 Getting Started

### Prerequisites

Before contributing, ensure you have the following installed:

- **Flutter SDK**: >= 3.0.0
- **Dart SDK**: >= 3.0.0 < 4.0.0
- **Git**: Latest version
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA with Flutter and Dart plugins

### Development Environment Setup

1. **Fork the Repository**
   ```bash
   # Fork the repository on GitHub/GitLab
   git clone <your-fork-url>
   cd campus-food-app
   ```

2. **Set Up Remote**
   ```bash
   git remote add upstream <original-repository-url>
   ```

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the App**
   ```bash
   flutter run -d chrome --web-renderer canvaskit
   # or for mobile
   flutter run
   ```

## 🏗️ Development Setup

### Branch Strategy

We use the following branch naming conventions:

- **`main`**: Production-ready code
- **`develop`**: Integration branch for features
- **`feature/*`**: New features (e.g., `feature/wallet-management`)
- **`bugfix/*`**: Bug fixes (e.g., `bugfix/login-validation`)
- **`hotfix/*`**: Critical fixes for production

### Development Workflow

1. **Create a New Branch**
   ```bash
   git checkout develop
   git pull upstream develop
   git checkout -b feature/your-feature-name
   ```

2. **Make Your Changes**
   - Follow the coding standards outlined below
   - Write tests for new functionality
   - Update documentation as needed

3. **Test Your Changes**
   ```bash
   flutter test
   flutter analyze
   flutter run
   ```

## 📁 Project Structure

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
│   └── repositories/           # Repository implementations
├── domain/                     # Business logic layer
│   ├── entities/               # Business entities
│   ├── repositories/           # Repository interfaces
│   └── usecases/               # Business use cases
└── presentation/               # UI layer
    ├── auth/                   # Authentication feature
    ├── student/                # Student dashboard
    ├── vendor/                 # Vendor dashboard
    ├── admin/                  # Admin dashboard
    └── app_router.dart         # Navigation routing
```

### Architecture Guidelines

This project follows **Clean Architecture** principles:

1. **Dependency Rule**: Dependencies point inward
2. **Layer Separation**: Clear separation between presentation, domain, and data layers
3. **Repository Pattern**: Abstract data access behind interfaces
4. **BLoC Pattern**: Use BLoC for all state management

## 📝 Coding Standards

### Dart/Flutter Style Guide

We follow the [Official Dart Style Guide](https://dart.dev/guides/language/effective-dart/style) and [Flutter Style Guide](https://flutter.dev/docs/development/tools/formatting).

#### Key Rules:

1. **File Naming**
   - Use `snake_case` for files: `auth_bloc.dart`, `user_repository.dart`
   - Use `camelCase` for classes: `AuthBloc`, `UserRepository`

2. **Import Organization**
   ```dart
   // Dart imports
   import 'dart:async';
   
   // Package imports
   import 'package:flutter/material.dart';
   import 'package:bloc/bloc.dart';
   
   // Project imports
   import 'package:campus_food_app/domain/entities/user_entity.dart';
   ```

3. **Class Structure**
   ```dart
   class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
     final ExampleRepository repository;
   
     ExampleBloc({required this.repository}) : super(ExampleInitial());
   
     @override
     Stream<ExampleState> mapEventToState(ExampleEvent event) async* {
       // Implementation
     }
   }
   ```

4. **Documentation**
   - Use `///` for public API documentation
   - Include parameter and return type documentation
   - Add examples for complex functionality

   ```dart
   /// Authenticates a user with the provided credentials.
   /// 
   /// Returns [UserEntity] if authentication is successful, otherwise null.
   /// 
   /// Throws [AuthenticationException] if authentication fails.
   Future<UserEntity?> authenticate({
     required String email,
     required String password,
   }) async {
     // Implementation
   }
   ```

### BLoC Pattern Guidelines

1. **Event Naming**: Use verb phrases in past tense: `LoadWalletBalance`, `AddFundsToWallet`
2. **State Naming**: Use nouns or adjectives: `WalletLoading`, `WalletBalanceLoaded`
3. **BLoC Organization**: Keep BLoCs focused on single features

### Clean Architecture Rules

1. **Domain Layer**: No Flutter imports, pure Dart only
2. **Data Layer**: Can import domain layer, but not presentation
3. **Presentation Layer**: Can import domain and data layers
4. **No Circular Dependencies**: Use dependency injection

## 🔄 Git Workflow

### Commit Messages

Use the [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

#### Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or modifying tests
- `chore`: Maintenance tasks

#### Examples:
```bash
feat(auth): add password reset functionality
fix(wallet): prevent negative balance after withdrawal
docs(readme): update installation instructions
style(bloc): format code according to dart style guide
refactor(repository): simplify data access layer
test(auth): add unit tests for login validation
chore(deps): update flutter dependencies
```

### Branch Management

1. **Keep branches focused**: One feature/bugfix per branch
2. **Regular syncs**: Keep your branch updated with `develop`
   ```bash
   git checkout develop
   git pull upstream develop
   git checkout feature/your-feature
   git merge develop
   ```
3. **Clean history**: Use rebase for cleaner history
   ```bash
   git rebase -i develop
   ```

## 📤 Pull Request Process

### PR Checklist

Before submitting a PR, ensure:

- [ ] Code follows project coding standards
- [ ] All tests pass (`flutter test`)
- [ ] Code analysis passes (`flutter analyze`)
- [ ] App builds and runs without errors
- [ ] New features include appropriate tests
- [ ] Documentation is updated
- [ ] Commit messages follow conventional format
- [ ] PR description clearly explains changes

### PR Template

```markdown
## 📋 Description
[Brief description of changes]

## 🔄 Changes Made
- [ ] Feature: [Description]
- [ ] Bugfix: [Description]
- [ ] Refactor: [Description]
- [ ] Documentation: [Description]

## 🧪 Testing
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing performed

## 📸 Screenshots (if applicable)
[Add screenshots for UI changes]

## 🔗 Related Issues
Closes #123
Related to #456

## 📝 Checklist
- [ ] Code follows project standards
- [ ] All tests pass
- [ ] Documentation updated
- [ ] Breaking changes documented
```

### Review Process

1. **Automated Checks**: CI/CD pipeline runs tests and analysis
2. **Code Review**: At least one maintainer must review
3. **Approval**: Maintainer approval required for merge
4. **Merge**: PRs are merged to `develop`, then to `main`

## 🧪 Testing Guidelines

### Test Structure

```
test/
├── unit/                      # Unit tests
│   ├── bloc/
│   ├── repository/
│   └── usecase/
├── widget/                    # Widget tests
│   ├── screens/
│   └── components/
└── integration/               # Integration tests
    └── flows/
```

### Testing Standards

1. **Unit Tests**: Test business logic in isolation
   ```dart
   test('should emit WalletLoading and WalletBalanceLoaded', () async {
     // Arrange
     when(mockRepository.getUserById('test-id'))
         .thenAnswer((_) async => mockUser);
     
     // Act
     bloc.add(LoadWalletBalance(userId: 'test-id'));
     
     // Assert
     expectLater(
       bloc.stream,
       emitsInOrder([
         WalletLoading(),
         WalletBalanceLoaded(userId: 'test-id', balance: 50.0),
       ]),
     );
   });
   ```

2. **Widget Tests**: Test UI components
   ```dart
   testWidgets('should display wallet balance', (WidgetTester tester) async {
     await tester.pumpWidget(
       MaterialApp(
         home: WalletScreen(balance: 50.0),
       ),
     );
     
     expect(find.text('\$50.00'), findsOneWidget);
   });
   ```

3. **Test Coverage**: Aim for 80%+ coverage

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/bloc/wallet_bloc_test.dart

# Run tests with verbose output
flutter test --verbose
```

## 📚 Documentation Standards

### Code Documentation

1. **Public APIs**: All public classes, methods, and properties must be documented
2. **Complex Logic**: Add inline comments for complex algorithms
3. **TODOs**: Use `TODO(username): description` format

### README Updates

Update README.md when:
- New major features are added
- Installation process changes
- Dependencies are significantly updated
- Architecture patterns change

### API Documentation

For new features, include:
- Purpose and functionality
- Parameters and return types
- Usage examples
- Error handling

## 🐛 Issue Reporting

### Bug Report Template

```markdown
## 🐛 Bug Description
[Clear and concise description of the bug]

## 🔄 Steps to Reproduce
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

## 📱 Expected Behavior
[What you expected to happen]

## 📱 Actual Behavior
[What actually happened]

## 📸 Screenshots
[If applicable, add screenshots]

## 📱 Device Information
- Device: [e.g., iPhone 12, Pixel 6]
- OS: [e.g., iOS 15.4, Android 12]
- Flutter Version: [e.g., 3.0.0]
- App Version: [e.g., 1.0.0]

## 📝 Additional Context
[Add any other context about the problem]
```

### Good Bug Reports

- **Reproducible**: Provide clear steps to reproduce
- **Specific**: Include exact error messages
- **Environment**: Specify device, OS, and app versions
- **Expected vs Actual**: Clearly state what should happen vs what happens

## ✨ Feature Requests

### Feature Request Template

```markdown
## 🎯 Feature Description
[Clear and concise description of the feature]

## 🤔 Problem Statement
[What problem does this feature solve?]

## 💡 Proposed Solution
[Describe the solution you'd like]

## 🎨 Design Ideas
[Mockups, wireframes, or design concepts]

## 🔄 User Stories
[As a [user type], I want [feature] so that [benefit]]

## 📝 Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## 🔄 Alternatives Considered
[What other approaches did you consider?]

## 📝 Additional Context
[Add any other context or screenshots]
```

### Good Feature Requests

- **User-focused**: Explain the user benefit
- **Specific**: Provide clear requirements
- **Well-researched**: Consider alternatives
- **Priority**: Explain why this feature is important

## 🏆 Recognition

Contributors will be recognized in:
- **Contributors section** in README.md
- **Release notes** for their contributions
- **GitHub contributor statistics**

## 📞 Support

For questions about contributing:
- Check existing issues and discussions
- Review the codebase and documentation
- Create an issue with the `question` label

---

Thank you for contributing to the Campus Food Ordering App! 🎉
