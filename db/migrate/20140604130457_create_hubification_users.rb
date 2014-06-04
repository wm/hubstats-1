class CreateHubificationUsers < ActiveRecord::Migration
  def change
    create_table :hubification_users do |t|
      t.string :login
      t.string :integer
      t.string :avatar_url
      t.string :url
      t.string :html_url
      t.string :followers_url
      t.string :following_url
      t.string :gists_url
      t.string :starred_url
      t.string :subscriptions_url
      t.string :organizations_url
      t.string :repos_url
      t.string :events_url
      t.string :received_events_url
      t.string :type
      t.boolean :site_admin
      t.timestamps
    end
  end
end
