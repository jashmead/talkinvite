class AddVenueIdToTalks < ActiveRecord::Migration
  def change
    add_reference :talks, :venue, index: true
    execute('alter table talks add constraint talks2venues_fk foreign key (venue_id) references venues (id) on delete set null on update set null')
  end
end
