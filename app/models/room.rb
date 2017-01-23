class Room < ApplicationRecord
    #Verifica a presença dos campos.
    validates_presence_of :title, :location, :description
    
    #Valida a quantidade caracteres minimos inseridos no campo description.
    validates_length_of :description, minimun: 20, allow_blank: false

    def complete_name
        "#{title}, #{location}"
    end
end
