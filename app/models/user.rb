class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :primer_nombre, :primer_apellido, :nombre_perfil,
            :email, :password, :password_confirmation, :provider, :uid
  
  has_many :statuses

  def nombre_completo
    primer_nombre + " " + primer_apellido           
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(primer_nombre: auth.extra.raw_info.first_name, primer_apellido: auth.extra.raw_info.last_name,
         nombre_perfil: auth.info.nickname, provider: auth.provider,
                    uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0,20]
        )
      end
    end
  end     
end
