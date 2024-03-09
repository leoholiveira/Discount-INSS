# frozen_string_literal: true

# Service Proponents
module Proponents
  # Create Proponent
  class CreateService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      @proponent = Proponent.new(proponent_params)

      if @proponent.save
        CalcInssJob.perform_async(@proponent.id)
        return @proponent
      end
      false
    end

    private

    def proponent_params
      params.require(:proponent).permit(:name, :cpf, :birthdate, :salary,
                                        address_attributes: %i[street city neighborhood state zipcode number id])
    end
  end
end
