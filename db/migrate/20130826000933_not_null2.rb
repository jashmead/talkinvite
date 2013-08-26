class NotNull2 < ActiveRecord::Migration
  def change
    change_table :attachments do |t|
      t.change :person_id, :integer, { :null => false }
      t.change :name, :string, { :null => false }
      t.change :pathname, :string, { :null => false }
      t.change :attachable_type, :string, { :null => false }
      t.change :attachable_id, :string, { :null => false }
    end
    change_table :calendars do |t|
      t.change :person_id, :integer, { :null => false }
      t.change :time_point, :datetime, { :null => false, :default => Time.now }
      t.change :source, :string, { :null => false }
    end
    change_table :maps do |t|
      t.change :person_id, :integer, { :null => false }
      t.change :location_id, :integer, { :null => false, :default => "1" }
      t.change :source, :string, { :null => false }
    end
    change_table :posts do |t|
      t.change :person_id, :integer, { :null => false }
      t.change :talk_id, :integer, { :null => false }
      t.change :post_type, :string, { :null => false }
    end
    change_table :tags do |t|
      t.change :tag, :string, { :null => false }
      t.change :tag_type, :string, { :null => false, :default => '' }
      t.change :tagable_type, :string, { :null => false }
      t.change :tagable_id, :string, { :null => false }
    end
    change_table :talks do |t|
      t.change :summary, :string, { :null => false }
    end
    change_table :tweets do |t|
      t.change :content, :string, { :null => false }
    end
  end
end
