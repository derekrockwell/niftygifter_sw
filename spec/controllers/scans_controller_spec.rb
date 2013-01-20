require 'spec_helper'

describe ScansController do

  def valid_attributes
    {}
  end

  def valid_session
    {}
  end


  before(:each) do 
    @user = FactoryGirl.create(:user_with_events)
    @user.confirm!
    sign_in @user    
  end

  describe "get index" do
    it "lists users scans" do
      get :index
      assigns(:scans).should eq @user.scans.limit(10)
    end

    it "renders index template" do
      get :index
      response.should render_template("index")
    end    
  end

  describe "get show" do
    it "shows a scan" do
      get :show, {'id' => @user.scans.first.id}
      assigns(:scan).should eq @user.scans.first
    end

    it "renders show template" do
      get :show, {'id' => @user.scans.first.id}
      response.should render_template("show")
    end    
  end  

  describe "find scan" do
    it "shows confirmation" do
      get :find, {'upc' => @user.scans.first.upc}
      assigns(:scan).should be_a_new(Scan)
    end

    it "renders confirmation" do
      get :find, {'upc' => @user.scans.first.upc}
      response.should render_template("find")
    end    
  end  

  describe "post create" do
    it "creates a new scan with new recipient and redirects to their wishlist" do
      post :create, :recipient => {:user_id => @user.id, :alias => "test"}, :scan_id => "844503001054"
      assert_equal Scan.unscoped.last.upc, "844503001054"
      assert_redirected_to recipient_path(Recipient.last)
    end    
  end

  describe "put update" do
    it "associates a new scan w/ an existing recipient" do

    end
  end

  describe "delete scan" do
    it "delete scan and redirect to root" do
      before_delete = Scan.count
      delete :destroy, :id => @user.scans.last
      assert_equal before_delete - 1, Scan.count
      assert_redirected_to scans_path
    end    
  end 

end
