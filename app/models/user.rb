class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    before_save :downcase_email

    validates :name, presence: true, length: {maximum: 50}
    # presence: ton tai hay ko
    # uniqueness: duy nhat
    # scope: dung tren cot na0
    # case_sensitive: true ( phan bie chu hoa chu thuong )
    # numericality: true ( cho phep nhap ca so thuc va nguyen )
    # numericality: { only_integer: true } chi cho phep nhap integer
    # 
    validates :email, presence: true, length: {maximum: 50},
        format: {with: VALID_EMAIL_REGEX}, uniqueness: true

    has_secure_password

    private
    
    def downcase_email
        self.email.downcase!
    end

    # Returns the hash digest of the given string.
    def User.digest string
        cost = if ActiveModel::SecurePassword.min_cost
                    BCrypt::Engine::MIN_COST
                else
                    BCrypt::Engine.cost
                end
        BCrypt::Password.create string, cost: cost
    end
end
