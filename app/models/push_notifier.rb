class PushNotifier < Notifier
  def notify(user, bill)
    notified = client.notify(user.pushover_user_key, message(bill), title: title(bill)).ok?
    puts "Failed to send push notification for bill:#{bill.id} user:#{user.id}" unless notified
    notified
  end

  private

  def client
    @client ||= Rushover::Client.new(ENV['PUSHOVER_API_TOKEN'])
  end
end
