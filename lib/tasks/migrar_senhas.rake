# encoding: utf-8
namespace :app do
    desc "Encripta todas as senhas \
          que ainda não foram processadas \
          no banco de dados"
    task migrar_senhas: :environment do
        #Verifica se existe a senha esta salva no campo password. Se a encriptação tiver sido executada,
        #a pesquisa retornará nil (senha não encontrada).
        unless User.attribute_names.include? "password"
            puts "As senhas já foram migradas, terminando."
            return
        end

        #Realiza a encriptação da senha de cada user que ainda não foi realizada.
        User.find_each  do |user|
            puts "Migrando usuário ##{user.id} #{user.full_name}"
            
            #Obtém a senha e a encripta.
            unencripted_password = user.attributes['password']

            #Salva a mesma nos campos e 
            user.password = unencripted_password
            user.password_confirmation = unencripted_password
            user.save! 
        end
    end
end