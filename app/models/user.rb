class User < ApplicationRecord
    EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)[^@\.]+\z/

    #Verifica se os campos foram preenchidos.
    validates_presence_of :email, :full_name, :location
    
    #Verifica o tamanho do campo bio e bloqueia o mesmo de ser vazio.
    validates_length_of :bio, minimun: 30, allow_blank: false
   
    #Valida o formato do email e verifica se o mesmo já não está cadastrado para outro usuário.
    validate do
        errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
    end

    #Class macro responsável por fazer a encriptação da senha do usuário.
    #Quando utilizar o has_secure_password, retirar todas as validações de senha pois ele já as inclui.
    has_secure_password

    #Executa um callback antes da criação do modelo. before_create é um callback do ActiveRecord
    before_create do |user|
        user.confirmation_token = SecureRandom.urlsafe_base64
    end

    #Verifica se o usuário foi confirmado, caso seja, define a hora corrente, limpa o token e salva o modelo.
    def confirm!
        return if confirmed?

        self.confirmed_at = Time.current
        self.confirmation_token = ''
        save!
    end

    #Verifica se a confirmação está presente. (Usuário com cadastro confirmado)
    def confirmed?
        confirmed_at.present?
    end
end
