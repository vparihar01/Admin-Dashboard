#User Management & Account Management 

This application is useful for managing users and their posts. User can authenticate for the app using CASserver authentication system which is hosted at [http://loginbt.weboapps.com](http://loginbt.weboapps.com). This app also having role management system. Their are three predefined roles (Admin, Staff & User)

* Admin: Can manage users and their posts
* Staff: Can change password and manage posts
* User:  Can manage posts

##Installation

requires at least Ruby 1.9.3 to run. Install Ruby Gems and Bundler if
you have not already.

```
$ git clone git@github.com:vparihar01/Admin-Dashboard.git
$ bundle install
$ rake db:create
$ rake db:migrate
$ rake db:seed
$ rails server
```


