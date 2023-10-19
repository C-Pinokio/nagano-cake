class Public::AddressesController < ApplicationController
  # before_action :authenticate_customer!
    
  def index
    @addresses = Address.all #current_customer.address.allへ変更すること
    @address = Address.new
    
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @addresses = current_customer.addresses.all
    @address.save
    
    # if @address.save
      # flash[:notice] = "配送先の保存に成功しました"
      
      redirect_to request.referer
    # else
      # render :index
    # end
  end
  
  
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "配送先の更新に成功しました"
      redirect_to addresses_path
    else
      render :edit
    end
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:notice] = "配送先を削除しました"
    redirect_to request.referer
    
  end
  
  private
  
  def address_params
    params.require(:address).permit(:postcode, :address, :name)
  end
    
end
