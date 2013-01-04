#User Management & Account Management 

This application is useful for managing users and their posts. User can authenticate for the app using CAS server authentication system which is hosted at [http://loginbt.weboapps.com](http://loginbt.weboapps.com). This app also having role management system. Their are three predefined roles (Admin, Staff & User)

* Admin: Can manage users and their posts
* Staff: Can change password and manage posts
* User:  Can recover password and manage posts

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

##CASclient

This app working on CAS server authentication system using *rubycas-client gem*

CAS provides a solid and secure single sign on solution for web-based applications. When a user logs on to your CAS-enabled website, the CAS client checks with the CAS server to see if the user has been centrally authenticated. If not, the user is redirected to your CAS server's web-based login page where they enter their credentials, and upon successful authentication are redirected back to your client web application. If the user has been previously authenticated with the CAS server (with their 'ticket' being held as a session cookie), they are transparently allowed to go about their business.

###Change CAS server url
We just have to add

```
RUBY_CAS_SERVER = "http://cas-server-url/"
``` 

in application > config > environments > *application-environment*.rb file
  


