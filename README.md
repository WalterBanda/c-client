<p align="center">
    <img align="center" src="docs/assets/logo.svg" height="128">
</p>
<h4 align="center">A Motorist best friend.</h4>
<p align="center">
    <img src="https://img.shields.io/badge/Built%20by%20Banda%20-black?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAMCAMAAACDd7esAAAANlBMVEUAAAD////////////////////////////////////////////////////////////////////xY8b8AAAAEXRSTlMAEB8gQGBwf4CPkJ+gv8/f7+Jt1bIAAABKSURBVAjXdY1BEoAgEICotEzbVv7/2Q51jTMMQInpXQE4VHUARWdvqTuEucGSTkg7QNWFP27b56yE820TiuY4UxvQ3tcFQA2NCjwYvwPjraJ69gAAAABJRU5ErkJggg=="
         alt="Built By">
     <a href="https://github.com/rocksdanister/lively/wiki"><img src="https://img.shields.io/badge/Wiki%20%F0%9F%93%9C%20-black?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAsAAAAMCAMAAACDd7esAAAANlBMVEUAAAD////////////////////////////////////////////////////////////////////xY8b8AAAAEXRSTlMAEB8gQGBwf4CPkJ+gv8/f7+Jt1bIAAABKSURBVAjXdY1BEoAgEICotEzbVv7/2Q51jTMMQInpXQE4VHUARWdvqTuEucGSTkg7QNWFP27b56yE820TiuY4UxvQ3tcFQA2NCjwYvwPjraJ69gAAAABJRU5ErkJggg=="
         alt="Project Wiki"></a>
     <img src="https://img.shields.io/badge/Version-2.11.0-blue?style=for-the-badge&logo=flutter&labelColor=black"
         alt="Flutter Version">
     <a href="https://github.com/rocksdanister/lively/stargazers"><img src="https://img.shields.io/github/license/WalterBanda/arch-systemd-wsl-script?style=for-the-badge&logo=github&logoColor=white&labelColor=black"
         alt="License"></a>
</p>

<p align="center">
  <a href="#About">About</a> •
  <a href="#initialization">Project Setup</a> •
  <a href="#features">Features</a> •
  <a href="#contributing">Contributing</a> •
  <a href="#license">License</a>
</p>

<p align="center"><img src="docs/assets/thumbnail.svg" alt="Thumbnail" style="zoom:25%;" /></p>

<h1 id="About">About ChapChap  🧰</h1>

`Chapchap` helps motorist find the nearest garage when their vehicle has broken down. Its a project built as one of my institution showcase projects.

<p id="initialization"></p>

## Project Setup 🧪

### Project Initialization

This Project is built using <img src="https://storage.googleapis.com/cms-storage-bucket/4fd0db61df0567c0f352.png" height="12" alt="Flutter logo" /> Flutter, you can setup flutter using [this docs](https://docs.flutter.dev/get-started/install).

To setup the project, have to clone this repository to your local drive.

```python
git clone <REPO>
```

Then you have to initialize flutter in the project by running the following command and congrats 🎉 you have the project setup.

```shell
flutter pub get
```

### Running & Testing 🧪

To run the application and test it in the android environment. Launch your terminal and run the following commands.

```shell
flutter run
```

To run it on the `Web : Chrome` platform, launch your terminal and run.

```shell
flutter run -d chrome
```

## Features

The application contains the following features.

- [ ] `Auth :` user Authentication
- [ ] `Profile:` User Profiles & settings
- [ ] `Admin Home:` User Administrator dash and home
- [ ] `User Home:` Client User home and way finder

### Auth 🔐

This page deals with user authentication and user verification. The features in this include ;

1. User Authentication using email & password
2. Google and facebook user authentication
3. User registration and verification

Below are screenshot pages

| Auth Page                                                                   | Login Page                                                                   |
| --------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| <img src="docs/assets/screenshots/auth.svg" alt="Thumbnail" style="zoom:50%;" /> | <img src="docs/assets/screenshots/login.svg" alt="Thumbnail" style="zoom:50%;" /> |

### User Home

First Page the user sees, its where the user can look for nearby service centers. One can manually search for a garage or use the map select the garage of choice.

1. Map view for showing the nearby service centers
2. Search overlay for finding nearby service centers

Below are the shots

| User Home Page                                                                   | User Home Overlay Page                                                                   |
| -------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| <img src="docs/assets/screenshots/user_home.svg" alt="Thumbnail" style="zoom:50%;" /> | <img src="docs/assets/screenshots/user_home_overlay.svg" alt="Thumbnail" style="zoom:50%;" /> |

### Admin Home

The first page an admin meets when one logins into the app. It helps one administer the app and control it.

The features that can be controlled in this app are;

1. Add or remove a service center from the app
2. Enable or disable automatic google service centers

| Admin Home Page                                                                   | Admin Home Overlay Page                                                                   |
| --------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| <img src="docs/assets/screenshots/admin_home.svg" alt="Thumbnail" style="zoom:50%;" /> | <img src="docs/assets/screenshots/admin_home_overlay.svg" alt="Thumbnail" style="zoom:50%;" /> |

### Profile

This screen shows the profile of the user. Its also provides options for users such as admin

| Profile                                                                           |
| --------------------------------------------------------------------------------- |
| <img src="docs/assets/screenshots/admin_home.svg" alt="Thumbnail" style="zoom:50%;" /> |
