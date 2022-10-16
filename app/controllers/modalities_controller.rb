class ModalitiesController < ApplicationController
  before_action :set_check_user, only: [:new, :create, :edit, :update]

 def index
  @modalities = Modality.all
  
 end

 def show
  @modality = Modality.find(params[:id])
 end

 def new
  @modality = Modality.new
 end

 def create
  @modality = Modality.create(set_params)
  if @modality.valid?
    redirect_to modality_path(@modality.id), notice: "Modalidade #{@modality.name} cadastrada com sucesso"
  else
    flash.now[:alert] = 'Não foi possível cadastrar a modalidade'
    render 'new'
  end
 end

 private
  def set_params 
    params.require(:modality).permit(:name, :min_distance, :max_distance, :min_weight, :max_weight, :tax, :status)
  end
  
  def set_check_user
    if !current_user.admin?
      return redirect_to root_path, alert: 'Você não tem permissão para realizar esta ação'
    end
  end

end