# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street { Faker::Address.street_address }
    neighborhood { Faker::Address.community }
    state { Faker::Address.state_abbr }
    city { Faker::Address.city }
    zipcode { Faker::Address.postcode.gsub('-' '') }
    number { Faker::Address.building_number }
  end
end
