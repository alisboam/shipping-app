class DeliveryTimesController < ApplicationController
  before_action :set_check_user, only: [:new, :create, :edit, :update]
  
  def index
    @delivery_times = DeliveryTime.all
  end

  def new
    @modality = Modality.find(params[:id])
    @delivery_time = DeliveryTime.new
  end

  def create
    @delivery_time = DeliveryTime.create(set_params)
    if @delivery_time.valid?
      redirect_to modality_path(set_params[:modality_id]), notice: 'Prazo cadastrado com sucesso'
    else
      @modality = Modality.find(set_params[:modality_id])
      flash.now[:alert] = 'Não foi possível cadastrar o prazo'
      render 'new'
    end
  end

  def edit
    @modality = Modality.find(params[:id])
    @delivery_time = DeliveryTime.find(params[:id])
  end

  def update
    @delivery_time = DeliveryTime.find(params[:id])
    if @delivery_time.update(set_params)
      redirect_to delivery_times_path, notice: 'Cadastro atualizado com sucesso'
    else
      @modality = Modality.find(params[:id])
      flash.now[:alert] = 'Não foi possível atualizar o cadastro'
      render 'edit'
    end
  end

 private
  def set_params 
    params.require(:delivery_time).permit(:distance_between, :hours, :modality_id)
  end

  def set_check_user
    if !current_user.admin?
      return redirect_to root_path, alert: 'Você não tem permissão para realizar esta ação'
    end
  end
end