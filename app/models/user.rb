# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  validates :email, :password, presence: true
  validates :email, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
