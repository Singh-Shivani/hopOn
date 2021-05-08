
[![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)](https://github.com/Singh-Shivani/hopOn/blob/master/license.md)
![Safe](https://img.shields.io/badge/Stay-Safe-red?logo=data:image/svg%2bxml;base64,PHN2ZyBpZD0iTGF5ZXJfMSIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgNTEwIDUxMCIgaGVpZ2h0PSI1MTIiIHZpZXdCb3g9IjAgMCA1MTAgNTEwIiB3aWR0aD0iNTEyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxnPjxnPjxwYXRoIGQ9Im0xNzQuNjEgMzAwYy0yMC41OCAwLTQwLjU2IDYuOTUtNTYuNjkgMTkuNzJsLTExMC4wOSA4NS43OTd2MTA0LjQ4M2g1My41MjlsNzYuNDcxLTY1aDEyNi44MnYtMTQ1eiIgZmlsbD0iI2ZmZGRjZSIvPjwvZz48cGF0aCBkPSJtNTAyLjE3IDI4NC43MmMwIDguOTUtMy42IDE3Ljg5LTEwLjc4IDI0LjQ2bC0xNDguNTYgMTM1LjgyaC03OC4xOHYtODVoNjguMThsMTE0LjM0LTEwMC4yMWMxMi44Mi0xMS4yMyAzMi4wNi0xMC45MiA0NC41LjczIDcgNi41NSAxMC41IDE1LjM4IDEwLjUgMjQuMnoiIGZpbGw9IiNmZmNjYmQiLz48cGF0aCBkPSJtMzMyLjgzIDM0OS42M3YxMC4zN2gtNjguMTh2LTYwaDE4LjU1YzI3LjQxIDAgNDkuNjMgMjIuMjIgNDkuNjMgNDkuNjN6IiBmaWxsPSIjZmZjY2JkIi8+PHBhdGggZD0ibTM5OS44IDc3LjN2OC4wMWMwIDIwLjY1LTguMDQgNDAuMDctMjIuNjQgNTQuNjdsLTExMi41MSAxMTIuNTF2LTIyNi42NmwzLjE4LTMuMTljMTQuNi0xNC42IDM0LjAyLTIyLjY0IDU0LjY3LTIyLjY0IDQyLjYyIDAgNzcuMyAzNC42OCA3Ny4zIDc3LjN6IiBmaWxsPSIjZDAwMDUwIi8+PHBhdGggZD0ibTI2NC42NSAyNS44M3YyMjYuNjZsLTExMi41MS0xMTIuNTFjLTE0LjYtMTQuNi0yMi42NC0zNC4wMi0yMi42NC01NC42N3YtOC4wMWMwLTQyLjYyIDM0LjY4LTc3LjMgNzcuMy03Ny4zIDIwLjY1IDAgNDAuMDYgOC4wNCA1NC42NiAyMi42NHoiIGZpbGw9IiNmZjRhNGEiLz48cGF0aCBkPSJtMjEyLjgzIDM2MC4xMnYzMGg1MS44MnYtMzB6IiBmaWxsPSIjZmZjY2JkIi8+PHBhdGggZD0ibTI2NC42NSAzNjAuMTJ2MzBoMzYuMTRsMzIuMDQtMzB6IiBmaWxsPSIjZmZiZGE5Ii8+PC9nPjwvc3ZnPg==)
<img alt="Dart" src="https://img.shields.io/badge/dart-%230175C2.svg?&style=for-the-badge&logo=dart&logoColor=white" width=53 />
<img alt="Flutter" src="https://img.shields.io/badge/Flutter-%2302569B.svg?&style=for-the-badge&logo=Flutter&logoColor=white" width=68 />
<img alt="Figma" src="https://img.shields.io/badge/figma-%23F24E1E.svg?&style=for-the-badge&logo=figma&logoColor=white" width=58 />
<img alt="Firebase" src="https://img.shields.io/badge/firebase-%23039BE5.svg?&style=for-the-badge&logo=firebase" width=75 />

![hopnOnPoster (1)](https://user-images.githubusercontent.com/47295558/117294618-79fbc980-ae90-11eb-9ca8-98bb3278e495.png)

<p align ="center"> 
<i> A car sharing & rental app using <a href="https://flutter.dev/">Flutter</a>, <a href="https://firebase.google.com/">Firebase </a> & <a href="https://cloud.google.com/">Google Maps APIs 🔥</a></i>
</p>
<br><br>

## About the App 🚘
  - hopOn is flutter based application for car sharing and rental services.
  - The two main functions that app includes are -
    1. Rent a nearby car 
    2. Give your car on rent
  - The app uses 3 Google Maps API
    1. Geocoding API (provides geocoding and reverse geocoding of addresses)
    2. Places API (returns information about places using HTTP requests)
    3. Directions API (returns JSON or XML-formatted directions between locations)
   
  - If user wants to rent a car he/she has to search for a dropOff location, after selecting a location(from suggestions) user gets the cost of ride with options to select pickup and dropOff dates.
  - After this information user gets a list of cars which are available in his/her nearby area. On the selection of any of the cars it shows all the information about car- owner's name, car's rent etc. After this you can pay and your ride will be booked.
  - For payments app uses [ Razorpay Demo platform ](https://pub.dev/packages/razorpay_flutter)(package in flutter)
  - Once the payment is done, it saves the data in Firebase Realtime Database. Along with saving ride history on user's end who has booked this ride, information about the rented car also gets saved on the owner side where he can see who has rented his/her car with some information about the ride. A User can cancel a ride anytime.
  - You can give your car on rent by just providing some information about the car your're registering like image, model name etc. It gets save in Firebase Firestore. After registerting your car you have an option to give your car on rent or to remove it from rent anytime you want.

## Wireframe✒️ 
   - https://www.figma.com/file/3ALznWfTL7k7nPWyPuMfKT/Vehicle-Sharing-App?node-id=18%3A3

## In action👀

<h3 align="center">1. Rent a car</h3>
<p align="center">
   <img src="images/rent_car.gif" alt="Logo" height="600" > 
 </p> 
 <br>
 <h3 align="center">2. Give your car on rent</h3>
 <p align="center">
     <img src="images/give_on_car.gif" alt="Logo" height="600"> 
</p>
<br><br>
<h3 align="center">3. Rented car's details</h3>
 <p align="center">
    <img src="images/owner_history.gif" alt="Logo" height="600"> 
 </p>
 <br><br>
 
## Some important things to note
   - If you're trying to make changes or to contribute in this project, please make sure you have a brand new Firebase project and connect that with Google Cloud Platform to access maps features.
   - Follow these [steps](https://github.com/Singh-Shivani/Food_Lab/blob/master/Updates.md) if you're new to Firebase.
   - GCP gives you $200 free on your first project, you just have to link your project with a billing account. Please follow official docs for more details.
   - In GCP under API & SERVICES make sure you have enabled these 3 APIs along with API FOR Android/iOS.
   - Test if your API key if working perfectly else restricts the keys with a particular API service.
   - !!THE MOST IMPORATNT POINT!!
   -  Make sure your project is under Google Maps Platform services otherwise you can't have access to these APIs even if you have enabled it successfully. It will not grant permission to use the API and you'll get errors afterwards.
   -  If you have your project under GMP service(either you can use GCP or GMP for a project) your firebase project won't work here, so here is the solution we followed:
   -  We made a firebase project named as 'hopOnFirebase', we connected that with GCP(because firebase project only connects to GCP) and flutter app.
   -  We made another project "mapsProject" which follows GMP because it is a GMP project, now you can enable and use these 3 APIs. 
   -  Generate your API key(restrict them to these 3 API services only).
   -  Your flutter app is connected to Firebase project "hopOnFirebase". Now you can use this API key(Key of "mapsProject" ) into you flutter app(connected with "hopOnFirebase")
   -  That's all!

## Keep Going!!!
   - Feel free to ask your doubts and contribute to this project.
   - Do ⭐ the repo if you like the work!🙌

