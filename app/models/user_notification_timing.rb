# == Schema Information
#
# Table name: user_notification_timings
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  notification_timing_id :bigint           not null
#  user_id                :bigint           not null
#
# Indexes
#
#  idx_user_n_timings_on_user_id_and_n_timing_id              (user_id,notification_timing_id) UNIQUE
#  index_user_notification_timings_on_notification_timing_id  (notification_timing_id)
#  index_user_notification_timings_on_user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (notification_timing_id => notification_timings.id)
#  fk_rails_...  (user_id => users.id)
#
class UserNotificationTiming < ApplicationRecord
  belongs_to :user
  belongs_to :notification_timing

  # user_notification_timingが重複して作成されないようなバリデーション
  validates :user_id, uniqueness: { scope: :notification_timing_id }
end
