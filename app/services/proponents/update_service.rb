# frozen_string_literal: true

# Service Proponents
module Proponents
  # Update Proponent
  class UpdateService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      @proponent = Proponent.find(params[:id])

      if @proponent.update(proponent_params)
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
