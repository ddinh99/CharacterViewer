# simpsonsviewer

Flutter - Anywhere Mobile Engineer Candidate Code Excercise.
The app descriptions and requirements are below.  

The idea of this file is to give instructions on how to build the applications
in different flavors.

Here is the link of videos of how to build each variations.
https://www.youtube.com/playlist?list=PLL_aVFw3EOREuSEZsVxMpwI8h6r6KjTfg

1. To build Android Phone and Tablet version of Simpsons Character Viewer
a. Open the project
b. In the terminal command type : "flutter run --flavor app1"
c. Here is the video of what to expect if you do correctly: https://www.youtube.com/watch?v=CWf-1kl2peE&list=PLL_aVFw3EOREuSEZsVxMpwI8h6r6KjTfg&index=1

2. To build Android Phone and Tablet version of The Wire Character Viewer
a. Open the project
b. In the terminal command type : "flutter run --flavor app2"
c. Here is the video of what to expect if you do correctly:
https://www.youtube.com/watch?v=13QaSIzSUkI&list=PLL_aVFw3EOREuSEZsVxMpwI8h6r6KjTfg&index=3

3. To build iPhone and iPad version of Simpsons Character Viewer
a. Open the project file 'Runner.xcworkspace' in ios folder of the 'simpsonsviewer' folder by XCode.
b. Open the project file using Mac Android Studio.
c. Build a version to run on emulator or real device so that it loads the necessary libraries in the podfiles.
d. Switch to XCode and click on the run button.
e. If you do correctly then you would expect like this in the video: 
https://www.youtube.com/watch?v=rBjJf9h9Myc&list=PLL_aVFw3EOREuSEZsVxMpwI8h6r6KjTfg&index=7

4. To build iPhone and iPad version of The Wire Character Viewer
a. Open the project file 'Runner.xcworkspace' in ios folder of the 'simpsonsviewer' folder by XCode.
b. Open the project file using Mac Android Studio.
c. Build a version to run on emulator or real device so that it loads the necessary libraries in the podfiles.
d. Switch to XCode and make sure to select'Runner The Wire' Scheme before clicking the run Arrow button.
e. If you do correctly then you would expect like this in the video: 
https://www.youtube.com/watch?v=kcKvZ90kUFI&list=PLL_aVFw3EOREuSEZsVxMpwI8h6r6KjTfg&index=6



App Description
Your app should be written entirely using Flutter framework and support both iOS and Android platforms. Try to demonstrate your knowledge of both basic and advanced language semantics.
Write a sample app that fetches and displays data from a RESTful Web API. The app should be comprised of two parts, a list and a detail.
App Requirements
1. Your app should support both portrait and landscape orientations on both phones and tablets.
2. On phones, the list and detail should be separate screens, on tablets, the list and detail should both appear on the same screen.
3. On all devices, the list view should be displayed as a text only, vertically scrollable list of character names.
4. The app should offer search functionality that allows users to filters the character list to entries whose titles or descriptions contain the query text
5. Clicking on an item should load the detail view of that character, including the character’s image, title, and description. You choose the layout of the detail.
6. For the image in the detail view, use the URL path in the "Icon" field of the API JSON response. For items with blank or missing image URLs, use a placeholder image of your choice. The path must be appended to https://duckduckgo.com/ in order to be resolved.
7. Two variants of the app should be created, using a single shared codebase. Each variant should have a different name, package-name, and url that it pulls data from. (We're interested in your methodology for creating multiple apps from a shared codebase)
8. Include unit tests for functionality that you deem critical and high-priority.
9. Upload your code to a Github repository, and provide the link
Variant One
Name: Simpsons Character Viewer
Data API: http://api.duckduckgo.com/?q=simpsons+characters&format=json Package/Bundle name: com.sample.simpsonsviewer
   
Version Two
Name: The Wire Character Viewer
Data API: http://api.duckduckgo.com/?q=the+wire+characters&format=json Package/Bundle name: com.sample.wireviewer
