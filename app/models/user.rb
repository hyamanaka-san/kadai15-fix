class User < ApplicationRecord
    validates :name,presence: true,length: { maximum: 25 }
    
    validates :password,presence: true,length: { in: 6..25 }
    
    validates :email, presence: true, 
                
                
                
                format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                uniqueness: { case_sensitive: false }
    
    has_secure_password
    has_many :tasks
    
end
