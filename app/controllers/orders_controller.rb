class OrdersController < ApplicationController

  def index
    if params[:status]
      @orders = Order.where(status: params[:status])
    else
      @orders = Order.all
    end
  end
  
  def new
    @order = Order.new
  end

  def create
    @order = Order.create(set_params)
    p @order
    if @order.valid?
      redirect_to orders_path, notice: "Ordem de Serviço #{@order.code} gerada com sucesso"
    else
      flash.now[:notice] = 'Não foi possível gerar a OS'
      render 'new'
    end
    
  end

  def show
    @order = Order.find(params[:id])
    @modality = Modality.search_modality_fit(@order)
    @delivery_time = DeliveryTime.search_delivery_time_fit(@order)
  end

  def update
    
  end

  
  
  private
  def set_params
    params.require(:order).permit(
      :sender_name, :sender_address, :receiver_name, :receiver_address, :distance_between, :product_code, :weight, :width, :height)
    end
end