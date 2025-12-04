#  Flutter Interview Test Task 

## 1. Dependencies Used

*   **dio**: Used for API's calling .
*   **dartz**: Used for API's calling .
*   **go_router**: Used for API's calling .
*   **equatable**: Used for API's calling .
*   **flutter_screenutil**: To make the UI responsive across different screen sizes.
*   **flutter_bloc** & **bloc**: For state management using the BLoC pattern, separating business logic 


## 2. Project Structure

The project follows a feature-first architecture, with a core directory for shared components.

```
lib/
 ├── core/
 │   ├── constants/   # Contains application-wide constants like colors and image paths.
 │   ├── theme/       # Defines the application's theme.
 │   ├── utils/       # Holds utility functions, like date helpers.
 │   └── widgets/     # Contains reusable custom widgets used across multiple features.
 ├── features/      # Contains the different features of the application, separated by domain.
 │   ├── dashboard/
 │   ├── home/
 │   └── quiz/
 └── main.dart      # The entry point of the application.
```

## 3. App Screenshots

<p align="center">
  <img src="srcreenshots/1.png" alt="Template Screen" width="200" style="margin: 10px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);"/>
  <img src="ssrcreenshots/2.png" alt="Create Invoice 1" width="200" style="margin: 10px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);"/>
  <img src="srcreenshots/3.png" alt="Create Invoice 2" width="200" style="margin: 10px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);"/>
  <img src="srcreenshots/4.png" alt="Create Invoice 3" width="200" style="margin: 10px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);"/>
   <img src="srcreenshots/5.png" alt="Create Invoice 3" width="200" style="margin: 10px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);"/>
</p>

## 4. App Video

[Watch Video](https://drive.google.com/file/d/1gThczp9fM627nGOIFX-EIO4J84utj0ni/view?usp=sharing)



## 5. App APK

[Download APK](https://drive.google.com/file/d/1krZD-MG36VpFMV0_PoK8smnbVm71JdLr/view?usp=sharing)

