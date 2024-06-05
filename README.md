# iOS Dev Test Project

This project is a demonstration of my skills in iOS development, including UI design, API integration, and SDK usage. Below is a summary of the tasks and implementation details.

## Table of Contents
- [Project Overview](#project-overview)
- [Features](#features)
  - [UI Design](#ui-design)
  - [Data List](#data-list)
  - [Wallpaper Viewer](#wallpaper-viewer)
  - [Amplitude SDK Integration](#amplitude-sdk-integration)
- [Installation](#installation)
- [Usage](#usage)
- [Technologies](#technologies)
- [License](#license)

## Project Overview
This project consists of several tasks aimed at assessing my iOS development skills, including creating a pixel-perfect UI, integrating with an API, and using the iOS SDK for advanced functionality. The project is implemented using either UIKit or SwiftUI based on the requirements.

## Features

### UI Design
- **Pixel-Perfect Screens**: Created two pixel-perfect paywall screens that alternate on each app launch.
- **Adaptive Layout**: The screens are designed to be adaptive to different screen sizes.
- **Interactive Buttons**: Buttons are interactive and include a close button that dismisses the screen.

### Data List
- **Dynamic Data Loading**: Implemented a list that loads data from the server at `https://wall.appthe.club`.
- **JSON Parsing**: The list is populated by parsing the JSON data from the server.
- **Automatic Updates**: The list updates dynamically every time the screen is opened.

### Wallpaper Viewer
- **Image Viewing**: When an item in the list is selected, an image viewer screen is displayed.
- **Live Photo Preview**: Added a preview button to play Live Photos using native iOS functionality.
- **Image Saving**: Added a save button to store images in the device’s memory.
- **Live Photo Creation**: Implemented functionality to merge images and videos to create Live Photos.

### Amplitude SDK Integration
- **SDK Integration**: Integrated the Amplitude SDK to log specific events.
  - `wallpaper_screen_view`: Logged when the wallpaper screen is viewed.
  - `wallpaper_screen_action`: Logged when a Live Photo is played.
  - `wallpaper_download`: Logged when an image is saved to the device.
- **Project Configuration**: Configured the Amplitude project with a placeholder or newly created Project ID.

## Installation
To run this project locally, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/ios-dev-test-project.git
    ```
2. Navigate to the project directory:
    ```bash
    cd ios-dev-test-project
    ```
3. Install dependencies:
    ```bash
    pod install
    ```
4. Open the project in Xcode:
    ```bash
    open ios-dev-test-project.xcworkspace
    ```

## Usage
1. Build and run the project in Xcode.
2. On launch, observe the alternating paywall screens.
3. Navigate to the data list and see it populate dynamically from the server.
4. Select an item to view the wallpaper screen, where you can preview and save the image.
5. Check the Amplitude dashboard for logged events.

## Technologies
- **Swift**: The primary programming language used.
- **UIKit/SwiftUI**: For user interface design.
- **URLSession**: For network requests.
- **JSONSerialization**: For parsing JSON data.
- **Amplitude SDK**: For logging analytics events.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to contribute, open issues, or suggest improvements to enhance this project further!
