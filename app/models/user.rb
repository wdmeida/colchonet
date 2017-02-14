class User < ApplicationRecord
    EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)[^@\.]+\z/

=begin
    A class macro has_many faz várias coisas para descobrir o relacionamento. Primeiro, como é um
    relacionamento um-para-muitos (tem muitos), o nome do relacionamento deverá estar no plural e
    portanto, o modelo é o Room. Dada a natureza do relacionamento, o ActiveRecord sabe também que
    o modelo room deverá ter um campo para o próprio modelo user (user_id) e então finalmente, 
    consegue buscar todos os quartos que pertencem a um usuário.
    A notação dependent é parecida com o CASCADE do SQL, no caso, a opção destroy, faz com os callbacks
    sejam executados, destroindo todos os objetos relacionados ao usuário que esta sendo removido, garantindo
    que sejam apagados todos os quartos por eles cadastrados e todas as avaliações feitas. 
=end
    has_many :rooms, dependent: :destroy
    has_many :reviews, dependent: :destroy
    
    #Cria um escopo nomeado que retornará todos os usuários que tiveram as contas confirmadas.
    #confirmed_at não é nil.
    scope :confirmed, -> { where.not(confirmed_at: nil) }
    scope :most_recent, -> { order('created_at DESC') }

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

    #Cria o método authenticate que faz a verificação do email e senha.
    def self.authenticate(email, password)
       confirmed.
            find_by(email: email).
            try(:authenticate, password)
    end
end
