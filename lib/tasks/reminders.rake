namespace :reminders do
  desc 'Send out reminder emails'
  task email: :environment do
    Bill.find_each do |bill|
      if bill.should_send_reminder?
        p "Sending reminder email for bill ##{bill.id}"
        BillMailer.reminder_email(bill).deliver
      end
    end
  end

  desc 'Send out reminder push notifications'
  task pushover: :environment do
    client = Rushover::Client.new(ENV['PUSHOVER_API_TOKEN'])

    User.with_pushover.find_each do |user|
      user.bills.find_each do |bill|
        if bill.should_send_reminder?
          p "Sending reminder push notification for bill ##{bill.id} to user ##{user.id}"

          title = "#{bill.days_left} #{pluralize(bill.days_left, 'day')} until #{bill.name} is due"
          message = "Due on #{bill.next_pay_date.strftime('%B %d-%')}"

          unless client.notify(user.pushover_user_key, message, title: title).ok?
            p "Failed to send push notification for bill ##{bill.id} to user ##{user.id}"
          end
        end
      end
    end
  end
end
