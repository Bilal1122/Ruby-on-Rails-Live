class AddSubscriberIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :subscriber_id, :integer
  end
end
