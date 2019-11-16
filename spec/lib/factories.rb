require "faker"
require_relative "../models/user_model"

FactoryBot.define do
  factory :user, class: UserModel do
    full_name { "Otavio Now" }
    email { "vanzella@gmail.com" }
    password { "roberto25" }

    after(:build) do |user|
      # puts "Apagando o email " + user.email
      Database.new.delete_user(user.email)
    end
  end

  factory :registered_user, class: UserModel do
    id { 0 }
    # full_name { "Anakin Skywalker" }
    # email { "anakin@jedi.com" }
    full_name { Faker::Movies::StarWars.character }
    email { Faker::Internet.free_email(full_name) }
    password { "darthvader" }

    after(:build) do |user|
      Database.new.delete_user(user.email)
      result = ApiUser.save(user.to_hash)
      user.id = result.parsed_response["id"]
    end
  end

  factory :user_wrong_email, class: UserModel do
    full_name { "Otavio Rober" }
    email { "vanzella25#gmail.com" }
    password { "roberto" }
  end

  factory :empty_name_user, class: UserModel do
    full_name { "" }
    email { "vanzella25@gmail.com" }
    password { "roberto25" }
  end

  factory :empty_email_user, class: UserModel do
    full_name { "Otavio" }
    email { "" }
    password { "roberto25" }
  end

  factory :empty_password_user, class: UserModel do
    full_name { "Otavio" }
    email { "vanzella25@gmail.com" }
    password { "" }
  end

  factory :name_null, class: UserModel do
    email { "vanzella25@gmail.com" }
    password { "" }
  end

  factory :email_null, class: UserModel do
    full_name { "Otavio" }
    password { "" }
  end

  factory :password_null, class: UserModel do
    full_name { "Otavio" }
    email { "vanzella25@gmail.com" }
  end
end
