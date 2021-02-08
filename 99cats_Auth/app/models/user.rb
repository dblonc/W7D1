class User < ApplicationRecord

    validates :password_digest, :session_token, presence: true
    validates :session_token, :username, uniqueness: true
    validates :user, presence: true

    attr_reader :password

    after_initialize :ensure_session_token 

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def self.reset_session_token
        session_token ||= SecureRandom::urlsafe_base64
    end

    def password=(password)

    end



end