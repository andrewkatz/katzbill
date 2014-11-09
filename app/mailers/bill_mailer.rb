class BillMailer < ActionMailer::Base
  default from: 'katzbill@andrewkatz.net'

  def reminder_email(bill)
    @bill = bill

    mail(
      to: bill.account.users.map(&:email),
      subject: "#{bill.days_left} until \"#{bill.name}\" is due"
    )
  end
end
