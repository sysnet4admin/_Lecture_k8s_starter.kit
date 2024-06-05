# installation 
## Windows 
## https://winget.run/pkg/Eugeny/Tabby
## winget install -e --id Eugeny.Tabby
winget install -e --id Eugeny.Tabby -v 1.0.187

## MacOS 
## https://formulae.brew.sh/cask/tabby
## brew install --cask tabby
## https://github.com/Homebrew/homebrew-cask/blob/master/Casks/tabby.rb
## https://github.com/Homebrew/homebrew-cask/blob/9f5cc2ad2d76791f7cbd679fe38d52a91a35acda/Casks/tabby.rb
## tabby v1.0.187
brew install --cask tabby.rb

#the location of configuration file 
# https://github.com/Eugeny/tabby/wiki/Config-file
## On Windows, %APPDATA%/Tabby
## On macOS: ~/Library/Application Support/tabby
## On Linux: ~/.config/tabby

# Windows 
cp config.yaml $env:APPDATA/tabby 

# MacOS 
cp config.yaml ~/Library/Application\ Support/tabby
