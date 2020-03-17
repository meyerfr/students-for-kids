class SittersController < ApplicationController
  before_action :set_sitter, only: [:show, :edit, :update, :destroy]

  # GET /sitters
  def index
    @sitters = Sitter.all
  end

  # GET /sitters/1
  def show
  end

  # GET /sitters/new
  def new
    @sitter = Sitter.new
  end

  # GET /sitters/1/edit
  def edit
  end

  # POST /sitters
  def create
    @sitter = Sitter.new(sitter_params)

    if @sitter.save
      redirect_to @sitter, notice: 'Sitter was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sitters/1
  def update
    if @sitter.update(sitter_params)
      redirect_to @sitter, notice: 'Sitter was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sitters/1
  def destroy
    @sitter.destroy
    redirect_to sitters_url, notice: 'Sitter was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sitter
      @sitter = Sitter.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sitter_params
      params.require(:sitter).permit(:age, :contract_data_id)
    end
end
