class UserDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  # rubocop:disable Metrics/MethodLength:
  def avatar_url(size = :origin)
    return 'http://placehold.jp/150x150.png' unless avatar.attached?

    command = case size
              when :thumb
                { resize_to_fill: [48, 48] }
              when :lg
                { resize_to_fill: [100, 100] }
              else
                false
              end
    image = command ? avatar.variant(command).processed : avatar
    h.rails_storage_proxy_url(image, only_path: true)
  end
  # rubocop:enable Metrics/MethodLength:
end
