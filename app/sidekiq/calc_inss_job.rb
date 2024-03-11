# frozen_string_literal: true

# Calc INSS to Proponent
class CalcInssJob
  include Sidekiq::Job

  def perform(id)
    proponent = Proponent.find(id)

    salary = proponent.salary.to_f

    proponent.discount_inss = Proponents::CalcInssService.new(salary).call
    proponent.save
  end
end
