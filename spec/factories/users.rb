# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }

    factory :user_authed do
      after(:build) do |user|
        user.generate_login_code!

        # make it look like the login code was generated a minute ago
        user.login_code_generation -= 1.minute

        user.generate_auth_token!
      end
    end

    factory :user_shadowbanned_authed do
      after(:build) do |user|
        # auth the user
        user.generate_login_code!

        # make it look like the login code was generated a minute ago
        user.login_code_generation -= 1.minute
        user.generate_auth_token!

        # shadowban
        user.shadow_ban!
      end
    end

    factory :user_admin_authed do
      after(:build) do |user|
        # auth the user
        user.generate_login_code!

        # make it look like the login code was generated a minute ago
        user.login_code_generation -= 1.minute
        user.generate_auth_token!

        # make them admin
        user.make_admin!
      end
    end
  end
end
