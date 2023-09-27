# == Schema Information
#
# Table name: notification_timings
#
#  id          :bigint           not null, primary key
#  timing_type :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_notification_timings_on_timing_type  (timing_type) UNIQUE
#
class NotificationTiming < ApplicationRecord
end
