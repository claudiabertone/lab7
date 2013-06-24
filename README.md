## SWorD ##
SWorD (Social Web of real Domotics) is a prototype social network where users, homes, providers, devices and appliances can interact and act in a "smarter" way, by talking each other and thus lowering the technical knowledge to use home automation and domotics systems.

### LAB2 ###
1) Creation of static pages for our social network: home, about and contact

- `rails generate controller Pages home about contact` (or from the RubyMine menu *Tools > Run Rails Generator...*)

2) Add title to HTML files: "SWorD | Page name"

- by using the `provide` method in each view, i.e., `<% provide :title, 'Page name' %>`
- by editing the title tag in `app/views/layouts/application.html.erb`, i.e., `<title>SWorD | <%= yield(:title) %>`
- learn more about `provide` at [http://api.rubyonrails.org/classes/ActionView/Helpers/CaptureHelper.html#method-i-provide](http://api.rubyonrails.org/classes/ActionView/Helpers/CaptureHelper.html#method-i-provide)

3) Add an helper to avoid wrong rendering if the page title is not declared

- in `app/helpers/application_helper.rb`
- by editing the title tag in `app/views/layouts/application.html.erb`

### LAB4 - Preparation ###
1) Fill with some contents all the views

2) Add `bootstrap-sass` gem to include the Bootstrap framework with Sass support [http://twitter.github.io/bootstrap/](http://twitter.github.io/bootstrap/)

- update the `Gemfile`
- run `bundle install`

3) Add and fill a custom SCSS file in `app/assets/stylesheets`

### LAB4 ###
1) Move HTML shim, header and footer code in three partials (placed in `app/views/layouts/`)

2) Update the `routes.rb` file, according to the table present in the exercise 1 text

3) Update links present in `_header.html.erb` and `_footer.html.erb`

4) Add a faq page:

- add a new view called `faq.html.erb` with a content similar to the other views
- update the Pages controller
- add the corresponding named route to `routes.rb`

5) Add a Users controller and a page named "new"

- `rails generate controller Users new` (or from the RubyMine menu *Tools > Run Rails Generator...*)
- fill the content of the `new.html.erb` view
- update/add the corresponding named route to `routes.rb`, mapping it with the signup URI
- update the "Sign Up" link present in `home.html.erb`

### LAB 5 ###
1) Generate the User model, with two attributes: name and email

- `rails generate model User name:string email:string` (or from the RubyMine menu *Tools > Run Rails Generator...*)

2) Migrate the model to the database (i.e., create the table and columns corresponding to the User model)

- `bundle exec rake db:migrate` (or from the RubyMine menu *Tools > Run Rake Tasks...*)

3) Add some gems to the Gemfile (and perform a `bundle install`)

- `annotate` (version 2.5.0) to show some annotations in the Rails models
- `bcrypt-ruby` (already present, but commented) to have some state-of-the-art hash functions available in Rails

4) Annotate the User model to show a little bit more information

- `bundle exec annotate` (or add a new configuration of type *Gem Command* from the RubyMine menu *Run > Edit Configurations...*)

5) Add debug information in `application.html.erb`, by using the `debug` method

6) Add some validations to the User model

- `name` must be always present (`presence: true`) and it must have a maximum length of 50 characters (`length: { maximum: 50 }`)
- `email` must be always present, unique (`uniqueness: { case_sensitive: false }`) and with a specific defined format (`format: { with: VALID_EMAIL_REGEX }`)

7) Enforce the uniqueness of the email by using a migration

- add an index on the `email` column in the database

8) Give to the User model a `password` field

- generate/migrate a migration to add a column to store the password digest (i.e., an encrypted version of the password)
- update the User model with two virtual attributes: `password` and `password_confirmation`
- add the `has_secure_password` method to the User model, to use the authentication system of Rails

### LAB 6 - Preparation ###

1) Add routes for users

- `resources :users` in `config/routes.rb`

2) Add a user in the database, by editing the action `new` in the Users controller

3) Add a new view associated to the Users controller

- create `show.html.erb` in `app/views/users` (filled with some contents)
- update the page stylesheet
- add the corresponding action to the User controller (`users_controller.rb`)

4) Add an helper for using a Gravatar as profile pic for the users (in `users_helper.rb`)

- update the view responsible of showing users (`show.html.erb`)

