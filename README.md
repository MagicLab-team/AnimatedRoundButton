# AnimatedRoundButton
Beautiful animated round button.

|             Demo                |
|---------------------------------|
|![Demo](https://github.com/MagicLab-team/AnimatedRoundButton/blob/master/AnimatedRoundButtonExample/Demo.gif)|

## Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)


## Requirements

- iOS 8.0+
- Swift 3.0+

## Installation
All logic is in [AnimatedRoundButton.swift](https://github.com/MagicLab-team/AnimatedRoundButton/blob/master/AnimatedRoundButton/AnimatedRoundButton.swift) file.
Just copy this [file](https://github.com/MagicLab-team/AnimatedRoundButton/blob/master/AnimatedRoundButton/AnimatedRoundButton.swift) to your project.


# Usage
1 - You can set class AnimatedRoundButton to view in storyboard an use @IBInspectable properties to setup button.

2 - You can do it from code:
```swift 
let button = AnimatedRoundButton(
  frame: CGRect(x: 0, y: 0, width: 200, height: 200)
)
button.center = view.center
view.addSubview(button)
        
button.text = "AnimatedRoundButton"
button.font = UIFont(name: "Helvetica", size: 25)!
```

3 - You may setup colors for different states
```swift
button.textColorsForStates[.normal] = UIColor.red
button.textColorsForStates[.up] = UIColor.white
button.textColorsForStates[.down] = UIColor.white

button.contentColorsForStates[.normal] = UIColor.clear
button.contentColorsForStates[.up] = UIColor.red
button.contentColorsForStates[.down] = UIColor.clear
```

4 - You may setup scale factors for different states
```swift
button.scaleFactors[.normal] = 1
button.scaleFactors[.up] = 1.3
button.scaleFactors[.down] = 0.7
```


## License

AnimatedRoundButton is released under the MIT license. See [LICENSE](https://github.com/MagicLab-team/AnimatedRoundButton/blob/master/LICENSE) for details.
