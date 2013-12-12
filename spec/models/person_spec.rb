require 'spec_helper'

describe Person do

  before do
    @person = Person.new( name: "Example person", email: "examplar@talkinvite.com",
      password: 'user1234', password_confirmation: 'user1234')
  end

  subject { @person }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:description) }

  # it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  # TBD: do we want to check for remember_token?  there are references to this in the 'devise' wiki
  # it { should respond_to(:remember_token) }

  # devise fields
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:reset_password_token) }
  it { should respond_to(:reset_password_sent_at) }
  it { should respond_to(:remember_created_at) }
  it { should respond_to(:sign_in_count) }
  it { should respond_to(:current_sign_in_at) }
  it { should respond_to(:last_sign_in_at) }
  it { should respond_to(:current_sign_in_ip) }
  it { should respond_to(:last_sign_in_ip) }

  # it { should respond_to(:authenticate_person) }

  it { should respond_to(:admin) }
  it { should respond_to(:talks) }
  # it { should respond_to(:to_people) }

  it { should respond_to(:members) }
  it { should respond_to(:posts) }

  it { should respond_to(:sent_messages) } 
  it { should respond_to(:receivers) }
  it { should respond_to(:received_messages) }
  it { should respond_to(:senders) }

  it { should be_valid }

  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @person.save!
      @person.toggle!(:admin)
    end
    it { should be_admin }
  end

  describe "when name is not present" do
    before { @person.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @person.name = 'a' * 81 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @person.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[person@foo,com person_at_foo.org example.person@foo.  foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @person.email = invalid_address
        expect(@person).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[person@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @person.email = valid_address
        expect(@person).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      person_with_same_email = @person.dup
      person_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @person.email = mixed_case_email
      @person.save
      expect(@person.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "when password is not present" do
    before do
      @person = Person.new(name: "Example person", email: "person@example.com",
        password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @person.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

=begin
  describe "return value of authenticate method" do
    before { @person.save }
    let(:found_person) { Person.find_by(email: @person.email) }

    describe "with valid password" do
      it { should eq found_person.authenticate(@person.password) }
    end

    describe "with invalid password" do
      let(:person_for_invalid_password) { found_person.authenticate("invalid") }

      it { should_not eq person_for_invalid_password }
      specify { expect(person_for_invalid_password).to be_false }
    end
  end

  describe "with a password that's too short" do
    before { @person.password = @person.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "remember token" do
    before { @person.save }
    its(:remember_token) { should_not be_blank }
  end
=end

  describe "talk associations" do
    before { @person.save }
    let!(:older_talk) do
      FactoryGirl.create(:talk, person: @person, created_at: 1.day.ago)
    end
    let!(:newer_talk) do
      FactoryGirl.create(:talk, person: @person, created_at: 1.hour.ago)
    end

    it "should have the right talks in the right order" do
      expect(@person.talks.to_a).to eq [newer_talk, older_talk]
    end

# TBD: fix destroy associated talks test for people
=begin
    # associated talks not getting destroyed as a result of messages being added?
    it "should destroy associated talks" do
      talks = @person.talks.to_a
      @person.destroy
      expect(talks).not_to be_empty
      talks.each do |talk|
        expect(Talk.where(id: talk.id)).to be_empty
      end
    end
=end

  end

# TBD:  get anonymous spec to work
=begin
  ## why isn't Person.anonymous getting called?
  describe "make sure anonymous exists" do
    
    # Person.anonymous is not getting called, curious
    ## let(:anonymous) { Person.anonymous }

    # next line is erroring out; can't test because it errors out very early
    ## expect(anonymous.name).to eq('anonymous')

  end
=end

end
