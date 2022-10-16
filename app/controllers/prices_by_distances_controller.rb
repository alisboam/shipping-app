class PricesByDistancesController < ApplicationController
  before_action :check_user, only:[ :new, :create, :edit, :update]

  def new
    @modality = Modality.find(params[:id])
    @price_by_distance = PricesByDistance.new
  end

  def create
    @price_by_distance = PricesByDistance.create(set_params)
    if @price_by_distance.valid?
      redirect_to modality_path(set_params[:modality_id]), notice: "Intervalo #{@price_by_distance.min_distance}Km - #{@price_by_distance.max_distance}Km cadastrado com sucesso"
    else
      @modality = Modality.find(set_params[:modality_id])
      flash.now[:alert] = 'Não foi possível cadastrar o intervalo'
      render 'new'
    end
  end

  def edit
    @modality = Modality.find(params[:id])
    @price_by_distance = PricesByDistance.find(params[:id])
  end

  def update
    @price_by_distance = PricesByDistance.find(params[:id])
    if @price_by_distance.update(set_params)
      redirect_to modality_path(set_params[:modality_id]), notice: 'Cadastro atualizado com sucesso'
    else
      @modality = Modality.find(params[:id])
      flash.now[:alert] = 'Não foi possível atualizar o cadastro'
      render 'edit'
    end
  end

  private
  def set_params 
    params.require(:prices_by_distance).permit(:min_distance, :max_distance, :price, :modality_id)
  end

  def check_user
    if !current_user.admin?
      return redirect_to root_path, alert: 'Apenas administradores podem realizar esta ação'
    end
  end

end