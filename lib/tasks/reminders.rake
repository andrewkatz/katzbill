namespace :reminders do
  desc 'Send out reminder emails'
  task email: :environment do
    User.notifiable_by_email.find_each do |user|
      user.bills.find_each do |bill|
        if bill.should_send_reminder?
          puts "Sending reminder email for bill ##{bill.id} to user ##{user.id}"
          BillMailer.reminder_email(user, bill).deliver
        end
      end
    end
  end

  desc 'Send out reminder push notifications'
  task pushover: :environment do
    notifier = PushNotifier.new
    User.notifiable_by_push.find_each do |user|
      user.bills.find_each do |bill|
        if bill.should_send_reminder?
          puts "Sending reminder push notification for bill ##{bill.id} to user ##{user.id}"
          notifier.notify(user, bill)
        end
      end
    end
  end

  desc 'Send out reminder SMS notifications'
  task sms: :environment do
    notifier = SMSNotifier.new
    User.notifiable_by_sms.find_each do |user|
      user.bills.find_each do |bill|
        if bill.should_send_reminder?
          puts "Sending reminder SMS notification for bill ##{bill.id} to user ##{user.id}"
          notifier.notify(user, bill)
        end
      end
    end
  end
end
