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

    discount = calc_inss(salary)

    render json: { discount: discount.truncate(2) }
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

  def calc_inss(salary)
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

  def set_proponent
    @proponent = Proponent.find(params[:id])
  end
end
