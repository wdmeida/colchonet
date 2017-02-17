class Room < ApplicationRecord
    extend FriendlyId

    #Define o relacionamento um para muitos, onde um quarto pode possuir muitas avaliações.
    has_many :reviews, dependent: :destroy
    
    #Define através da class macro belongs_to o relacionamento um para muitos. Através da
    #class macro, o ActiveRecord sabe qual objeto deve criar devido ao nome do relacionamento
    #(:user) e também já sabe qual campo usar para buscar o objeto devido (user_id).
    belongs_to :user

    #Verifica a presença dos campos.
    validates_presence_of :title, :location, :description, :slug

    mount_uploader :picture, PictureUploader
    friendly_id :title, use: [:slugged, :history]
    
    #Valida a quantidade caracteres minimos inseridos no campo description.
    validates_length_of :description, minimun: 20, allow_blank: false

    def self.search(query)
        if query.present?
            where(['location LIKE :query OR
                    title LIKE :query OR
                    description LIKE :query', query: "%#{query}%"])
        else
            all
        end
    end

    def complete_name
        "#{title}, #{location}"
    end

    def self.most_recent
        order(created_at: :desc)
    end
end
