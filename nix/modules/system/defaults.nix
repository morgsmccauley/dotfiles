{ ... }: {
  system.defaults = {
    NSGlobalDomain = {
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      _HIHideMenuBar = true;
      ApplePressAndHoldEnabled = false;
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
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";
    };

    loginwindow.GuestEnabled = false;
    LaunchServices.LSQuarantine = false;
  };

  system.activationScripts.postUserActivation.text = ''
    # NOTE: Avoid logout/login cycle after configuring defaults
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
