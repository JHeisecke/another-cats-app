# AnotherCatApp 🐱

Welcome to **AnotherCatApp**, a SwiftUI-based iOS app showcasing a vertical feed of cat images with interactive like and dislike buttons.

## 🚀 Getting Started

Follow these steps to set up the project:

### Prerequisites
Xcode 15.4+

### 1. Setup Secrets

Copy the provided `Secrets.xcconfig` file into the `Core` directory, or create your own:

```plaintext
CAT_API_KEY = [PASTE_API_KEY_HERE]
```

Replace `[PASTE_API_KEY_HERE]` with your Cat API key from [TheCatAPI](https://thecatapi.com/).

### 2. Install SwiftLint

This project uses **SwiftLint** to maintain code quality. Make sure it’s installed on your Mac:

```bash
brew install swiftlint
```

For more information refer to the [SwiftLint Github page](https://github.com/realm/SwiftLint).

### 3. Install Dependencies

This project uses **Swift Package Manager (SPM)**. Open the project in Xcode and it will automatically resolve dependencies. Alternatively, run the following command:

```bash
xcodebuild -resolvePackageDependencies
```

## 🛠 Project Structure
**MVVM with Clean Architecture** (without UseCase to not add unnecessary complexity)
- **Core**: Core functionalities and configurations.
- **Data**: Contains the networking, responses and mapping login to Domain models.
- **Domain**: Contains the Repositories Protocols and Models used in the app.
- **Presentation**: Contains the Views, ViewModels and UIComponents.

## 📱 Features

- **Vertical Feed**: Infinite scrolling list of cats with smooth paging.
- **Detail View**: Detailed information about each cat, including breed info and description.

## 🧪 Running Tests

Run the test suite using Xcode:

- **Menu**: Product > Test
- **Shortcut**: `Cmd + U`

## 🐞 Troubleshooting

- **SwiftLint Issues**: Make sure SwiftLint is installed and properly configured.
- **SPM Dependencies Not Resolving**: Clean the build folder (`Cmd + Shift + K`) and resolve packages again.

## 🔗 Resources

- [The Cat API](https://thecatapi.com/)
- [SwiftLint Guide](https://github.com/realm/SwiftLint)

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## 🙌 Acknowledgements

Thanks to [The Cat API](https://thecatapi.com/) for providing the cat data and images.

