# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#
class User < ApplicationRecord

    validates :password_digest, :session_token, presence: true
    validates :session_token, :username, uniqueness: true
    validates :username, presence: true

    attr_reader :password

    after_initialize :ensure_session_token 

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64 #makes sure each user gets a session token
    end

    def self.reset_session_token
        session_token ||= SecureRandom::urlsafe_base64
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        password_obj = BCrypt::Password.new(self.password_digest) #.new comes form bcrypt Password class. NOT THE SAME AS ACTIVE REC
        password_obj.is_password?(password)  #read this as comparing password_digest with password
    end

    def self.find_by_credentials(username, password)  #searching the active rec find by method to search data table
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            return user
        else
            return nil
        end
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

end
