## Xcode Snippets Generator

Generate xcode sinippets from current dir(*.m) to ~/Library/Developer/Xcode/UserData/CodeSnippets

## Using Generator

git clone https://github.com/hjleochen/XcodeSnippetsGenerator.git

cd XcodeSnippetsGenerator

mkdir -p ~/Library/Developer/Xcode/UserData/CodeSnippets

gem install plist

ruby gen.rb

restart Xcode

