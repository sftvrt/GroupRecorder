# GroupRecorder
# 1. Usage
There are three tab-items in the app. The first tab bar is the user information page, user can change their personal information there. The second bar is for recording, the third bar is only to show the recording files in the app. <br>
Under the second bar(recording): The first page is same for all the participants. Here you can choose you character. <br>
The captain has two pages. The first one is for enter the name of a meeting and search for the players. The second page is the recording page. <br>
Once the player pressed into their session, they will start advertising. Until they get the invitation from player and accept it. <br>
For every meeting there will be a txt file with date and time in the data name created. All the participants personal information will be listed in the file. Besides, the time stamp for recording can also be found in the file.

### Json file Explanation:
Take a look of the following example: [{"userLongitude":"","userCity":"","timeInfo":{"sendMeetingTime":"16596808244 24","startRecordingTime":"1659680825212","stopRecordingTime":"165968082 7868"},"username":`"Benutzername821"`,"userLatitude":"","Alter":"Ihr Alter","regionaleHerkunft":"Ihre Herkunft","userCountry":"","Geschlecht":"weiblich"},{"userLongitude":"","userCit y":"","timeInfo":{"startRecordingTime":"1659680825746","stopRecordingTime": "1659680827416","receiveMeetingTime":"1659680823898"},"username":`"Be nutzername675"`,"userLatitude":"","Alter":"Ihr Alter","regionaleHerkunft":"Ihre Herkunft","userCountry":"","Geschlecht":"weiblich"}] <br>

There are two users in the example file: Benutzername 821 and Benutzername 675. SendMeetingTime is the time in ms for sending “start
recording” message to other users. ReceiveMeetingTime is the time for player to receive the “start recording” message.
startRecordingTime is the time on the iPhone to start recording. <br>
Once the recording is done, both captain and player will be shown the files they just recorded. A file can be sent to server by pressed the send button for two times.

# 2. Get the recording files
The recording files can be found on iphone or mac.
### How to find files in the iphone Sandbox?
* 1). Connect iPhone with the computer <br>
* 2). Open Xcode, choose window -> Devices and Simulators
<img width="1074" alt="Bildschirmfoto 2022-10-21 um 08 59 43" src="https://user-images.githubusercontent.com/104503995/199469862-45a86ed2-040a-432e-b7f6-3272c2e5d3c0.png"> <br>
* 3). Download <br>
After clicking Devices and Simulators, press download container in the following window. <br>
<img width="1026" alt="Bildschirmfoto 2022-10-21 um 09 02 19" src="https://user-images.githubusercontent.com/104503995/199469999-df292b0f-7959-43d5-8799-234269e22730.png"> <br>
* 4). Open Sendbox <br>
After download, there will be an app data file in the computer. <br>
<img width="114" alt="Bildschirmfoto 2022-10-21 um 09 08 27" src="https://user-images.githubusercontent.com/104503995/199470294-c26544ad-9fa5-412f-baeb-de3b57a11b67.png"> <br>
right click the file and choose show Package Contens. <br>
<img width="698" alt="Bildschirmfoto 2022-10-21 um 09 09 23" src="https://user-images.githubusercontent.com/104503995/199470383-41784ec2-3b00-460d-b65a-f7a66c70d798.png"> <br>
Then you can see a folder named AppData and AppDataInfo.plist.
* 5). Find Files <br>
The Recording files will be found in the folder AppData/Documents, text files (user data in json) will be found in the folder AppData/Documents/ ProfileStorageInfo.

### How to find files on the computer?
Normally the directory to the files can be found in the console. <br>
<img width="641" alt="Bildschirmfoto 2022-10-21 um 09 32 44" src="https://user-images.githubusercontent.com/104503995/199471150-bb5efee7-1ed3-4bce-8557-d7ed3acfa895.png"> <br>
They are hidden folders. you can access them by typing command+shift+g in the finder and then input the directory.

## 3. Change languages
Languages change themselves with different system-languages. Localizations are responsible for languages (like the files in the following picture). Currently there are only 3 languages. New languages can be added by adding new localizations and change code in the file changeLanguages.swift (You will see it in the file).

### How to use localizations?
* 1). Add Localization <br>
Filename -> Project Filename -> Info -> localizations -> +
<img width="908" alt="Bildschirmfoto 2022-10-20 um 20 56 10" src="https://user-images.githubusercontent.com/104503995/199471698-d672c5d1-eb26-424b-9639-b1e144b46a91.png">
* 2). Edit Localization
<img width="332" alt="Bildschirmfoto 2022-10-20 um 21 05 15" src="https://user-images.githubusercontent.com/104503995/199471807-39d5ff45-e7b2-4ca5-a2b6-960932361a75.png"> <br>
Number t0 - tn are the serial number of all the texts. If more texts are needed, text number need to be added in all localization files and allTexts.swift file. <br>
* 3) Google sheet to translate <br>
[Google Sheet] (https://docs.google.com/spreadsheets/d/1OzPLpF9lopojoeAplmBRKWZ5AqnirX3fSh84Eeg-76g/edit?usp=sharing)

## 4. Connect to server
Swift files for connection are in the folder toServer. If the login data changes, the parameters are also in the files in the folder to find.

## 5. Files & Folders
* toServer: <br>
Scripts for connecting and sending items to server.
* newRecorder: <br>
New script using AvAudioEngine Framework to record.
* viewModell: <br>
RootViewModel: hide tabbar, navigationbar toRecord: files for recording
toConnect: files for connecting
* Animation: <br>
Animation on the recording page to show the animation.
* Views: <br>
ContenView is basically the root file to put all views on it. Module1: profile pages.
Module 2: pages in the 2. tabbar(recording).
Module 3: showing files, list of showing files.
* Modell: <br>
Basic modell files.
* Common: <br>
Here are some files for changing time into ms, changing language, saving data files.

## 6. Future works
### 1)Agc Function: 
The Function for closing Agc is still not in this app. <br>
* -A possible solution for shut down agc can be the answer on stackoverflow(https://stackoverflow.com/questions/58472683/cancel-ios-
microphone-echo-cancellation-and-noise-suppression). But it didn’t work out for me. <br>
* -Another possible solution may be to create a new framework ‘AvAudioEngine’ for recording. The framework is Normally AvAudioEngine will be used for streaming and professional edit audio Data after recording. But in this framework apple provides a Boolean to indicate whether audio gain control is active (https://developer.apple.com/documentation/avfaudio/avaudioinputnode/31521 02-voiceprocessingagcenabled?language=objc). The new script for recording using the new framework AV AudioEngine is in the folder ‘newRecorder’ in the file ‘Recorder.swift’.

### 2)Apple Developer Program:
There are two methods to submit the app to the Appstore (Small Introduction: https://developer.apple.com/de/support/compare-memberships/). <br>
- Personal Account: 99 USD/year. <br>
- Organization: free to use but need a registration first (https://developer.apple.com/programs/enroll/). 

### 3)Change the app Icon: 
The App icon need to be added inside xcode, instruction to change the icon: https://developer.apple.com/documentation/xcode/configuring-your-app-icon

