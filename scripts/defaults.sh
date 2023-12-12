#!/bin/bash
set -eu


main() {
  echo 'Changing MacOS settings...'
  setting_defaults
  setting_key
  setting_finder
  setting_trackpad
  setting_threefinger_drag
  setting_dock

  defaults write com.apple.CrashReporter DialogType -string "none"    # クラッシュレポートを無効化する
  defaults write com.apple.LaunchServices LSQuarantine -bool false    # 未確認のアプリケーションを実行する際のダイアログを無効にする
  defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false  # スペルの訂正を無効にする
  defaults write com.apple.finder WarnOnEmptyTrash -bool false        # ゴミ箱を空にする前の警告の無効化
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE  # .DS_Storeファイルを作らせない
  defaults write com.apple.dock orientation left

  # Disable auto-capitalization
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

  # Display date, day, and time in the menu bar
  defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm'

  # Display battery level in the menu bar
  defaults write com.apple.menuextra.battery ShowPercent -string "YES"
}

setting_defaults() {
  ## terminalでUTF-8のみを使用する
  defaults write com.apple.terminal StringEncodings -array 4
}

setting_key() {
  defaults write -g InitialKeyRepeat -int 12    # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 1            # normal minimum is 2 (30 ms)
}

setting_finder() {
  defaults write -g AppleShowAllExtensions -bool true       # 全ての拡張子のファイルを表示する
  # Disable animation
  defaults write com.apple.finder DisableAllAnimations -bool true

  # Show hidden files by default
  defaults write com.apple.finder AppleShowAllFiles -bool true

  # Show files with all extensions
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Display the status bar
  defaults write com.apple.finder ShowStatusBar -bool true

  # Display the path bar
  defaults write com.apple.finder ShowPathbar -bool true
}

setting_trackpad() {
  defaults write -g com.apple.mouse.tapBehavior -int 1      # タップ時動作をクリックに変更
}

setting_vscode() {
  defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
}

setting_threefinger_drag() {
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true && \
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
}

setting_dock() {
  # Disable animation at application launch
  defaults write com.apple.dock launchanim -bool false
}


main
