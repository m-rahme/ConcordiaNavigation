<a href="https://github.com/MichelRahme/ConcordiaNavigation">
    <p align="center">
        <img width="180" height="180" src="https://i.ibb.co/YPjtY6T/Logo-2x.png" width="40%">
    </p>
</a>

# ConcordiaNavigation [![Build Status](https://travis-ci.org/MichelRahme/ConcordiaNavigation.svg?branch=master)](https://travis-ci.org/MichelRahme/ConcordiaNavigation)

Repository for a mobile app helping users navigate the university of Concordia. The software is built for Concordia's MiniCap Project - SOEN 390.   
   
*See the [wiki](https://github.com/MichelRahme/ConcordiaNavigation/wiki) page for more details regarding the project.*

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* [Flutter](https://flutter.dev/docs/get-started/install/windows)
* A supporting IDE, preferably [Android Studio](https://developer.android.com/studio)

### Installing

Clone the repository on your local machine through the terminal

```
git clone https://github.com/MichelRahme/ConcordiaNavigation.git
```

## Testing

Unit test (Automatic)
* [test](https://pub.dev/packages/test) | Dart Package - Dart Pub
* [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) library - Dart API
* [mockito](https://pub.dev/packages/mockito) | Dart Package - Dart Pub

System and Integration test	(Automatic and Manual)
* [flutter_driver](https://api.flutter.dev/flutter/flutter_driver/flutter_driver-library.html) library - Dart API  

The automated system integration code structure is divided into two directories. The first is “test” which contains both unit and widget tests. Each test file is named using the original file to be tested with the suffix “_test”. The second directory is “test_driver” which contains all files related to system integration testing. This includes all the system integration test cases (app_test.dart) and all the entry-points of the application (app.dart) which will be used by flutter_driver to allow us to drive the application for testing purposes, for example, using the driver to tap a button or scroll a page.

## Built With

* [Provider](https://pub.dev/packages/provider) - State Management package
* [Google Maps](https://pub.dev/packages/google_maps_flutter) - Flutter plugin that provides a Google Maps widget
* [Google API](https://pub.dev/packages/googleapis#-readme-tab-) - Auto-generated Dart libraries for accessing Google APIs, specifically Google Calendar
* [Travis CI](https://travis-ci.org/) - Used to run tests every time a commit is made to GitHub

## Authors

* **Andre Parsons-Legault**
* **Julia Bazarbachian**
* **Wayne Tam**
* **Kajanthy Subramaniam**
* **Richard Bui**
* **Michel Rahme**
* **Andrew Hanichkovsky**
* **Alex Hayeux**
* **Evan Mateo**

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/MichelRahme/ConcordiaNavigation/blob/master/LICENSE) file for details

## Acknowledgments

* Special thanks to Dr. Nikolaos Tsantalis who gave us the golden opportunity to do this wonderful project as part of an educational experience
* Product owner Mr. Mosabbir Khan Shiblu who gives helpful feedbacks throughout the building of the project
