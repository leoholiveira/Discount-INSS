# frozen_string_literal: true

# Calc INSS to Proponent
class CalcInssJob
  include Sidekiq::Job

  def perform(id)
    proponent = Proponent.find(id)

    salary = proponent.salary.to_f

    proponent.discount_inss = calculate(salary)
    proponent.save
  end

  def calculate(salary)
    discount = if salary <= 1045.00
                 (salary * 0.075).truncate(2)
               elsif salary <= 2089.60
                 medium_salary(salary)
               elsif salary <= 3134.40
                 big_salary(salary)
               else
                 high_salary(salary)
               end

    discount.truncate(2)
  end

  private

  def medium_salary(salary)
    discount = (1045.00 * 0.075).truncate(2)
    discount += ((salary - 1045.00) * 0.09).truncate(2)
    discount
  end

  def big_salary(salary)
    discount = (1045.00 * 0.075).truncate(2)
    discount += ((2089.60 - 1045.00) * 0.09).truncate(2)
    discount += ((salary - 2089.60) * 0.12).truncate(2)
    discount
  end

  def high_salary(salary)
    discount = (1045.00 * 0.075).truncate(2)
    discount += ((2089.60 - 1045.00) * 0.09).truncate(2)
    discount += ((3134.40 - 2089.60) * 0.12).truncate(2)
    discount += ((salary - 3134.40) * 0.14).truncate(2)
    discount
  end
end
