```markdown
# Github Repositories

### A Flutter machine test based on the GitHub API

#### Description

Github Repositories is a machine test for [company_name] where we fetch repositories using the GitHub API every 12 hours. On the initial API call, we store the data offline. If the user returns within 12 hours, we display the data from the local database.

### Technologies Stack

- [Flutter SDK](https://docs.flutter.dev/get-started/install?gad_source=1&gclid=Cj0KCQjwzby1BhCQARIsAJ_0t5O-p_pe4yjjTZLdxJn7NMXlYPwPdxQR0NcrATYA6LvvmFc-WfYcQ0YaAmqwEALw_wcB&gclsrc=aw.ds)
- [Dart](https://dart.dev/)
- [Provider](https://pub.dev/packages/provider): Used for dependency injection.
- [Dio](https://pub.dev/packages/dio): Used for making REST API calls.
- [Equatable](https://pub.dev/packages/equatable): Used to compare objects.
- [Bloc](https://pub.dev/packages/flutter_bloc): Used for state management.
- [Cached Network Image](https://pub.dev/packages/cached_network_image): Used to display images from URLs and cache them.
- [Path](https://pub.dev/packages/path): Used to manipulate file paths, especially for the database file.
- [Path Provider](https://pub.dev/packages/path_provider): Used to provide common locations on the file system. In the app, it is used to locate the database file.
- [Drift](https://pub.dev/packages/drift): An ORM used to persist data locally.
- [Sqlite3 Flutter Libs](https://pub.dev/packages/sqlite3_flutter_libs): Used with Drift to write efficient database queries.
- [Drift Dev](https://pub.dev/packages/drift_dev): Generates mock classes for Drift tables.
- [Mockito](https://pub.dev/packages/mockito): Used to mock data.
- [Http Mock Adapter](https://pub.dev/packages/http_mock_adapter): Used to mock Dio.
- [Build Runner](https://pub.dev/packages/build_runner): Used to generate Dart code.

### Architecture

- I am using a hybrid architecture which is inspired from coordinator, mvvm & clean architecture pattern.
  - **View/Widget**: Represent a flutter widget.
  - **Coordinator**: Coordinator is responsible for building a dependency/screen & and act a Router.
  - **View Model**: The View Model contains all view/business logic and is responsible for manipulating the state.
  - **Use Case**: It encapsulate the business logic and act media to fetch the data from data sources.
  - **Bloc**: Responsible to hold and manipulate the widget states.
  - **Data Source[Remote & Local]**: Represent a datasource from where we are fetching the data.

### Subversion
- There is no specific sub-versioning used inside this project. However, I prefer to use Git/GitLab/Bitbucket/GitHub.
- For branching strategy, I prefer to use [GitLab Flow](https://about.gitlab.com/topics/version-control/what-is-gitlab-flow/).

### Testing
- Performed manual testing.
- Wrote unit test cases.
### Notes : Due to limited time constraint written limited test cases.

### Logging
- No third-party library is used for logging.
- Used API interceptor to log API details.

### Screens
There is only one screen and a modal. Please check the video of the app for reference.
- **Repositories Screen**: Displays all repositories fetched from the API/database. There are two lists inside the repositories screen:
  - **Infinite Scroll List**: A horizontal scroll list that contains the first 5 repositories and allows infinite scrolling in both directions.
  - **Repositories List**: Contains the remaining repositories.
- **Repositories Detail Modal**: A bottom sheet that contains the details of a repository. Once the user clicks any item in the lists, this bottom sheet is displayed. On clicking the Close button, we send data back to the native screen and exit the app.
```