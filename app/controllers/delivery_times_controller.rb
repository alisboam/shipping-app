class DeliveryTimesController < ApplicationController
  before_action :set_check_user, only: [:new, :create, :edit, :update]
  
  def index
    @delivery_time = DeliveryTime.all
  end

  def new
    @delivery_time = DeliveryTime.new
  end

  def create
    @delivery_time = DeliveryTime.create(set_params)
    if @delivery_time.valid?
      redirect_to delivery_times_path, notice: 'Prazo cadastrado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível cadastrar o prazo'
      render 'new'
    end
  end


 

 private
  def set_params 
    params.require(:delivery_time).permit(:distance_between, :hours)
  end

  def set_check_user
    if !current_user.admin?
      return redirect_to root_path, notice: 'Você não tem permissão para realizar esta ação'
    end
  end

end