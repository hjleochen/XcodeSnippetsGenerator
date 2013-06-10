require 'rubygems'
require 'plist'

TARGET_PATH  = ENV['HOME']+"/Library/Developer/Xcode/UserData/CodeSnippets";

def comp_sinppet(abbr,content,snippet_info)
  snippet = {}
  snippet[:IDECodeSnippetCompletionPrefix] = abbr
  snippet[:IDECodeSnippetCompletionScopes] = [ snippet_info[:scope] || 'All' ]
  snippet[:IDECodeSnippetContents] = content
  snippet[:IDECodeSnippetIdentifier] = abbr
  snippet[:IDECodeSnippetLanguage] = snippet_info[:language] || "Xcode.SourceCodeLanguage.Objective-C"
  snippet[:IDECodeSnippetSummary] = snippet_info[:summary] || abbr
  snippet[:IDECodeSnippetTitle] = snippet_info[:title] || abbr
  snippet[:IDECodeSnippetUserSnippet] = true
  snippet[:IDECodeSnippetVersion] = 1
  snippet.to_plist
end

def parse_or_skip_header(file_name)
  res = ''
  is_header = true

  snippet_info = {}

  #TODO Parse info from header comments
  #format from: https://github.com/mattt/Xcode-Snippets
  #// dispatch_async Pattern for Background Processing - Title
  #// Dispatch to do work in the background, and then to the main queue with the results - Summary
  #// 
  #// Platform: All
  #// Language: Objective-C - Language
  #// Completion Scope: Function or Method - Scope
 
  File.open(file_name).readlines.each do |line|
    if line =~ /(^\s*\/\/)|(^\s*$)/ and is_header
      next 
    end
    is_header = false
    res +=  line
  end

  return res,snippet_info
end

Dir.glob("*.m").each do |file|
  abbr = file.split(".")[0]
  target_file = "#{TARGET_PATH}/#{abbr}.codesnippet"
  content,snippet_info =  parse_or_skip_header(file)
  file_content = comp_sinppet(abbr,content,snippet_info)
  File.open(target_file,"w").write(file_content)
end

