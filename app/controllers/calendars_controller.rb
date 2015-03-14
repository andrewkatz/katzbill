class CalendarsController < ApplicationController
  def show
    user     = User.where(calendar_token: params[:token]).first!
    calendar = calendar_for_user(user, params[:calendar_type].try(:to_sym))

    respond_to do |format|
      format.ics { render text: calendar.to_ical }
    end
  end

  private

  def calendar_for_user(user, calendar_type = :bills)
    calendar = Icalendar::Calendar.new

    items = calendar_type == :paychecks ? user.paychecks : user.bills
    items.each do |item|
      event                     = Icalendar::Event.new
      event.dtstart             = item.try(:due_date) || item.try(:pay_date)
      event.dtstart.ical_params = { 'VALUE' => 'DATE' }
      if item.is_a? Paycheck
        event.summary = "#{item.name} pay day"
      else
        event.summary = "#{item.name} bill due"
      end
      calendar.add_event(event)
    end
    calendar.publish
    calendar
  end
end
