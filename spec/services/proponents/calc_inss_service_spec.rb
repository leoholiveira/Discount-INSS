# frozen_string_literal: true

require 'rails_helper'

describe Proponents::CalcInssService, type: :service do
  let(:operation) { described_class }

  describe '#perform' do
    context 'with valid data' do
      it 'calc inss correctly' do
        response = operation.new(3000).call
        expect(response).to eq 281.62
      end

      it 'calc inss incorrect' do
        response = operation.new('a').call
        expect(response).to eq 0.0
      end
    end
  end
end
