class Message < ApplicationRecord
  belongs_to :subscriber, class_name: 'Subscriber', foreign_key: 'subscriber_id'
end
