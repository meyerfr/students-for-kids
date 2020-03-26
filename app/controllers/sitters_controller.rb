class SittersController < ApplicationController
  before_action :set_sitter, only: [:show, :edit, :update, :destroy]
  before_action :only_customers!, only: [:index]
  before_action :only_customers_or_correct_sitter!, only: [:show]
  before_action :correct_sitter, only: [:edit, :update, :destroy]
  before_action -> { check_contact_info(current_sitter || current_customer) }, only: [:show, :index]

  # GET /sitters
  def index
    if current_customer
      all_active_sitters = sitters_fitting_to_customer
      @matching_availabilities = only_overlapping_availabilities(all_active_sitters)
      @sitters = []
      @matching_availabilities.each{|ca_id, s_id_sa_ids| s_id_sa_ids.each{|s_id, sa_id| @sitters<<Sitter.find(s_id) unless @sitters.include?(Sitter.find(s_id))}}
    elsif current_admin
      @sitters = sitters_all_attributes_present
    end
  end

  # GET /sitters/1
  def show
    @contact_info = @sitter.contact_info
    if current_customer
      matching_availabilities = matching_availabilities_to_sitter(@sitter)
      @availabilities = {}
      matching_availabilities.each{|ca_id, s_id_sa_ids| s_id_sa_ids.each{|s_id, sa_id| @availabilities.store(ca_id, SitterAvailability.find(sa_id)) unless @availabilities.include?(SitterAvailability.find(sa_id))}}
    else
      @sitter_availabilities = @sitter.sitter_availabilities
    end
  end

  # GET /sitters/new
  def new
    @sitter = Sitter.new
  end

  # GET /sitters/1/edit
  def edit
    @districts = District.all
    @sitter.build_contact_info unless @sitter.contact_info.present?
    @sitter.sitter_availabilities.build(starts_at: "#{Date.tomorrow} 10", ends_at: "#{Date.tomorrow} 16") unless @sitter.sitter_availabilities.present?
    # @districts = %w(Oberkassel Niederkassel Lörick Meerbusch BilkAltstadt Unterbilk Oberbilk Flehe Fliegern Düsseltal Stockum Heerdt Rath Unterrath)
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
    if @sitter.update(sitter_params.except(:district_ids))
      @sitter.district_possibilities.destroy_all
      sitter_params[:district_ids].each{|id| @sitter.district_possibilities.create(district_id: id)}
      redirect_to @sitter, notice: "Update erfolgreich."
    else
      @sitter.build_contact_info(sitter_params[:contact_info_attributes]) unless @sitter.contact_info.present?
      @districts = District.all
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
  def matching_availabilities_to_sitter(sitter)
    overlapping_availabilities = {}
    current_customer.customer_availabilities.select{|ca| ca.booked != true}.each do |ca|
      ca_range = ca.starts_at..ca.ends_at
      overlapping_availabilities.store(ca.id, {})
      overlapping_availabilities[ca.id].store(sitter.id, [])
      sitter.sitter_availabilities.select{|sa| sa.booked != true}.each do |sa|
        sa_range = sa.starts_at..sa.ends_at
        if sa_range.cover?(ca_range) || sa_range == ca_range
          overlapping_availabilities[ca.id][sitter.id] << sa.id
        end
      end
    end
    return overlapping_availabilities
  end

  def sitters_all_attributes_present
    Sitter.select{ |s| s.contact_info.attributes.except('customer_id', 'sitter_id').all?{ |key, value| value.present? } && s.photo.attached? && s.sitter_availabilities.length.positive? }
  end

  def sitters_fitting_to_customer
    sitters = sitters_all_attributes_present
    sitters.select{|s| s.districts.include?(Customer.first.district)}
  end

  def only_overlapping_availabilities(sitters)
    # sitters = sitters_all_attributes_present
    overlapping_availabilities = {}
    if current_admin
      sitters.each do |s|
        s.sitter_availabilities.each do |sa|
          overlapping_availabilities.store(s, sa)
        end
      end
    else
      # hash{customer_availability_id => { sitter_id => { sitter_availability_id } } }
      current_customer.customer_availabilities.select{|ca| ca.booked != true}.each do |ca|
        ca_range = ca.starts_at..ca.ends_at
        overlapping_availabilities.store(ca.id, {})
        sitters.each do |sitter|
          # overlapping_availabilities.store(sitter.id, {})
          overlapping_availabilities[ca.id].store(sitter.id, [])
          sitter.sitter_availabilities.select{|sa| sa.booked != true}.each do |sa|
            sa_range = sa.starts_at..sa.ends_at
            if sa_range.cover?(ca_range) || sa_range == ca_range

              overlapping_availabilities[ca.id][sitter.id] << sa.id
            end
          end
        end
      end
    end
    return overlapping_availabilities
  end

  def set_sitter
    @sitter = Sitter.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to(bookings_path, :notice => 'Babysitter existiert nicht.')
  end

  def correct_sitter
    unless current_sitter == @sitter
      flash.alert = t :no_access, scope: [:activerecord, :flashes], model: t(:sitter, scope: [:activerecord, :models]), action: t(params[:action].to_sym, scope: [:actions])
      redirect_to sitter_path(@sitter)
    end
  end

  def only_customers!
    unless current_admin || current_customer
      flash.alert = t :no_access, scope: [:activerecord, :flashes, :index], model: t(:sitter, scope: [:activerecord, :models])
      redirect_to bookings_path
    end
  end

  def only_customers_or_correct_sitter!
    unless current_admin || current_customer || current_sitter == @sitter
      flash.alert = t :no_access, scope: [:activerecord, :flashes, :index], model: t(:sitter, scope: [:activerecord, :models])
      redirect_to bookings_path
    end
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
      district_ids: [],
      sitter_availabilities_attributes: [
        :id,
        :_destroy,
        :starts_at,
        :ends_at
      ]
    )
  end
end
