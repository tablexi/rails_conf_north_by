class SchedulesController < ApplicationController
  def show
    @concerts = Concert.includes(:venue, gigs: :band).all
    @schedule_days = {}
    @concerts.group_by(&:start_day).each do |day, concerts|
      @schedule_days[day] = concerts
    end
    @schedule = @schedule_days.sort.to_h

    respond_to do |format|
      format.html
      format.json { render json: @concerts }
    end
  end

end
