$ ->
  uploader = Qiniu.uploader
    runtimes: 'html5,flash,html4',
    browse_button: 'choosefiles',
    max_file_size: '4mb',
    flash_swf_url: '/plupload/Moxie.swf',
    uptoken_url: "/qiniu/resume-uptoken",
    domain: "http://7xknzl.com1.z0.glb.clouddn.com/",
    save_key: true,
    auto_start: true,
    init:
      'BeforeUpload': (up, file)->
        $("<div class='progress #{file.id}'>").appendTo('.progress-container')
        line = new ProgressBar.Line(".#{file.id}", {color: '#33B2E3'})
        $(".#{file.id}").data 'progress', line

      'UploadProgress': (up, file)->
        line = $(".#{file.id}").data 'progress'
        line.animate(file.percent / 100)

      'FileUploaded': (up, file, info)->
        domain = up.getOption('domain')
        res = JSON.parse(info)
        FileURL = domain + res.key;

        markdownImg = "#{FileURL}"
        doc = $('input#user_curriculum_vitae_url')

        doc.val "#{markdownImg}"

        window.setTimeout ->
          $(".#{file.id}").fadeOut()
        , 2000


      'Error': (up, err, errTip)->
        swal
          type: 'error'
          title: "文件上传出错误！"
          text: errTip

