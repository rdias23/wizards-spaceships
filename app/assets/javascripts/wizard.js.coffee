class Wizard
  @document_ready: ->
    $('body').on('click', '#login-form-btn', Wizard.show_login_form)
    $('body').on('click', '#cancel_btn', Wizard.hide_login_form)
    $('body').on('mouseover', '.book_on_shelf', Wizard.book_shift)
    $('body').on('mouseout', '.book_on_shelf', Wizard.book_shift2) 
    $('body').chardinJs()

    $('body').on('click', 'a#learn-more', Wizard.show_onboard)
    $('body').on "chardinJs:stop", ->
      $('#login_form2').addClass('hide')
      $('#learn-more').removeClass('learn-more-class2').addClass('learn-more-class')
      console.log('chardingJs:stop')

    $('body').on "chardinJs:start", ->
      $('#call_to_action').removeClass('hide')
      $('#learn-more').removeClass('learn-more-class').addClass('learn-more-class2')
      console.log('chardingJs:start')

    $('#login_form2').on "chardinJs:start", ->
      console.log('chardingJs:start')

    $('a[data-toggle="chardinjs"]').on 'click', (e) ->
      e.preventDefault()
      unless(window.location.pathname == "/home/index")  
        $('#login_form2').removeClass("hide") if $(this).data('show-form')
      $('#onboard').addClass('total_transparency')
      ($('body').data('chardinJs')).toggle()


  @show_login_form: ->
    if $('#login_form2').hasClass('hide')
      $('#login_form2').removeClass('hide')
    else
      window.location.href = '/'
      console.log("Login form is already visible")

  @hide_login_form: ->
    window.location.href = '/'

  @book_shift: ->
    $(this).css("width", "210px").css("height", "34px").css("margin-left", "-20px")

  @book_shift2: ->
    $(this).css("width", "200px").css("height", "30px").css("margin-left", "0px")
  
  @show_onboard: ->
    $('#onboard').show()
    $('#onboard').removeClass('total_transparency')
    $('#call_to_action').addClass('hide')
    $('#login_form2').addClass('hide')
    $('body').chardinJs('stop')

window.Wizard = Wizard

$(document).ready(Wizard.document_ready)
