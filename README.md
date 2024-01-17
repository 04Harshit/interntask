# Flutter Todo Application

This Flutter application provides a simple and intuitive interface for users to manage their tasks. It includes a Login Screen for authentication and a Todo Screen where users can view and interact with their tasks.

## Getting Started

To get started, clone this repository and ensure that you have Flutter installed on your system. You can check Flutter installation by running `flutter doctor` in your terminal.

### Prerequisites

- Flutter SDK
- Dart SDK
- An IDE (Android Studio/VS Code)

### Installation

1. Clone the repository to your local machine.
2. Open your terminal and navigate to the project directory.
3. Run `flutter pub get` to install all the dependencies.
4. To run the app, use `flutter run` within the project directory.

## Features

### Login Screen

- Authenticate users via the API endpoint `https://dummyjson.com/docs/auth`.
- Text fields for username and password input.
- Error handling for login failures.
- Navigation to the Todo Screen upon successful login.
- Storage of authentication token, user ID, and login state for persistent sessions.
- Visibility icon to toggle between obscuring and revealing the password text for improved user experience.

### Todo Screen

- Fetch and display tasks from `https://dummyjson.com/docs/todos` API endpoint.
- Task display organized into two sections: "Today" and "Tomorrow."
- "Hide Completed" button to toggle visibility of completed tasks in the "Today" section.
- "Show All" button to display all tasks in the "Today" section.
- Different styles to represent task completion status.
- Checkbox to update task completion status, triggering an update ToDo API call.
- Interactions like marking tasks as complete or incomplete.
- FAB (Floating Action Button) to add a new task.
- Loading indicators and error handling for API requests.
- Modal bottom sheet for adding tasks with:
    - Task name entry.
    - Cupertino time picker with default time as the current time.
    - Sliding switch to choose between "Today" and "Tomorrow".
    - "Done" button to trigger the addition of a new task via add ToDo API call and dismiss the add task screen.

# MyApp Documentation

## Architecture

For this small-scale task, the application is designed using the MVVM (Model-View-ViewModel) architecture. MVVM separates the concerns into three main components:

- **Model:** Represents the data and business logic of the application. Manages data retrieval, processing, and storage. Handles communication with the API.

- **View:** Represents the UI of the application. Observes the ViewModel and updates the UI accordingly. Includes the Login and Task screens.

- **ViewModel:** Acts as an intermediary between the Model and the View. Manages the presentation logic and state of the UI. Orchestrates data flow between the Model and the View. Handles user interactions and triggers the necessary actions.

- **Bloc:** For larger-scale applications, consider using Bloc architecture for enhanced scalability and state management.

## Design Decisions

- **API Limitations:**
  - **Tasks Display:** Tasks are included in both the "Today" and "Tomorrow" sections due to the API's lack of differentiation.
  - **Time and Day in Add Task:** The API doesn't provide fields for time and day, so these details are not included in the Add Task screen.

- **User Experience Enhancements:**
  - **Visibility Icon in Login Screen:** Added an eye icon to toggle between obscuring and revealing the password for improved user experience.
  - **Snackbar for Errors:** Implemented snackbar notifications to inform users about encountered errors.
  - **CircularProgressIndicator:** Used wherever data is being fetched from the API for user convenience.

- **Utilized Flutter Widgets:**
  - **CupertinoDateAndTimePicker:** Used for selecting and displaying date and time in a Cupertino-style interface.
  - **ShowModalBottomSheet:** Employed for a clean and modular design in the Add Task screen.
  - **Sliding Switch:** Utilized for toggling between "Today" and "Tomorrow" in the Add Task screen.
  - **Buttons:** Used for triggering actions such as login, updating tasks, and adding new tasks.

Despite the API limitations, design decisions focused on creating a user-friendly experience, handling errors gracefully, and making the UI intuitive using various Flutter widgets.


## Usage

Upon launching the app, you will be prompted to the Login Screen. Enter your credentials and you will be directed to the Todo Screen if the login is successful. On the Todo Screen, you can manage your tasks.

## Code Structure

The codebase is organized as follows:

- `lib/main.dart` - Entry point of the application.
- `lib/screens/` - Contains the UI screens (Login and Todo).
- `lib/networking/` - Handles API calls and other networking services.
- `lib/widgets/` - Custom reusable widgets for the UI.
- `lib/models/` - Data models to represent user and tasks.
- `lib/utils/` - Stores utility or helper functions shared across the application

## Best Practices

The project follows Flutter's best practices, including:

- Proper state management.
- Modular code structure.
- Reusable widgets.
- Asynchronous programming for API calls.

## Contributions

Contributions are welcome. Please read `CONTRIBUTING.md` for details on our code of conduct, and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the `LICENSE.md` file for details.

## Acknowledgments

- Flutter community for excellent documentation.
- [dummyjson](https://dummyjson.com/docs/auth) for providing the API endpoints for authentication and tasks.