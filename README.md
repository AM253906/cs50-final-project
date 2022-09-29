# Habitual

A community habit tracking application using Flutter and Firebase.

#### Video Demo: <https://youtu.be/7OiqpHgW9Ms>

#### Description:

I will start out with the function of the app as well as how to use it, then I will divide this into sections based on the files used to run the program. First, there are two front pages: sign in, and register. A new user will have to go to the register page to sign up and use the app. Both of these pages use the Firebase Authentication service to either log an existing user in, or create a new user using an email and password.
Once logged in, a user will see a newly created list tile with a title "Unassigned Username" that is auto-generated with the Firebase Firestore using dummy data which the user is then allowed to modify. In the top right of the app, there will be a settings and logout button. The user may click on the logout button which will take them to the login page, which they may now log back in with the email and password they used to register. If the user wants to customize their tile, they shoulld click the settings icon button. This will pop up a form settings panel from the bottom of the screen. The first field will be for the user to change their visible username. The next field is for choosing a habit they would like to track. The third field is for inputting the number of days the user has "conquered" their chosen habit(s). Finally, there is a slider which the user can set to indicate their current happiness with working towards their new habit. Once these fields are set, the update button will send the information to the Firebase Firestore and be displayed on their respective list tile. Below this update button is a delete account button which will delete the user from Firebase Authentication as well as their stored data in the Firebase Firestore. Now onto the used files and their functions.

##### habit.dart

This file contains the Habit class which is used throughout the project to either provide a list of habit data along with the user's name or to provide a stream of this data in order to get back a snapshot of the data that is in the Firebase Firestore.

##### user.dart

This file contains two classes: MyUser and UserData. The UserData class is similar to the Habit class, however it also contains a uid property which links a certain user to their habit data. The MyUser class is used to clean up some of the information gained back from the Firebase auth service. Instead of saving or getting back a bunch of unique data about the user, the application only gets back the uid which is then used to link a user with their document of data in the FIrestore collection.

##### authenticate.dart

This file conatins a toggleView function which is used to switch between login and register screens. Initially, the showSignIn bool is set to true, however when the toggleView function is invoked it is set to false, thus showing the register page instead. In the context of the widget is an "if" conditional which tells the program when to either return SignIn or Register.

##### register.dart

This contains a stateful widget used to register a new user using the Firebase authentication service. There are two form fields, one for email and another for password. If a user attempts to put in something besides a valid email or a passowrd of at least 6 characters, an error message containing a hint will be displayed instead of registering the user. The icon in the top right invokes the toggleView function provided from the authenticate.dart file which switches screens to the sign in screen. Once the register button is pressed, it invokes an asynchronous function which awaits the Firebase auth service to authenticate and register the new user. This button also invokes a loading screen which will be covered under the loading.dart section.

##### sign_in.dart

This file is nearly identical to the register.dart file with one major exception. Instead of creating a new user using the Firebase auth service, it signs in a user should the email and password match an existing user account. If it does not match a user account, then an error will be displayed saying to provide a valid email or password. In both this file as well as the register.dart file, I orignally had also implmented a sign in anonymously functionality. However this allowed a single user to constantly sign in anonymously and keep on populating the list of user tiles without deleting them once done which did not feel like the best design.

##### form_settings.dart

This file contains the widget for being able to update user data which will both be sent to their respective Firebase Firestore document data as well as displayed on their user tile. It returns a stream builder first which allows the program to immediately update the displayed data and their Firestore document once the update functionality is invoked. The rest is wrapped in an if conditional which allows the program to know if the current user has data or not. If the user has data, it will be auto-populated into the form fields as well as the slider. If not, the loading screen widget will be displayed instead of the form fields in the settings menu. Once the desired new data is inputted and the update button is pressed, an asynchronous function is invoked which uses a global form key to validate, which if successful links the user's uid with the matching uid in the Firestore to update their corresponding data. It also uses a Navigator.pop function which closes the setting window once the data has been updated as the updating data function uses an await clause.
Under the update button is a delete account function. It also uses a gloabal form key to validate, and if successful instead this function first uses the Navigator.pop function to close the form, grabs the instance of the current user, deletes their corresponding Firestore document, deletes the user based on the instance captured, then finally signs the user out. This was tricky for me because I initially had the Navigator.pop function at the end of this delete account button which caused the program to attempt to read data into the settings form fields which no longer exist. This is why I chose to move the Navigator function to the top.
I originally wanted to make the slider display a different image in the circle avatar of the tile once updated, however I felt that making a happiness indicator for people to see others going through similar feelings could prove beneficial to users.

##### habit_list.dart

This file contains a stateful widget which is used to create a ListView builder which allows the user tiles to be built into list view allowing the user to scroll should the list continue down off of the screen.It is able to do this by setting the habits variable to a Provider.of of a List of the Habit class provided from habit.dart. It then counts the amount of itmes in the itemCount property and uses the itemBuilder property to index each set of habit data.

##### habit_tile.dart

This file contains a stateless widget is used to design and implement the users' tiles as cards which each contain data specific to each user. It calls the Habit class into a habit varaible which is used as a constructor for the HabitTile class. This allows access to a user's habit data based on the index of the itemBuilder in habit_list.dart file which is then used in the title and subtitle properties. The "happiness" value is that of an integer in increments of 100 starting from 100-900 which is then used to decide the strength of a color provided to the CircleAvatar in the tile.

##### home.dart

This file contains a stateless widget which is used to design and implement the logged in home screen using the files above. In the context of the widgett is a void function which defines a function for opening the form settings panel provided from from_settings.dart. This is onvoked by clicking the settings icon button on the top right of the home screen next to the logout icon button. The logout icon button uses an asynchronous function to sign out the user. The body of the page conatins a decoration which allows for the observed zen garden image to be displayed and fit the entire home screen. The child property contains the HabitList widget which was discussed in the habit_list.dart section. Lastly, this uses a StreamProvider which allows for a constant stream of updates or modification to any user data. It listens to the value property and provides it to all descendants of the stream provider.

##### wrapper.dart

This file tells the program whether to show the authenticate pages(sign in or register) or the home page. It does this by grabbing the Provider.of method from MyUser and is set to the user variable. If the user is not logged in, it will return null which is read by the "if" conditional and returns the authenticate widget. Else, it returns the home widget.

##### auth.dart

This file contains the AuthService class which is provided for the use of the methods mentioned in this section. First a MyUser object is created should the user value not return null. Next is an authentication change user stream used to map out and listen to the authStateChanges which is a method provided by Firebase_auth, which is provided by Firebase itself.
Next is a future asychronous function which allows for a user to sign in with their email and password. It uses a UserCredential class provided by Firebase to await a signInWithEmailAndPassword method provided bby Firebase, not to be confused with the identically named future function itself. The Firebase User class is then updated with the user information from the UserCredential result.
The register function is similar with a couple of differences. First it uses a createUserWithEmailAndPassword method provided by Firebases instead of the signIn method. Second, it creates a new document to the Firestore collection based on the user's uid which allows for their document to be linked to the user using identical identifiers for both the user's doc and their own uid. If no collection is present yet to store user documents, Firestore will create one for us.
Lastly is a simple signOut function which uses the signOut method provided by Firebase to log the user out.

##### database.dart

This file contains the DatabaseService class which provides a few methods.
Firstly, using a class and method provided by Firestore the "Habit" collection is stored into the habitCollection variable.
updateUserData is a method using the collection reference from habitCollection to set the user's updated data provided from the form settings.
Next is a list created from the snapshots of complete user data which is mapped out and then lastly turned into a list.
Next, the UserData class is used to gather user specific snapshots of their data which also includes the user's uid.
Lastly are two streams, one for gathering a snapshot of the entire collection and another to gather user specific documents from the originating collection.

##### constants.dart

This file conatins the styling which is used for all form fields found in the app. It provides a normal border as well as a different border when focused. It also fills the form field with white for better visibility.

##### loading.dart

This file contains the loading screen widget which is called when a user signs in, registers, signs out, or has no data for the form settings to read. I used the flutter spinkit library to implement the animation.

##### main.dart

Lastly is the main.dart file. This file is what ultimately runs the app and everything is linked here in some way. The first void function is a function required for Firebase to initialize per the Firebase documentation. Inside the build context is a stream provider which eventually tells the Wrapper widget nested in the home property which page to show to the user

###### Final Words

This project took quite a bit of time having to learn Dart as a language and the Flutter framework so I hope you enjoy! This course has given me a new love and reignited my passion. Having never programmed before this course, I am now dedicated as a lifelong learner of the craft and here's to new beginnings! Thank you for the opportunity and everything you all do.