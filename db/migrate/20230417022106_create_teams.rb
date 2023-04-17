class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.references :user, null: false, foreign_key: true
      t.string :customer_id
      t.datetime :active_until
      t.string :stripe_subscription_id
      t.string :plan_id

      t.timestamps
    end
  end
end
