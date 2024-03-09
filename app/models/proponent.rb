# frozen_string_literal: true

# Model Proponent
class Proponent < ApplicationRecord
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address

  paginates_per 5

  validates :name, :cpf, :birthdate, :salary, presence: true
end
