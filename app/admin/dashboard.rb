ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc{ I18n.t('active_admin.dashboard') }

  content title: proc{ I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'User Metrics' do
          ul do
            li "#{User.count} users"
            li "#{User.where('created_at >= ?', Time.zone.now.beginning_of_day).count} new users today"
            li "#{User.where('created_at >= ?', 7.days.ago).count} new users in past 7 days"
          end
        end
      end

      column do
        panel 'Payment Metrics' do
          ul do
            li "#{Payment.count} payments"
            li "#{Bill.count} bills"
            li "#{Paycheck.count} paychecks"
            li "#{Payment.where('created_at >= ?', Time.zone.now.beginning_of_day).count} new payments today"
            li "#{Payment.where('created_at >= ?', 7.days.ago).count} new payments in past 7 days"
          end
        end
      end
    end
  end
end
