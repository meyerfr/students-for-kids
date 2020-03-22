class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  def index
    @customers = Customer.all
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
    @customer.build_contact_info unless @customer.contact_info.present?
    @customer.customer_availabilities.build unless @customer.customer_availabilities.present?
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
    if @customer.update(customer_params)
      redirect_to @customer, notice: 'Customer was successfully updated.'
    else
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
    def set_customer
      @customer = Customer.find(params[:id])
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
        customer_availabilities_attributes: [
          :id,
          :_destroy,
          :start,
          :end
        ]
      )
    end
end
