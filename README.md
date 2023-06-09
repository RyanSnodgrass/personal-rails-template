My Unofficial Rails Template
===

This is the starting point of your Rails application. Use [Rails Application Templates](https://guides.rubyonrails.org/rails_application_templates.html) to kickstart your app with the most common elements I use in a Rails app. After boot, it should not be necessary to run any other configuration or setup for the gems included here.

The commands that were run and the gems included were guided by these priorities:

### Stability
This is the top priority. This has to work all the time, every time. The first time it doesn’t run correctly we lose developer trust.

### Maintainability
Ties together with stability. Updates have to be easy. Else it’ll fall behind and I won't want to maintain it.

And if it's fallen behind, who would want to use it?

### Transparency
I don’t trust app engines. I always think they add BS I don’t need. All the gems and commands should have comments laying out what they do and why they're there.

### Simplicity
The goal of this repo is not to install Ruby or Rails. That would encompass too much. Follow the "does one thing and does it well" axiom.

# Usage
Making sure you already have Ruby and Rails installed-
```
rails new <app_name> -m "https://raw.githubusercontent.com/ryansnodgrass/personal-rails-template/main/template.rb?token=GHSAT0AAAAAABY6MJEXUZVGG3SCOVJDMA7KY6JW6KA"
```

If you want to edit the gems you can download the template.rb file to somewhere on your local file system and point the `-m` command to it:
```
rails new <app_name> -m path/to/template.rb
```
