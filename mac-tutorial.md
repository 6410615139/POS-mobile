# mac

[Document](https://reactnative.dev/docs/environment-setup?guide=native)
[Youtube](https://www.youtube.com/watch?v=0mDN6cUOWiw)

environment setup
```
brew install node
brew install watchman
```

make sure it is Node 18 or newer.

`node --version`

### iOS

CocoaPods is a Ruby gem. You can install CocoaPods using the version of Ruby that ships with the latest version of macOS.y

`brew install cocoapods`

start project

`npx react-native init POS`

run stimulator

`npm run ios`

fix error

`brew install ios-deploy`

### Android
```
brew tap homebrew/cask-versions
brew install --cask zulu17

brew info --cask zulu17
```

install zulu
```
cd /opt/homebrew/Caskroom/zulu17/17.0.10,17.48.15
open Double-Click\ to\ Install\ Azul\ Zulu\ JDK\ 17.pkg
```

Download android-studio[Android studio Download](https://developer.android.com/studio?utm_source=android-studio)

Android Studio installs the latest Android SDK by default. Building a React Native app with native code, however, requires the Android 13 (Tiramisu) SDK in particular. Additional Android SDKs can be installed through the SDK Manager in Android Studio.

Add the following lines to your ~/.zprofile or ~/.zshrc (if you are using bash, then ~/.bash_profile or ~/.bashrc) config file:
```
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

run zsh

`exec zsh`

run stimulator

`npm run android`

