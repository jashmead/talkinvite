class Talkinvite < ActiveRecord::Base

  def service_list
    [ 'talkinvite', 'dm', 'twitter', 'facebook', 'pinterest', 'reddit' ]
  end

  # use 'start' rather than 'new' (a Ruby key word) 
  #   -- announce not great either, suggests the talk was posted
  def talk_status_list
    [ 'start', 'posted', 'done', 'cancelled' ]
  end

end
