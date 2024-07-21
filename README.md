# Notes App
## Overview
This is a Flutter-based Notes App that allows users to manage their notes with features including login, viewing notes, and editing notes. The app uses Riverpod for state management and Supabase as the backend service for authentication and data storage.

## Features
- Login Page: Users can log in using their credentials.
- Home Page: Displays a list of notes. Users can view existing notes and navigate to the edit page.
- Edit Page: Users can create or edit notes. Changes are saved to Supabase.
## Tech Stack
- Flutter: Framework for building the app.
- Riverpod: State management solution used to manage app state and dependencies.
- Supabase: Backend-as-a-Service (BaaS) used for authentication and database management.
## Installation
1- Clone the Repository

git clone https://github.com/yourusername/notes_app.git
cd notes_app
2- Install Dependencies

Make sure you have Flutter installed. Run the following command to get all dependencies:

flutter pub get
3- Setup Supabase

- Create a Supabase account at supabase.io.

- Create a new project and obtain your API URL and Key.

- Update lib/constants.dart with your Supabase credentials:

const String supabaseUrl = 'https://crrlokxjonnbomvswsbg.supabase.co';

const String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNycmxva3hqb25uYm9tdnN3c2JnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjEzMzM3MjgsImV4cCI6MjAzNjkwOTcyOH0.9QC5UJtka2pha0eo-0ab11OK1FF931YYUo81UaM9hjk';

## Configuration
1- Supabase Setup

- Configure your Supabase database schema to include tables for notes and users.
- Ensure that the necessary permissions are set up for reading, inserting, updating, and deleting notes.
2- Update API URL and Key

Ensure the Supabase client is correctly configured in your Flutter app by providing the correct URL and Key.

## Usage
1- Run the App

To start the app, use the following command:

flutter run
2- Login Page

Users can log in by entering their credentials. After successful login, they are redirected to the Home Page.

3- Home Page

- Displays a list of notes retrieved from Supabase.
- Users can tap on a note to edit it or add a new note.
4- Edit Page

- Allows users to create a new note or edit an existing one.
- Changes are saved to Supabase.
## State Management
- Riverpod: Used for managing state and dependencies. It provides a way to manage and expose application state across the app. Providers are used to interact with Supabase and handle app logic.
## Testing
To run the tests for this app, ensure you have the necessary development dependencies installed and use the following command:

flutter test

## Contributing
Contributions are welcome! Please submit a pull request or open an issue if you encounter any problems or have suggestions for improvements.

Contact
For any inquiries, please contact your tareqsarheed@gmail.com.
