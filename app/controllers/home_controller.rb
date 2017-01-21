class HomeController < ApplicationController
    def index
        #Retorna 3 quartos de forma aleatória para serem exibidos.
        @rooms = Room.take(3)
    end
end