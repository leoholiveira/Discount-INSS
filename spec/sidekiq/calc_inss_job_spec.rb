# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CalcInssJob, type: :job do
  it 'calculates INSS discount for a proponent' do
    proponent = create(:proponent, salary: 3000.0)

    expect do
      CalcInssJob.new.perform(proponent.id)
      proponent.reload
    end.to change { proponent.discount_inss }.from(nil).to(281.62)
  end
end
