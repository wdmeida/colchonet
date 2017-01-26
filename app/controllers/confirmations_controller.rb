class ConfirmationsController < ApplicationController
    def show
        #O método find_by aceita um hash com os parÇametros para fazer a busca, e retornará
        #o primeiro resultado encontrado.
        user = User.find_by(confirmation_token: params[:token])

        if user.present?
            user.confirm!
            redirect_to user,
                notice: I18n.t('confirmations.success')
        else
            redirect_to root_path
        end
    end
end