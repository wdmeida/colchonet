//Define as ações que serão executadas nos eventos de callback no registro de avaliação.
$(function() {
    var $review = $('.review');

    //Executa uma ação antes do envio da requisição, com todos os dados já preparados.
    $review.on('ajax:beforeSend', function() {
        $(this).find('input').attr('disabled', true);
    });

    //Executa uma ação caso ocorra um erro retornado na reposta à requisição.
    $review.on('ajax:error', function() {
        replaceButton(this, 'icon-remove', '#B94A48');
    });

    //Executa uma ação em caso de a resposta da requisição seja de sucesso.
    $review.on('ajax:success', function() {
        replaceButton(this, 'icon-ok', '#468847');
    });

    //Altera o icone do input do formulário.
    function replaceButton(container, icon_class, color) {
        $(container).find('input:submit').
            replaceWith($('<i/>').
                        addClass(icon_class).
                        css('color', color));
    };
});