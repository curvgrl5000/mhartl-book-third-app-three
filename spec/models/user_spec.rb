# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  
  before do 
    @user = User.new(name: "Example User", email: "user@example.com",  # the instance var '@user' is equal to all the data colleected by ALL the hashes.
                     password: "foobar", password_confirmation: "foobar")
  end
  
  subject {  @user  }                 # the 'subject' method takes one argument, the instance var '@user'. Which means everything that '@user' represents
                                      # gets convenietnly referred to as 'it' below. Consider the object of 'subject' as a living breathing thing, like a person. 
                                      # A parallel analogy might be, she { should respond_to(:name) } Where subject = person, it = she.
                                      
  it { should respond_to(:name)  }                  # 'it' ( the data referenced from @user > subject > it ) should respond_to a name attribute 
  it { should respond_to(:email) }                  # 'it' ( the data referenced from @user > subject > it ) should respond_to a email attribute
  
  it { should respond_to(:password_digest) }        # 'it' ( the data referenced from @user > subject > it ) should respond_to a password_digest attribute
  it { should respond_to(:password) }               # 'it' ( the data referenced from @user > subject > it ) should respond_to a password attribute
  it { should respond_to(:password_confirmation) }  # 'it' ( the data referenced from @user > subject > it ) should respond_to a password_confirmation attribute
  it { should respond_to(:authenticate) }
  
  it { should be_valid }                            # a sanity check
  
  describe "when name is not present" do            # Sets up the default condition of a user's presence as it's being created in the lifecycle prior to saving
    before { @user.name = " " }                     # Because of it's temperal condition, the condition of a record must be understaod in all spectrums of timing
    it { should_not be_valid }                      # And this includes when a record is being created but has not yet been saved.
  end
  
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end
  
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    
    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end 
  
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end  
  
  describe "return value of authentication method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }
    
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
end
