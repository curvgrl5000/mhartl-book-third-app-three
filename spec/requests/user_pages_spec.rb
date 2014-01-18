require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    before { visit user_path(user) }
    let(:user)  { FactoryGirl.create(:user) }

    
    it { should have_content(user.name) }
    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
  
  describe "signup" do
    before {  visit signup_path  }
    let(:submit) { "Create my account" }
    describe "with invalid information" do
        it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "after submission" do
        before { click_button submit }
        it { should have_selector('title', text: 'Sign Up') }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"      
      end  
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
                 
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }
        it { should have_selector('h1', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end  
  end
end


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# THIS IS ANOTHER WAY TO DO TEST THE CODE WITH FACTORY GIRL GEM: 
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# require 'spec_helper'
# 
# describe "User pages" do
# 
#   subject { page }
# 
#   describe "profile page" do
#     before { visit user_path(user) }
#     let(:user)  { FactoryGirl.create(:user) }
# 
#     
#     it { should have_content(user.name) }
#     it { should have_selector('h1', text: user.name) }
#     it { should have_selector('title', text: user.name) }
#   end
#   
#   
#   describe "signup" do
#     before {  visit signup_path  }
#     let(:submit) { "Create my account" }
# 
#     
#     describe "with invalid information" do
#       before do
#         fill_in "Name",         with: "Example User"
#         fill_in "Email",        with: "user@example.com"
#         fill_in "Password",     with: "foobar"
#         fill_in "Confirmation", with: "foobar"
#       end
#       
#       it "should create a user" do
#         expect { click_button submit }.to change(User, :count).by(1)
#       end
#     
#       describe "after submission" do
#         before { click_button submit }
# 
#         it { should_not have_selector('h1', text: 'Sign Up') }
#         it { should_not have_content('error') }
#       end
#     end
#     
#     describe "with valid information" do
#       let(:user)  { FactoryGirl.create(:user) }
#       it "should create a user" do
#         expect { click_button submit }.not_to change(User, :count).by(1)
#       end
#       
#            
#       describe "after saving the user" do
#         before { click_button submit }
#         let(:user) { User.find_by_email('user@example.com') }
# 
#         it { should have_selector('h1', text: '') }
#         it { should have_content('error') }
#       end
#     end  
#   end
# end   







