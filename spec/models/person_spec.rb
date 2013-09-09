require 'spec_helper'

describe Person do
  before { @person = Person.new( name: "Example person", email: "examplar@talkinvite.com",
    password: 'foobar', password_confirmation: 'foobar', person_type: 'sub' ) }

  subject { @person }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should respond_to(:screen_name) }
  it { should respond_to(:about_me) }
  it { should respond_to(:settings) }

  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:sub) }

  it { should be_valid }

  it { should_not be_admin }
  it { should_not be_sub }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end
  end

  describe "with sub attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:sub)
    end
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

end
