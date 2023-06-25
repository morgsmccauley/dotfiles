{ ... }:

{
  system.defaults = {
    NSGlobalDomain = {
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      _HIHideMenuBar = true;
    };

    trackpad = {
      TrackpadThreeFingerDrag = true;
      Clicking = true;
      ActuationStrength = 0;
    };

    dock = {
      autohide = true;
      show-process-indicators = true;
      show-recents = true;
      static-only = true;
      mru-spaces = false;
    };

    finder = {
      ShowPathbar = true;
      AppleShowAllFiles = true;
    };

    loginwindow = {
      GuestEnabled = false;
    };

    LaunchServices = {
      LSQuarantine = false;
    };
  };

  system.activationScripts.postUserActivation.text = ''
    # Avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # system.defaults.CustomUserPreferences = {
  #   "com.apple.Dock" = {
  #     "static-others" = ''<array><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/morganmccauley/Downloads/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Downloads</string><key>url</key><string>file:///Users/morganmccauley/Downloads/</string></dict><key>tile-type</key><string>directory-tile</string></dict><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Applications</string><key>url</key><string>file:///Applications/</string></dict><key>tile-type</key><string>directory-tile</string></dict><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/morganmccauley/Documents/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Documents</string><key>url</key><string>file:///Users/morganmccauley/Documents/</string></dict><key>tile-type</key><string>directory-tile</string></dict><dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/morganmccauley/Developer/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-type</key><integer>2</integer><key>showas</key><integer>2</integer><key>displayas</key><integer>1</integer><key>file-label</key><string>Developer</string><key>url</key><string>file:///Users/morganmccauley/Developer/</string></dict><key>tile-type</key><string>directory-tile</string></dict></array>'';
  #   };
  # };
}
