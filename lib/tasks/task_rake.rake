namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@sword.it",
                 password: "pwd123",
                 password_confirmation: "pwd123")
    99.times do |n|
        name = Faker::Name.name
        email = "example-#{n+1}@sword.it"
        password = "password"
        User.create!(name: name,
                     email: email,
                    password: password,
                     password_confirmation:password)
   end
  end
end