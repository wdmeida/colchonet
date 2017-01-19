class User < ApplicationRecord
    EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)[^@\.]+\z/

    #Verifica se os campos foram preenchidos.
    validates_presence_of :email, :full_name, :location, :password 
    
    #Verifica o tamanho do campo bio e bloqueia o mesmo de ser vazio.
    validates_length_of :bio, minimun: 30, allow_blank: false
   
    #Valida o formato do email e verifica se o mesmo já não está cadastrado para outro usuário.
    validate do
        errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
    end

    #Class macro responsável por fazer a encriptação da senha do usuário.
    has_secure_password
end
