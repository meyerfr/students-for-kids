class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :correct_customer, only: [:edit, :update, :destroy]
  before_action -> { check_contact_info(current_customer || current_sitter) }, only: [:show, :index]

  # GET /customers
  def index
    @customers = customer_all_attributes_present
  end

  # GET /customers/1
  def show
    @contact_info = @customer.contact_info
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
    @districts_json = District.pluck(:name).to_json
    @customer.build_district unless @customer.district.present?
    @customer.build_contact_info unless @customer.contact_info.present?
    @customer.customer_availabilities.build(starts_at: "#{Date.tomorrow} 10", ends_at: "#{Date.tomorrow} 16") unless @customer.customer_availabilities.present?
    @customer.kids.build unless @customer.kids.present?
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer, notice: 'Customer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params.except(:district_attributes))
      district = District.find_by(name: customer_params[:district_attributes][:name])
      @customer.update(district_id: district.id)
      redirect_to @customer, notice: 'Customer was successfully updated.'
    else
      @customer.build_contact_info(customer_params[:contact_info_attributes]) unless @customer.contact_info.present?
      @districts_json = District.pluck(:name).to_json
      render :edit
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy
    redirect_to customers_url, notice: 'Customer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def customer_all_attributes_present
      Customer.select{ |c| c.contact_info.present? && c.contact_info.attributes.except('customer_id', 'sitter_id').all?{ |key, value| value.present? } && c.photo.attached? }
    end


    def set_customer
      @customer = Customer.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to(bookings_path, :notice => 'Kunde existiert nicht.')
    end

    def correct_customer
      unless current_customer?(@customer)
        flash.alert = t :no_access, scope: [:activerecord, :flashes], model: t(:customer, scope: [:activerecord, :models]), action: t(params[:action].to_sym, scope: [:actions])
        redirect_to customer_path(@customer)
      end
    end

    # Only allow a trusted parameter "white list" through.
    def customer_params
      params.require(:customer).permit(
        :contact_info_id,
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
          :customers_id
        ],
        kids_attributes: [
          :id,
          :_destroy,
          :first_name,
          :age
        ],
        district_attributes: [:name],
        customer_availabilities_attributes: [
          :id,
          :_destroy,
          :starts_at,
          :end_at
        ]
      )
    end
end
