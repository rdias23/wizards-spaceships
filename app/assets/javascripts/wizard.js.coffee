class Wizard
  @document_ready: ->
    $('body').on('click', '#login-form-btn', Wizard.show_login_form)
    $('body').on('click', '#cancel_btn', Wizard.hide_login_form)
    $('#simple-menu').sidr()
    $('body').on('mouseover', '.book_on_shelf', Wizard.book_shift)
    $('body').on('mouseout', '.book_on_shelf', Wizard.book_shift2) 
    $('body').chardinJs()
    $('body').on "chardinJs:stop", ->
      $('#login_form2').addClass("hide")
      console.log('chardingJs:stop')
      $('#gear-link').data('show_form', true)

    $('body').on "chardinJs:start", ->
      console.log('chardingJs:start')
      $('#gear-link').data('show_form', false)

    $('a[data-toggle="chardinjs"]').on 'click', (e) ->
      e.preventDefault()
      unless(window.location.pathname == "/home/index")  
        $('#login_form2').removeClass("hide") if $(this).data('show-form')
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

window.Wizard = Wizard

$(document).ready(Wizard.document_ready)
