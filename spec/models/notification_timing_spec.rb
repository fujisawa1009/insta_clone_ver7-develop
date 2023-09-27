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
require 'rails_helper'

RSpec.describe NotificationTiming, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
