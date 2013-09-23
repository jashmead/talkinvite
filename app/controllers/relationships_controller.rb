class RelationshipsController < ApplicationController
  before_action :signed_in_person

  def create
    ## find the person corresponding to the person we want to follow (followed_id)
    ## therefore done from the followers point of view!
    @person = Person.find(params[:relationship][:followed_id])
    current_person.follow!(@person)
    ## this respond_to has NOTHING to do with the respond_to used by rspec
    respond_to do |format|
      ## only ONE of these lines will be executed!
      format.html { redirect_to @person }   # and transfer control to the target person's page, reasonable enuf
      format.js
    end
  end

  def destroy
    ## find the relationship, then the followed person in it, i.e. the web page just has the relationship id#
    @person = Relationship.find(params[:id]).followed
    ## and now unfollow that person, again from the current person's perspective!
    current_person.unfollow!(@person)
    respond_to do |format|
      format.html { redirect_to @person }   # and transfer control to the target person's page, even tho we just unfollowed them?
      format.js
    end
  end

end
