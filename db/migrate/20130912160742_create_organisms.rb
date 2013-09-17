class CreateOrganisms < ActiveRecord::Migration
  def self.up
    create_table :organisms do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :organisms
  end
end
