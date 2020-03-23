class SittersController < ApplicationController
  before_action :set_sitter, only: [:show, :edit, :update, :destroy]

  # GET /sitters
  def index
    @sitters = Sitter.all
  end

  # GET /sitters/1
  def show
    @contact_info = @sitter.contact_info
  end

  # GET /sitters/new
  def new
    @sitter = Sitter.new
  end

  # GET /sitters/1/edit
  def edit
    @sitter.build_contact_info unless @sitter.contact_info.present?
    @sitter.sitter_availabilities.build(start: "#{Date.tomorrow} 10", end: "#{Date.tomorrow} 16") unless @sitter.sitter_availabilities.present?
  end

  # POST /sitters
  def create
    @sitter = Sitter.new(sitter_params)
    if @sitter.save
      redirect_to @sitter, notice: 'Babysitter erfolgreich erstellt.'
    else
      render :new
    end
  end

  # PATCH/PUT /sitters/1
  def update
    if @sitter.update(sitter_params)
      redirect_to @sitter, notice: "Update erfolgreich."
    else
      @sitter.build_contact_info(sitter_params[:contact_info_attributes]) unless @sitter.contact_info.present?
      render :edit
    end
  end

  # DELETE /sitters/1
  def destroy
    @sitter.destroy
    redirect_to sitters_url, notice: 'Babysitter erfolgreich gelöscht.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sitter
      @sitter = Sitter.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sitter_params
      params.require(:sitter).permit(
        :age,
        :contract_data_id,
        :photo,
        contact_info_attributes: [
          :id,
          :first_name,
          :last_name,
          :street,
          :post_code,
          :city,
          :country,
          :phone,
          :bio,
          :sign_in_count,
          :last_sign_in,
          :sitters_id
        ],
        sitter_availabilities_attributes: [
          :id,
          :_destroy,
          :start,
          :end
        ]
      )
    end
end
