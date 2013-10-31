class DropsLotsOfTables < ActiveRecord::Migration
  def self.up
    # note this foreign key didn't exist on talkinvite_test
    execute('alter table talks drop constraint talks2venues_fk')
    execute('alter table talks drop column venue_id')
    execute("drop table ads")
    execute("drop table attachments")
    execute("drop table calendars")
    execute("drop table credits")
    execute("drop table socials")
    execute("drop table tags")
    execute("drop table venues")
  end
end
