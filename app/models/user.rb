class User < ApplicationRecord
    #Verifica se os campos foram preenchidos.
    validates_presence_of :email, :full_name, :location, :password
    
    #Garante a confirmação da senha antes de ser salva.
    validates_confirmation_of :password

    #Verifica o tamanho do campo bio e bloqueia o mesmo de ser vazio.
    validates_length_of :bio, :minimun => 30, :allow_blank => false

    #Valida o formato do email e verifica se o mesmo já não está cadastrado para outro usuário.
    validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)[^@\.]+\z/
    validates_uniqueness_of :email
end
