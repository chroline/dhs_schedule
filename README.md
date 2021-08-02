<div align="center">

# DHS Schedule App

<img src="assets/DHS_Warrior_Logo.png" width="128px" />

Source code for the new DHS Schedule App for the 2020-21 school year.

</div>

---

# About the app

This app is built using [Flutter](https://flutter.dev). Flutter uses the Dart programming language and mostly adheres to
the Material Design guidelines.

## Schedule configuration

The schedule is stored in [assets/schedule.yaml](assets/schedule.yaml), along with exceptional schedules that don't
follow the typical Monday-Friday schedule. If a day doesn't match said schedule, it is marked under `exceptions`.

## Notifications

For notifications, the package [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) is
used to schedule and cancel notifications. In order to manage the scheduling of the schedule that tends to vary from
week-to-week, the user is required to re-enable notifications every week. It's a small drawback to having an effective
notification system.

# TODO

- Add more information to this README describing the code
- Add more comments in code explaining what does what

# Contributors

Currently, the app is being maintained by [Cole Gawin](https://github.com/chroline) (DHS '23). If you see opportunity
for improvement, feel free to open an issue or a pull request.