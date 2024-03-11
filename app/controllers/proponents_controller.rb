# frozen_string_literal: true

# app/controllers/proponents_controller.rb
class ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[show edit destroy]
  layout 'default'

  def index
    @proponents = Proponent.order(id: 'ASC').page(params[:page])
  end

  def show; end

  def new
    @proponent = Proponent.new
    @proponent.build_address
  end

  def create
    @proponent = Proponents::CreateService.new(params).call

    return redirect_to @proponent, notice: 'Proponent criado com sucesso.' if @proponent

    render :new
  end

  def edit; end

  def discount_inss
    salary = params[:salary].to_f

    discount = Proponents::CalcInssService.new(salary).call

    render json: { discount: }
  end

  def update
    @proponent = Proponents::UpdateService.new(params).call

    if @proponent
      redirect_to @proponent, notice: 'Proponent atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @proponent.destroy
    redirect_to proponents_url, notice: 'Proponent excluído com sucesso.'
  end

  private

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end
end
