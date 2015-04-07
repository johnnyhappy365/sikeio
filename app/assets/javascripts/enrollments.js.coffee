$ ->
  #invite page
  eventPrefix = ".enrollments-page.invite"
  $ = jQuery.getLocal(eventPrefix)
  $(document)
    .on 'submit', 'form', ->
      if $('[name="personal_info[type]"]:checked').length == 0
        swal
          title: '请先选择你的职业~'
          type: "error"
        return false



$ ->
  #pay page
  eventPrefix = ".enrollments-page.pay"
  $ = jQuery.getLocal(eventPrefix)
  $(document)
    .on 'click', '.start-course', ->
      if $('#have-paid').prop('checked')
        $('form').submit()
      else
        swal
          title: '请先通过支付宝付款再开始课程~'

    .on 'keyup', 'input.buddy-name', ->
      if $(this).val() != ''
        if $('.tuition .origin').text() == '589'
          $('.tuition .new').text '489'
          $('.tuition .origin').addClass 'invalid'
      else
        if $('.tuition .new').text() == '489'
          $('.tuition .new').text ''
          $('.tuition .origin').removeClass 'invalid'






