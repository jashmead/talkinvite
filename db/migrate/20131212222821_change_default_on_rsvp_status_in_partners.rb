class ChangeDefaultOnRsvpStatusInPartners < ActiveRecord::Migration
  def change
    change_column :partners, :rsvp_status, :string, { default: 'yes', null: nil }
  end
end
