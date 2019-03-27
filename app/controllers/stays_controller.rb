class StaysController < ApplicationController
  def show
    @stay = Stay.find(params[:id])
    @payments = @stay.payments.rent
  end
end
