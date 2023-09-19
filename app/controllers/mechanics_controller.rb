class MechanicsController < ApplicationController
  def show
    @mechanic = Mechanic.find(params[:id])

    if params[:ride_id].present?
      ride = Ride.find(params[:ride_id])
      @mechanic.rides << ride
      redirect_to mechanic_path(@mechanic)
    end
  end
end