class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :confirmable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  :provider, :uid, :name, :access_token, :confirmed_at, :reset_password_token, :phone
  # attr_accessible :title, :body

  has_many :subscriptions
  has_many :plans, :through => :subscriptions
  has_many :scans
  has_many :recipients
  has_many :events, :through => :recipients
  accepts_nested_attributes_for :subscriptions

  validates :phone, :length => {:minimum => 6, :maximum => 25}, :format => { :with => /\A\S[0-9\+\/\(\)\s\-]*\z/i }, :allow_blank => true


  def sms_notify(event)


  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  	user = User.where(:provider => auth.provider, :uid => auth.uid).first
  	unless user
  		user = User.create!(name:auth.extra.raw_info.name,
  			provider:auth.provider,
  			uid:auth.uid,
  			email:auth.info.email,
        access_token:auth.credentials.token,
        password:Devise.friendly_token[0,20],
        confirmed_at:Time.now
        )
  	end
  	user
  end

  
end
