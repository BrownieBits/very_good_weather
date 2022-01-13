# Very Good Weather

A Very Good Weather App.

---

## Getting Started 🚀

To run the application, have an emulator or physical device connected and open:

```sh
$ dart pub get
$ flutter run
```

_\*Works on iOS, Android, and Web._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```