class Public::CustomersController < ApplicationController
  def show
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer =  current_customer
    @customer.update(customer_params)
    redirect_to my_page_path
  end

  def check
  end

  def withdraw
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:post_code,:address,:telephone_number,:email)
  end


end
