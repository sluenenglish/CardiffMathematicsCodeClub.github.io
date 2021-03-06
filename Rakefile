require 'fileutils'
require 'html/proofer'
require 'yaml'

task default: %w[help]
task :help do
  exec("rake -T")
end

desc 'List all the drafts currently on the site'
task :drafts do
  Dir.glob("_drafts/*.md") do |file|
    puts File.basename(file, ".md")
  end
end

desc 'Start working on a new post in _drafts'
task :newpost, [:name] do |t, args|
  front_matter = %q(
---
layout: post
title: YOUR TITLE HERE
categories: CATEGORY
tags: TAGS
author: YOUR NAME
---

Your awesome blog post goes here.
See the "How to write a blog post" tutorial for more information on
what can go here

)

  # If _drafts doesn't exist, make it
  FileUtils.mkdir("_drafts") unless File.exists?("_drafts")

  # Make sure the file doesn't already exist
  if File.exists?("_drafts/#{args.name}.md")
    raise "_drafts/#{args.name} already exists"
  end

  File.write("_drafts/#{args.name}.md", front_matter)
  puts "Draft post: _drafts/#{args.name}.md created"
end

desc 'Publish a post in drafts'
task :publishpost, [:name] do |t, args|

  # Check it exists
  if not File.exists?("_drafts/#{args.name}.md")
    raise "_drafts/#{args.name}.md doesn't exist"
  end

  # Load the draft file

  # First we need to get the YAML front matter for the post
  # and enable comments.
  #frontm = YAML.parse_file("_drafts/#{args.name}.md")
  #frontm["comments"] = true

  # Next we need to get the current date
  time = Time.new
  date = time.strftime("%Y-%m-%d")

  FileUtils.mv("_drafts/#{args.name}.md", "_posts/#{date}-#{args.name}.md")

  puts "Published post _drafts/#{args.name}.md as _posts/#{date}/#{args.name}.md"

end

desc 'Run the jekyll server'
task :preview do
    sh "bundle exec jekyll serve"
end

desc 'Run the jekyll server, including all the drafts in _drafts'
task :develop do
    sh "bundle exec jekyll serve --drafts"
end

desc 'Build the site and run the tests'
task :test do
   sh "script/cibuild"
   HTML::Proofer.new("./_site",
                     { :check_html => true,
                       :only_4xx => true,
                       :url_ignore => [%r{[Cc]ardiff[Mm]athematics[Cc]ode[Cc]lub\.github\.io}]}).run
end
