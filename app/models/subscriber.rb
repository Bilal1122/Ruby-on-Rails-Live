class Subscriber < ApplicationRecord
  belongs_to :chat, touch: true
  has_many :messages
end
