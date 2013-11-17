class TalkValidator < ActiveModel::Validator
  def validate(talk_record)
    # note:  logger does  not work inside of a validate function
    # logger.debug("TalkValidator.validate: talk_record: #{talk_record.inspect}")
# TBD:  validate & give change to sign in or create a new account
=begin
    if talk_record.person.name == 'anonymous'
      record.errors[:anonymous] << 'talks have to have an originator (other than anonymous)'
    end
=end
  end
end
