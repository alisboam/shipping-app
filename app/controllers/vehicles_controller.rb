class VehiclesController < ApplicationController
  before_action :set_check_user, only: [:new, :create]
  def index
    @vehicles = Vehicle.all
  end

  def new
    set_check_user
  end

  def create
    set_check_user
    @vehicle = Vehicle.create(set_params)
    if @vehicle.valid?
      redirect_to vehicles_path, notice: 'Veículo cadastrado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível cadastrar o veículo'
      render 'new'
    end
  end
  
  
  private
  def select_status
    Vehicle.statuses.keys.map {|status| [status.titleize,status]}
  end
  
  def set_params
    params.require(:vehicle).permit(:license_plate, :brand, :model,                                                   
                                    :year, :capacity, :status)
  end
  
  def set_check_user
    if current_user.admin?
      @select_status = select_status
      @vehicle = Vehicle.new
    else
     return redirect_to root_path, notice: 'Você não tem permissão para realizar esta ação'
    end
  end
  
end