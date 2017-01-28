class UserSession
    include ActiveModel::Model

    attr_accessor :email, :password
    validates_presence_of :email, :password

    #Define o construtor que receberá as informações para a sessão.
    def initialize(session, attributes={})
        puts attributes
        @session = session
        @email = attributes[:email]
        @password = attributes[:password]
    end

    def authenticate!
        user = User.authenticate(@email, @password)

        if user.present?
            store(user)
        else
            #Adiciona o erro ao :base, que não é um atributo mas sim o objeto como um todo.
            errors.add(:base, :invalid_login)
            false
        end
    end

    def store(user)
        @session[:user_id] = user.id
    end
end