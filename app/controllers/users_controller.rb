class UsersController < ApplicationController
    #Cria um novo recurso.
    def new
        #Cria uma nova instância do modelo User e armazena em uma variável de instância @user.
        #O controller compartilha as variáveis de instância com o template.
        @user = User.new
    end

    #Salva o recurso criado.
    def create
        #O método params retorna um hash com todos os parâmetros enviados pelo usuário.
        @user = User.new(params[:user])
        if @user.save
            redirect_to @user, 
                        :notice => 'Cadastro criado com sucesso!'
        else
            render :new
        end
    end
end