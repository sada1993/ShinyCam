
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

videoOutput = function(id,width = 640,height=480){
  ns = NS(id)
  video_id = ns("video")
  button_id = ns("snap")
  canvas_id = ns("canvas")
  tagList(
    tags$video(id = video_id,
               width = width,
               height = height,
               autoplay = NA
    ),
    tags$button(id = button_id,"Snap Photo"),
    tags$canvas(id = canvas_id,width = width,height = height),
    tags$script(HTML({
      paste0("var video = document.getElementById('",video_id,"');",
              "var snap = document.getElementById('",button_id,"');",
              "var canvas = document.getElementById('",canvas_id,"');",
             "if(navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                  // Not adding `{ audio: true }` since we only want video now
                 navigator.mediaDevices.getUserMedia({ video: true }).then(function(stream) {
                 video.srcObject = stream;
                 video.play();
             });
            }",
            "var context = canvas.getContext('2d');
             // Trigger photo take
             snap.addEventListener('click', function() {
             context.drawImage(video, 0, 0, 640, 480);
             var imgAsDataURL = canvas.toDataURL();
             Shiny.onInputChange('image',imgAsDataURL);
             });")
    }))
  )
}

shinyUI(fluidPage(
  videoOutput("test3"),
  imageOutput("img")
  )
)
