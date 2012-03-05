class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :offer_code

  has_many :my_qualities, dependent: :destroy
  has_many :qualities, through: :my_qualities
  has_many :player_logs, dependent: :destroy
  has_many :creations, foreign_key: 'creator_id', as: :creator

  belongs_to :image
  belongs_to :universe, foreign_key: 'current_universe_id'
  #belongs_to :storylet, foreign_key: 'current_storylet_id'
  belongs_to :current_storylet, class_name: 'Storylet'

  validates_presence_of :name, :email

  has_many :authentications

  def update_permissions(params)
    if params[:offer_code]
      if params[:offer_code] ==  ENV['admin_password']
        self.admin= true
      elsif params[:offer_code] == ENV['contributor_password']
        self.contributor= true
      end
    end
    self.player= true
    self.save
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] unless email
    self.name = omniauth['info']['name'] unless name
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

end
