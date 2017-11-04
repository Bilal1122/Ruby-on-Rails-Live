class Chat < ApplicationRecord
  has_many :subscribers
  has_many :messages, through: :subscribers, source: :messages
end
