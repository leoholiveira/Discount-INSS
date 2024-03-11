# frozen_string_literal: true

# Service Call INSS
module Proponents
  # Call INSS
  class CalcInssService
    attr_reader :salary

    def initialize(salary)
      @salary = salary.to_f
    end

    def call
      if salary <= 1045.00
        (salary * 0.075).truncate(2)
      elsif salary <= 2089.60
        medium_salary(salary)
      elsif salary <= 3134.40
        big_salary(salary)
      else
        high_salary(salary)
      end
    end

    def medium_salary(salary)
      discount = (1045.00 * 0.075).truncate(2)
      discount += ((salary - 1045.00) * 0.09).truncate(2)
      discount.truncate(2)
    end

    def big_salary(salary)
      discount = (1045.00 * 0.075).truncate(2)
      discount += ((2089.60 - 1045.00) * 0.09).truncate(2)
      discount += ((salary - 2089.60) * 0.12).truncate(2)
      discount.truncate(2)
    end

    def high_salary(salary)
      discount = (1045.00 * 0.075).truncate(2)
      discount += ((2089.60 - 1045.00) * 0.09).truncate(2)
      discount += ((3134.40 - 2089.60) * 0.12).truncate(2)
      discount += ((salary - 3134.40) * 0.14).truncate(2)
      discount.truncate(2)
    end
  end
end
