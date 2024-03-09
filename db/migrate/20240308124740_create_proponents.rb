# frozen_string_literal: true

# Create Proponents
class CreateProponents < ActiveRecord::Migration[7.0]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :cpf
      t.date :birthdate
      t.decimal :salary
      t.decimal :discount_inss

      t.timestamps
    end
  end
end
