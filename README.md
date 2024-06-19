# TaskTrekker: Elevate Your Productivity  
A task management app blending kanban boards, time tracking, and collaboration tools. 
Visualize tasks, track progress, and collaborate effectively. Dive into TaskTrekker for a 
streamlined workflow!

## Features
- **Kanban Boards**: Organize tasks into boards.
- **Time Tracking**: Track time spent on tasks.

## Configuration:
- Flutter: 3.22.0
- Injectable & GetIt
- Bloc
- Hive
- Go Router
- Clean Architecture:
   - features
      - data
          - data_sources
          - models
          - repositories
      - domain
          - entities
          - repositories
          - use_cases
      - presentation
          - manager (cubits to manage business logics)
          - pages
          - widgets

## How to Run:
- Clone the repository from Github
- Check if your flutter version is **3.22.0**. If not either upgrade your flutter version using `flutter pub upgrade` or use `fvm` tool to manage multiple version
- If you are using fvm, run `fvm install 3.22.0` and wait for it to finish downloading. If you already have it installed just run the `fvm use 3.22.0`.
- Run `fvm flutter pub get`
- Everything should be good to go. But if for some reason you are facing issues, try running `fvm flutter clean` and then `fvm flutter pub get` again.
- Since we are using injectable, you need to run `fvm flutter packages pub run build_runner watch` to generate the code.
- Run tests using `fvm flutter packages pub run build_runner watch` and then `fvm flutter test`


