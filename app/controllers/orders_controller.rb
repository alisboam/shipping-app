class OrdersController < ApplicationController
  before_action :set_check_user, only: [ :new, :create]

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
    if @order.valid?
      redirect_to orders_path, notice: "Ordem de Serviço #{@order.code} gerada com sucesso"
    else
      flash.now[:alert] = 'Não foi possível gerar a OS'
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
    @modalities = Modality.search_modality_fit(@order)
  end

  def update
    order = Order.find(params[:id])
    if order.status != "pending"
      return redirect_to order_path(order.id), alert: 'OS já foi iniciada'
    end

    modality = Modality.find(params[:order][:modality_id])
    order.start_order(modality)

    redirect_to order_path(order.id), notice: 'OS iniciada com sucesso'
  end

  def close
    @order = Order.find(params[:id])
    if (@order.is_delayed and !params[:delay_reason].nil?) or !@order.is_delayed
      @order.close_order(params[:delay_reason])
      return redirect_to order_path(@order.id), notice: 'OS encerrada com sucesso'
    end
    render 'close'
  end

  def search
    @order = Order.find_by(code: params["search"])
  end
  
  private
  def set_params
    params.require(:order).permit(
      :sender_name, :sender_address, :receiver_name, :receiver_address, :distance_between, :product_code, 
      :weight, :width, :height, :status, :delivery_price, :delivery_time)
    end

  def set_check_user
    if !current_user.admin?
      return redirect_to root_path, alert: 'Você não tem permissão para realizar esta ação'
    end
  end
end