class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  def index
    if current_customer
      @bookings = current_customer.bookings
    elsif current_sitter
      @bookings = current_sitter.bookings
    elsif current_admin
      @bookings = Booking.all
    end
  end

  # GET /bookings/1
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  def create
    @booking = Booking.new(booking_params.except(:sa_id, :ca_id))
    if @booking.save
      SitterAvailability.find(booking_params[:sa_id]).update(booked: true)
      CustomerAvailability.find(booking_params[:ca_id]).update(booked: true)
      redirect_to bookings_path, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bookings/1
  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: 'Booking was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bookings/1
  def destroy
    @booking.destroy
    redirect_to bookings_url, notice: 'Booking was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def booking_params
      params.require(:booking).permit(:customer_id, :sitter_id, :starts_at, :ends_at, :sa_id, :ca_id)
    end
end
