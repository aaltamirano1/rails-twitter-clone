class ChangeMessageFormatInTweets < ActiveRecord::Migration[5.1]
  def change
  	change_column :tweets, :message, :text
  end
end
