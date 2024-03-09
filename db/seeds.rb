# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create! email: 'admin@admin.com', password: '1234567', password_confirmation: '1234567'

30.times do
  p = Proponent.create! name: Faker::Name.name,
                        cpf: Faker::CPF.numeric,
                        birthdate: Faker::Date.birthday(min_age: 20, max_age: 65),
                        salary: Faker::Number.decimal(l_digits: 4, r_digits: 2)

  CalcInssJob.new.perform(p.id)

  p.create_address(street: Faker::Address.street_address,
                   neighborhood: Faker::Address.community,
                   state: Faker::Address.state_abbr,
                   city: Faker::Address.city,
                   zipcode: Faker::Address.postcode.gsub('-', ''),
                   number: Faker::Address.building_number)
end
