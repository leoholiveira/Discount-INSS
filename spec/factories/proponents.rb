# frozen_string_literal: true

FactoryBot.define do
  factory :proponent do
    name  { Faker::Name.name }
    cpf { Faker::CPF.numeric }
    birthdate { Faker::Date.birthday(min_age: 20, max_age: 65) }
    salary { 3000 }

    transient do
      create_address { :address }
    end
  end
end
