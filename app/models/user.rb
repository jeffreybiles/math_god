class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::MD5
    #Add more options here if needed
  end


  has_many :my_qualities, dependent: :destroy
  has_many :qualities, through: :my_qualities
  has_many :player_logs, dependent: :destroy
  has_many :creations, foreign_key: 'creator_id', as: :creator

  belongs_to :image
  belongs_to :universe, foreign_key: 'current_universe_id'
  #belongs_to :storylet, foreign_key: 'current_storylet_id'
  belongs_to :current_storylet, class_name: 'Storylet'

  validates_presence_of :name, :email
end
