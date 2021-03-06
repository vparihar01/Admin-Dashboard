#User Management & Account Management 

This application is useful for managing users and their posts. User can authenticate for the app using CAS server authentication system which is hosted at [http://loginbt.weboapps.com](http://loginbt.weboapps.com). This app also having role management system. Their are three predefined roles (Admin, Staff & User)

* Admin: Can manage users and their posts
* Staff: Can change password and manage posts
* User:  Can recover password and manage posts

##Installation

requires at least <tt>Ruby 1.9.3</tt> to run. Install Ruby Gems and Bundler if
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

This app working on CAS server authentication system using <tt>rubycas-client gem</tt>

CAS provides a solid and secure single sign on solution for web-based applications. When a user logs on to your CAS-enabled website, the CAS client checks with the CAS server to see if the user has been centrally authenticated. If not, the user is redirected to your CAS server's web-based login page where they enter their credentials, and upon successful authentication are redirected back to your client web application. If the user has been previously authenticated with the CAS server (with their 'ticket' being held as a session cookie), they are transparently allowed to go about their business.

###Change CAS server url 
We just have to add 

```
RUBY_CAS_SERVER = "http://example-cas-server-url/"
``` 

in application > config > environments > <tt>application-environment</tt>.rb file

##Role Management

For managing multiple roles app using <tt>cancan gem</tt>

CanCan is an authorization library for Ruby on Rails which restricts what resources a given user is allowed to access. All permissions are defined in a single location (the Ability class) and not duplicated across controllers, views, and database queries.

###Manage Roles

User permissions are defined in an Ability class.

* app/models/ability.rb

```Ruby
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    if user.role? :admin
      can :manage, :all
    elsif user.role? :registered
      can :manage, Post do |post|
        post.user == user
      end
    elsif user.role? :staff
      can :manage, Post
    else
      can :read, :all
    end
  end
end
```
  
The <tt>load_and_authorize_resource</tt> method is provided to automatically authorize all actions in a RESTful style resource controller. It will use a before filter to load the resource into an instance variable and authorize it for every action.

```Ruby
class PostsController < ApplicationController
  load_and_authorize_resource
  
  ...

end
```
If the user authorization fails, a <tt>CanCan::AccessDenied</tt> exception will be raised. You can catch this and modify its behavior in the <tt>ApplicationController</tt>.

```Ruby
rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
end
```

#Models

###User

* app/models/user.rb

User model consist of user related methods and attributes for storing user information in database

After successful authentication of CAS Login cas server redirect back to application with some extra attributes and cas_session.User model storing this information and creating virtual user at application using <tt>cas_extra_attributes</tt> method

```Ruby
 def cas_extra_attributes=(extra_attributes)
    extra_attributes.each do |name, value|
      case name.to_sym
        when :fullname
          self.fullname = value
        when :email
          self.email = value
      end
    end
  end
```

###Post

* app/models/post.rb

Post model consist of validations for post attributes and stores data in database.

###Role

* app/models/role.rb

Role model consist of roles attributes which holds user roles data

#Controllers

###PostsController

* app/controllers/posts_controller.rb

PostsController consist of RESTful actions for managing post.

###ProfilesController

* app/controllers/profiles_controller.rb

ProfilesController consist of authorization and redirection actions

#Testing using Rspec

For the test driven development application using <tt>rspec-rails gem</tt>
All the applications related test cases are in <tt>spec</tt> directory of the app.

In this we covered test cases related to models, controllers and roles of users.

##Run Rspec

In the app directory we have to run following command

```
$ rspec
```

For generating coverage we used <tt>simplecov gem</tt>
When we run <tt>$ rspec</tt> command test cases for application executes and generate coverage of the app .
Rspec Coverage for this application is generated in coverage directory.









