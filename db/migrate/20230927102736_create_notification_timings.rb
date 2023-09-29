class CreateNotificationTimings < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_timings do |t|
      t.integer :timing_type, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
