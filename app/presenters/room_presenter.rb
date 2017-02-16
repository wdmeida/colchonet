class RoomPresenter
    delegate :user, :created_at, :description, :location, :title, :to_param, :reviews, to: :@room 

    def self.model_name
        Room.model_name
    end

    def initialize(room, context, show_form=true)
      @context = context
      @room = room
      @show_form = show_form
    end

    def can_review?
        @context.user_signed_in?
    end

    def show_form?
        @show_form
    end

    def review
        @review ||= @room.reviews.
            find_or_initialize_by(user_id: @context.current_user.id)
    end

    def review_route
        [@room, review]
    end

    def route
        @room
    end

    def review_points
        Review::POINTS
    end

    def stars
        @room.reviews.stars
    end

    def total_reviews
        #Para contar Arrays de objetos no ActiveRecord, utilizar sempre size, em detrimento aos outros dois 
        #métodos (length, count), pelo fato dos mesmos se comportarem de maneira diferente em escopos e modelos
        #ActiveRecord. Eles se comportam da seguinte maneira:
        #
        #lenght - É o mesmo do Array, portanto faz com que o ActiveRecord busque todos os objetos no banco,
        #intancie-os e depois faça a contagem;
        #
        #count - Conta quantos objetos existem no banco, fazendo uma consulta SQL ou usando o counter cache;
        #
        #size - Chama a contagem pelo método #lenght caso os objetos tenham sido carregados, caso contrário,
        #conta via o método #count.
        @room.reviews.size
    end

    #Faz com que a partial 'room' seja renderizada quando chamamos o 'render'
    #com o objeto da classe room presenter.
    def to_partial_path
        'room'
    end
end