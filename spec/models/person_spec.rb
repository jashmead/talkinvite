require 'spec_helper'

describe Person do
  before { @person = Person.new( name: "Example person", email: "examplar@talkinvite.com" ) }

  subject { @person }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:screen_name) }
  it { should respond_to(:about_me) }
  it { should respond_to(:screen_name) }
  it { should respond_to(:settings) }

  it { should be_valid }

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

end
