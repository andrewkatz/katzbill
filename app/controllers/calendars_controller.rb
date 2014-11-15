class CalendarsController < ApplicationController
  def show
    user     = User.where(calendar_token: params[:token]).first!
    calendar = calendar_for_user(user)

    respond_to do |format|
      format.ics { render text: calendar.to_ical }
    end
  end

  private

  def calendar_for_user(user)
    calendar = Icalendar::Calendar.new

    user.bills.each do |bill|
      event                     = Icalendar::Event.new
      event.dtstart             = bill.due_date
      event.dtstart.ical_params = { 'VALUE' => 'DATE' }
      event.summary             = "#{bill.name} bill due"
      calendar.add_event(event)
    end
    calendar.publish
    calendar
  end
end
