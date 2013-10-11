class Wizard
  @document_ready: ->
    $('body').on('click', '#login-form-btn', Wizard.show_login_form)
    $('body').on('click', '#cancel_btn', Wizard.hide_login_form)

  @show_login_form: ->
    if $('#login_form2').hasClass('hide')
      $('#login_form2').removeClass('hide')
    else
      window.location.href = '/'
      console.log("Login form is already visible")

  @hide_login_form: ->
    window.location.href = '/'

window.Wizard = Wizard

$(document).ready(Wizard.document_ready)
