namespace :reminders do
  desc 'Send out reminder emails'
  task email: :environment do
    Bill.find_each do |bill|
      BillMailer.reminder_email(bill).deliver if bill.should_send_reminder?
    end
  end
end
