class PricesByWeightsController < ApplicationController
  before_action :check_user, only:[ :create, :edit, :update]
  def new
    @price_by_weight = PricesByWeight.new
  end

  def create
    @price_by_weight = PricesByWeight.create(set_params)
    if @price_by_weight.valid?
      redirect_to prices_path, notice: "Intervalo #{@price_by_weight.min_weight}Kg - #{@price_by_weight.max_weight}Kg cadastrado com sucesso"
    else
      flash.now[:notice] = 'Não foi possível cadastrar o intervalo'
      render 'new'
    end
  end

  def edit
    @price_by_weight = PricesByWeight.find(params[:id])
  end

  def update
    @price_by_weight = PricesByWeight.find(params[:id])
    if @price_by_weight.update(set_params)
      redirect_to prices_path, notice: 'Cadastro atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o cadastro'
      render 'edit'
    end
  end

  private
  def set_params 
    params.require(:prices_by_weight).permit(:min_weight, :max_weight, :price)
  end

  def check_user
   p !current_user.admin?
   p current_user
    if !current_user.admin?
    
      return redirect_to root_path, notice: 'Apenas administradores podem realizar esta ação'
    end
  end
end