# frozen_string_literal: true

# app/controllers/reports_controller.rb
class ReportsController < ApplicationController
  layout 'default'

  def index
    @salary_range = {
      'Até R$ 1.045,00' => Proponent.where('salary <= ?', 1045.00).count,
      'De R$ 1.045,01 a R$ 2.089,60' => Proponent.where('salary > ? AND salary <= ?', 1045.00, 2089.60).count,
      'De R$ 2.089,61 até R$ 3.134,40' => Proponent.where('salary > ? AND salary <= ?', 2089.60, 3134.40).count,
      'De R$ 3.134,41 até R$ 6.101,06' => Proponent.where('salary > ? AND salary <= ?', 3134.40, 6101.06).count,
      'A partir de 6.101,07' => Proponent.where('salary > ?', 6101.06).count
    }

    @chart_data = @salary_range.to_a
  end
end
