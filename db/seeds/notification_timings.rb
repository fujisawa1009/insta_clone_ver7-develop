puts 'Start inserting seed "notification_timings" ...'
NotificationTiming.find_or_create_by!(timing_type: :on_commented)
NotificationTiming.find_or_create_by!(timing_type: :on_liked)
NotificationTiming.find_or_create_by!(timing_type: :on_followed)