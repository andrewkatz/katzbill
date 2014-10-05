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
end
