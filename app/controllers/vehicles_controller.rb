class VehiclesController < ApplicationController
  before_action :set_check_user, only: [:new, :create, :edit, :update]

  def index
    if params[:license_plate]
      @vehicles = Vehicle.where(license_plate: params[:license_plate])
    else
      @vehicles = Vehicle.all
    end
  end

  def new
    @modality = Modality.find(params[:id])
  end

  def create
    @vehicle = Vehicle.create(set_params)
    if @vehicle.valid?
      redirect_to modality_path(set_params[:modality_id]), notice: "Veículo #{@vehicle.model} de placa: #{@vehicle.license_plate} cadastrado com sucesso"
    else
      @modality = Modality.find(set_params[:modality_id])
      flash.now[:alert] = 'Não foi possível cadastrar o veículo'
      render 'new'
    end
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
    @modality = @vehicle.modality
  end
  
  def update
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.update(set_params)
      redirect_to vehicles_path, notice: "Cadastro do veículo de placa #{@vehicle.license_plate} atualizado com sucesso"
    else
      flash.now[:alert] = 'Não foi possível atualizar o cadastro'
      @modality = @vehicle.modality
      render 'edit'
    end
  end
  
  private
  def select_status
    Vehicle.statuses.keys.map {|status| [status.titleize,status]}
  end
  
  def set_params
    params.require(:vehicle).permit(:license_plate, :brand, :model, :year, :capacity, :status, :modality_id)                          
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