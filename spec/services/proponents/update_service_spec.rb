# frozen_string_literal: true

require 'rails_helper'

describe Proponents::UpdateService, type: :service do
  let(:operation) { described_class }
  let(:proponent) { create(:proponent) }
  let(:valid_attributes) do
    {
      id: proponent.id,
      proponent: {
        name: Faker::Name.name,
        cpf: Faker::CPF.numeric,
        birthdate: Faker::Date.birthday(min_age: 20, max_age: 65),
        salary: Faker::Number.decimal(l_digits: 4, r_digits: 2),
        address_attributes: {
          street: Faker::Address.street_address,
          neighborhood: Faker::Address.community,
          state: Faker::Address.state_abbr,
          city: Faker::Address.city,
          zipcode: Faker::Address.postcode.gsub('-', ''),
          number: Faker::Address.building_number
        }
      }
    }
  end

  describe '#perform' do
    context 'with valid data' do
      it 'update proponent correctly' do
        params = ActionController::Parameters.new(valid_attributes)
        update = operation.new(params).call
        expect(update.name).to eq params[:proponent][:name]
      end
    end
  end
end
